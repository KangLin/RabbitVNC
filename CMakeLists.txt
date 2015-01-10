#
# Setup
#

cmake_minimum_required(VERSION 2.8)

# Internal cmake modules
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)

include(CheckIncludeFiles)
include(CheckFunctionExists)
include(CheckLibraryExists)
include(CheckTypeSize)
include(CheckCSourceCompiles)
include(CheckCXXSourceCompiles)
include(CheckCSourceRuns)

include(CMakeMacroLibtoolFile)

project(rabbitvnc)
set(VERSION 0.1.00)

# The RC version must always be four comma-separated numbers
set(RCVERSION 0,1,00,0)

# Installation paths
set(BIN_DIR "${CMAKE_INSTALL_PREFIX}/bin")
set(DATA_DIR "${CMAKE_INSTALL_PREFIX}/share")
set(MAN_DIR "${DATA_DIR}/man")
set(LOCALE_DIR "${DATA_DIR}/locale")
set(DOC_DIR "${CMAKE_INSTALL_PREFIX}/share/doc/${CMAKE_PROJECT_NAME}-${VERSION}")

if(WIN32)
  set(BIN_DIR "${CMAKE_INSTALL_PREFIX}")
  set(DOC_DIR "${CMAKE_INSTALL_PREFIX}")
endif()

set(BUILD_TIMESTAMP "")
execute_process(COMMAND "date" "+%Y-%m-%d %H:%M" OUTPUT_VARIABLE BUILD_TIMESTAMP)

if(NOT BUILD_TIMESTAMP)
  set(BUILD_TIMESTAMP "")
else()
  string(REGEX REPLACE "\n" "" BUILD_TIMESTAMP ${BUILD_TIMESTAMP})
endif()

# Default to optimised builds instead of debug ones. Our code has no bugs ;)
# (CMake makes it fairly easy to toggle this back to Debug if needed)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

message(STATUS "CMAKE_BUILD_TYPE = ${CMAKE_BUILD_TYPE}")

message(STATUS "VERSION = ${VERSION}")
add_definitions(-DBUILD_TIMESTAMP="${BUILD_TIMESTAMP}")

if(WIN32)
  set(BUILD_WINVNC 1)
endif()

# Minimum version is Windows 2000 (5.0)
if(WIN32)
  if(NOT CMAKE_SIZEOF_VOID_P MATCHES 8)
    add_definitions(-D_WIN32_IE=0x0500 -D_WIN32_WINNT=0x0500)
  else()
    set(WIN64 1)
    # Win64 doesn't like us requesting a Windows version that didn't have
    # 64-bit support. Request XP (5.1) instead.
    add_definitions(-D_WIN32_IE=0x0501 -D_WIN32_WINNT=0x0501)
  endif()
endif()

if(CMAKE_SIZEOF_VOID_P MATCHES 8)
  message(STATUS "64-bit build")
else()
  message(STATUS "32-bit build")
endif()

# CMake doesn't properly support resource compilation with MinGW.  Boo!
if(MINGW)
  if(NOT DEFINED RC)
    set(CMAKE_RC_COMPILER_INIT windres)
  else()
    set(CMAKE_RC_COMPILER_INIT ${RC})
  endif()
  enable_language(RC)
  message(STATUS "Resource compiler: ${CMAKE_RC_COMPILER}")
  set(CMAKE_RC_COMPILE_OBJECT
    "<CMAKE_RC_COMPILER> <FLAGS> <DEFINES> -o <OBJECT> --output-format=coff <SOURCE>")
endif()

# MinGW64 has header support but no library support for IActiveDesktop, so we
# need to check for both the header and library and use our own implementation
# in common/os if either doesn't exist.
if(WIN32)
  check_c_source_compiles("#include <windows.h>\n#include <wininet.h>\n#include <shlobj.h>\nint main(int c, char** v) {IActiveDesktop iad; return 0;}" HAVE_ACTIVE_DESKTOP_H)
  check_c_source_compiles("#include <windows.h>\n#include <wininet.h>\n#include <shlobj.h>\nint main(int c, char** v) {GUID i = CLSID_ActiveDesktop; return 0;}" HAVE_ACTIVE_DESKTOP_L)
endif()

# X11 stuff. It's in a if() so that we can say REQUIRED
if(UNIX AND NOT (APPLE OR WIN32))
  find_package(X11 REQUIRED)
endif()

# Check for zlib
find_package(ZLIB)
option(USE_INCLUDED_ZLIB "Force use of the bundled zlib")
if(NOT ZLIB_FOUND)
  set(USE_INCLUDED_ZLIB 1)
endif()
if(USE_INCLUDED_ZLIB)
  message(STATUS "Using included zlib library")
endif()

# Check for socket functions
if(WIN32)
  set(CMAKE_EXTRA_INCLUDE_FILES winsock2.h ws2tcpip.h)
  set(CMAKE_REQUIRED_LIBRARIES ws2_32)
else()
  set(CMAKE_EXTRA_INCLUDE_FILES sys/socket.h)
  set(CMAKE_C_FLAGS ${CMAKE_C_FLAGS} -DVNC_SOCKLEN_T=socklen_t)
  set(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} -DVNC_SOCKLEN_T=socklen_t)
endif()
check_function_exists(inet_aton HAVE_INET_ATON)

add_subdirectory(common)

if(WIN32)
  add_subdirectory(win)
else()
  # No interest in building x related parts on Apple
  if(NOT APPLE)
    add_subdirectory(unix)
  endif()
endif()

# uninstall
configure_file("${CMAKE_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
  "cmake_uninstall.cmake" IMMEDIATE @ONLY)

add_custom_target(uninstall COMMAND ${CMAKE_COMMAND} -P cmake_uninstall.cmake)
