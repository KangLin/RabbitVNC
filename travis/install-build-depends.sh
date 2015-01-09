#!/bin/sh
set -ev
sudo apt-get update
if [ "windows" = "$TARGET_OS" ]; then
    sudo apt-get install mingw-w64-i686-dev
    sudo apt-get install mingw-w64-common 
    sudo apt-get install mingw-w64 mingw-w64-tools
else
    sudo apt-get install xorg-dev 
fi
