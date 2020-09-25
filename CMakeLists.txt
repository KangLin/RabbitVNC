cmake_minimum_required(VERSION 2.8.12)

if(POLICY CMP0083)
    cmake_policy(SET CMP0083 NEW)
endif()

if(POLICY CMP0020)
    cmake_policy(SET CMP0020 NEW)
endif()

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_STANDARD 98)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_VERBOSE_MAKEFILE ON CACHE BOOL "verbose")

# Internal cmake modules
set(CMAKE_MODULE_PATH
    ${CMAKE_SOURCE_DIR}/cmake/Modules
    ${CMAKE_SOURCE_DIR}/cmake)

# Uninstall 
CONFIGURE_FILE(
    "${CMAKE_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
    "${CMAKE_BINARY_DIR}/cmake_uninstall.cmake"
    IMMEDIATE @ONLY)
# Create the uninstall target
ADD_CUSTOM_TARGET(uninstall
    "${CMAKE_COMMAND}" -P "${CMAKE_BINARY_DIR}/cmake_uninstall.cmake")

SET(BUILD_VERSION "v0.0.4")
# Find Git Version Patch
IF(EXISTS "${CMAKE_SOURCE_DIR}/.git")
    if(NOT GIT)
        SET(GIT $ENV{GIT})
    endif()
    if(NOT GIT)
        FIND_PROGRAM(GIT NAMES git git.exe git.cmd)
    endif()
    IF(GIT)
        EXECUTE_PROCESS(
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            COMMAND ${GIT} describe --tags
            OUTPUT_VARIABLE GIT_VERSION  OUTPUT_STRIP_TRAILING_WHITESPACE
        )
        if(NOT GIT_VERSION)
            EXECUTE_PROCESS(
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
                COMMAND ${GIT} rev-parse --short HEAD
                OUTPUT_VARIABLE GIT_VERSION OUTPUT_STRIP_TRAILING_WHITESPACE
            )
        endif()
        SET(BUILD_VERSION ${GIT_VERSION})
    ENDIF()
ENDIF()
message("BUILD_VERSION:${BUILD_VERSION}")
set(VERSION ${BUILD_VERSION})

IF(MSVC)
    # This option is to enable the /MP switch for Visual Studio 2005 and above compilers
    OPTION(WIN32_USE_MP "Set to ON to build with the /MP option (Visual Studio 2005 and above)." ON)
    MARK_AS_ADVANCED(WIN32_USE_MP)
    IF(WIN32_USE_MP)
        #SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
        add_compile_options(/MP)
    ENDIF(WIN32_USE_MP)
    add_compile_options("$<$<C_COMPILER_ID:MSVC>:/utf-8>")
    add_compile_options("$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")
ENDIF(MSVC)

if(NOT WIN32)
    SET(BUILD_SHARED_LIBS ON CACHE BOOL "Build shared libs")
endif()
if (BUILD_SHARED_LIBS)
    add_definitions(-DBUILD_SHARED_LIBS)
    if (CMAKE_COMPILER_IS_GNUCXX AND NOT MINGW)
       # Just setting CMAKE_POSITION_INDEPENDENT_CODE should be enough to set
       # -fPIC for GCC but sometimes it still doesn't get set, so make sure it
       # does.
       add_definitions("-fPIC")
    endif()
    set(CMAKE_POSITION_INDEPENDENT_CODE ON)
else(BUILD_SHARED_LIBS)
    add_definitions(-DQT_STATICPLUGIN)
endif(BUILD_SHARED_LIBS)

# Default to optimised builds instead of debug ones. Our code has no bugs ;)
# (CMake makes it fairly easy to toggle this back to Debug if needed)
if(NOT DEFINED CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release")
endif(NOT DEFINED CMAKE_BUILD_TYPE)
if("Debug" STREQUAL CMAKE_BUILD_TYPE)
    add_definitions(-D_DEBUG)
endif()

message(STATUS "CMAKE_BUILD_TYPE = ${CMAKE_BUILD_TYPE}")

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)
include(GenerateExportHeader)
include(CheckIncludeFile)
include(CheckIncludeFileCXX)
include(CheckFunctionExists)
include(CheckLibraryExists)
include(CheckTypeSize)
include(CheckCSourceCompiles)
include(CheckCXXSourceCompiles)
include(CheckCSourceRuns)

include(CMakeMacroLibtoolFile)

project(RabbitVNC)
set(VERSION ${BUILD_VERSION})

SET(CPACK_PACKAGE_VERSION_MAJOR "${BUILD_VERSION}")
SET(CPACK_PACKAGE_DESCRIPTION "Rabbit Vnc")
SET(CPACK_PACKAGE_CONTACT "kl222@126.com")
SET(CPACK_PACKAGE_VENDOR "KangLin studio")
SET(CPACK_PACKAGE_ICON "${CMAKE_SOURCE_DIR}/AppIcon.ico")
include(CPack)

# The RC version must always be four comma-separated numbers
set(RCVERSION 0,1,00,0)

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

add_custom_target(install-runtime
  COMMAND
     "${CMAKE_COMMAND}" -DCMAKE_INSTALL_COMPONENT=Runtime 
     -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_install.cmake"
)

add_subdirectory(common)

option(BUILD_APP "Build applications" ON)
if(BUILD_APP)
    if(WIN32)
        add_subdirectory(win)
    else()
        # No interest in building x related parts on Apple
        if(NOT APPLE)
            add_subdirectory(unix)
        endif()
    endif()
endif()
