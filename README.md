RabbitVnc
---------

RabbitVnc is a cross-platform remote control library and program vnc-based.

Project address:https://github.com/KangLin/rabbitvnc

Build status:  [![Build Status](https://travis-ci.org/KangLin/rabbitvnc.png)](https://travis-ci.org/KangLin/rabbitvnc)

### Compile tools:

1. msvc for windows
   - Visual Studio 12(2013)
   - Visual Studio 14(2015)

2. g++
   * MinGW-W64 for windows
     - g++ version 4.8.2 (i686-posix-dwarf-rev3, Built by MinGW-W64 project)
   * MinGW-W64 for linux
     - g++
   * unix or linux
     - g++

### Compile:

1. On windows:
   * Native:
     - Set cmake bin program path into environment variable
     - Install visual studio
     - Open cmd
     - into source code root
     - mkdir build
     - cd build
     - cmake ..
     - cmake --build .
   * use mingw:
     - into source code root
     - mkdir build
     - cd build
     - cmake ..
     - cmake --build .
     
2. On unix or linux:
   * into source code root
   * mkdir build
   * cd build
   * cmake ..
   * cmake --build .

3. On unix or linux, use mingw compile for windows
   * Install mingw-w64 (ag: sudo apt-get install mingw-w64)
   * Into source code root
   * mkdir build
   * cd build
   * cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake/Toolchain-cross-mingw32-linux.cmake -DUSER_ROOT_PATH=.. -DCOMPILER_PREFIX="i586-mingw32msvc"
   * cmake --build .
   
