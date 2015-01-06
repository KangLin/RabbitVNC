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

# uninstall
configure_file("${CMAKE_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
  "cmake_uninstall.cmake" IMMEDIATE @ONLY)

add_custom_target(uninstall COMMAND ${CMAKE_COMMAND} -P cmake_uninstall.cmake)
