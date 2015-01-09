#!/bin/sh
set -ev
sudo apt-get update
if [ "windows" = "$TARGET_OS" ]; then
    sudo apt-get install gcc-mingw-w64
    sudo apt-get install mingw-w64 
fi
