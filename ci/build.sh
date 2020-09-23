#!/bin/sh
set -e

mkdir -p build_$TARGET_OS
cd build_$TARGET_OS

if [ "windows" = "$TARGET_OS" ]; then
  cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake/Toolchain-cross-mingw32-linux.cmake \
    -DCOMPILER_PREFIX="i686-w64-mingw32" \
    -DCMAKE_INSTALL_PREFIX=`pwd`/install
elif [ "windows64" = "$TARGET_OS" ]; then
  cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake/Toolchain-cross-mingw32-linux.cmake \
    -DCOMPILER_PREFIX="x86_64-w64-mingw32" \
    -DCMAKE_INSTALL_PREFIX=`pwd`/install
else
  cmake ..  \
    -DCMAKE_INSTALL_PREFIX=`pwd`/install
fi

cmake --build . -- VERBOSE=1 "-j`cat /proc/cpuinfo |grep 'cpu cores' |wc -l`"
cmake --build . --target install
