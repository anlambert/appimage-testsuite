#! /bin/bash

ai="$1"
distro="$2"




IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $IP

if [ -e Dockerfile.${distro} ]; then
	(rm -rf build && mkdir build && cd build && cp -aL ../Dockerfile.${distro} Dockerfile && \
docker build -t photoflow/aitest-${distro} .) || exit 1
	image=photoflow/aitest-${distro}
else
	image=$distro
fi

chmod u+x "$ai"
docker run --rm -it -e DISPLAY=${IP}${DISPLAY} -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd):/aitest -v "$ai":/AppImage -v "$HOME":/shared --cap-add=SYS_PTRACE --security-opt seccomp:unconfined ${image} /aitest/aitest.sh
