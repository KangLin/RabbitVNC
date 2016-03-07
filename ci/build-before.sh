#!/bin/sh
set -e
sudo apt-get update -qq
if [ "windows" = "$TARGET_OS" ]; then
    sudo apt-get install gcc-mingw-w64-i686 g++-mingw-w64-i686 binutils-mingw-w64-i686
    sudo apt-get install mingw-w64 mingw-w64-tools mingw-w64-dev
elif [ "windows64" = "$TARGET_OS" ]; then
    sudo apt-get install g++-mingw-w64-x86-64 gcc-mingw-w64-x86-64 binutils-mingw-w64-x86-64 
    sudo apt-get install mingw-w64 mingw-w64-tools mingw-w64-dev
else 
    sudo apt-get install xorg-dev
fi
