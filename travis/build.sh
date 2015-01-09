#!/bin/sh
set -ev

mkdir -p build
cd build

if [ "windows" = "$TARGET_OS" ]; then
  cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake/Toolchain-cross-mingw32-linux.cmake -DUSER_ROOT_PATH=.. -DCMAKE_C_FLAGS=-I`pwd`/../common -DCMAKE_CXX_FLAGS=-I`pwd`/../common
else
  cmake ..
fi

cmake --build . -- VERBOSE=1

