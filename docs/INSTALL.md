INSTALL
-------

### Compile tools:

1. cmake program

2. msvc for windows
   - Visual Studio 12(2013)
   - Visual Studio 14(2015)

3. g++
   * MinGW-W64 for windows
     - g++ version 4.8.2 (i686-posix-dwarf-rev3, Built by MinGW-W64 project)
   * MinGW-W64 for linux
     - g++
   * unix or linux
     - g++

### Compile:

1. On windows:
   * Native:
     - Install cmake program and set cmake bin program path into environment variable PATH
     - Install visual studio
     - Open command line on windows
     - Into source code root directory
     - mkdir build
     - cd build
     - cmake ..
     - cmake --build .
   * use mingw:
     - Into source code root directory
     - mkdir build
     - cd build
     - cmake ..
     - cmake --build .
     
2. On unix or linux:
   * Install cmake program and g++ compile tool
   * Into source code root directory
   * mkdir build
   * cd build
   * cmake ..
   * cmake --build .

3. On unix or linux, use mingw cross compile for windows
   * Install cmake program
   * Install mingw-w64
      - ubuntu 14.04
        + sudo apt-get install mingw-w64
      - ubuntu 12.04
        + sudo apt-get install g++-mingw-w64-x86-64 binutils-mingw-w64-i686
        + sudo apt-get install gcc-mingw-w64-i686 g++-mingw-w64
        + sudo apt-get install mingw-w64 mingw-w64-tools
   * Into source code root directory
   * mkdir build
   * cd build
   * cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake/Toolchain-cross-mingw32-linux.cmake -DUSER_ROOT_PATH=.. -DCOMPILER_PREFIX="i686-w64-mingw32"
   * cmake --build .
