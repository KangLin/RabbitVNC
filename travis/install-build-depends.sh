#!/bin/sh
set -ev
sudo apt-get update -qq
if [ "windows" != "$TARGET_OS" ]; then
    sudo apt-get install xorg-dev
#else 
    #sudo apt-get install mingw-w64-i686-dev
    #sudo apt-get install mingw-w64-common 
    #sudo apt-get install mingw-w64 mingw-w64-tools
fi
