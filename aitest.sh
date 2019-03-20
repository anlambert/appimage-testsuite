#! /bin/bash

rm -rf /AppDir && mkdir /AppDir
cd /AppDir
#bsdtar xfp /AppImage
/AppImage --appimage-extract
timeout 20 /AppDir/squashfs-root/AppRun

retVal=$?
if [ $retVal -eq 124 ]; then
    exit 0
else
    exit $retVal
fi
