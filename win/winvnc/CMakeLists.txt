project(winvnc4)
include_directories(${CMAKE_SOURCE_DIR}/common/javabin ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_SOURCE_DIR}/common)

set(VNCVIEWER_JAR_PATH ${CMAKE_SOURCE_DIR}/common/javabin/VncViewer.jar)

if(NOT MINGW)
SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /SUBSYSTEM:CONSOLE ")
endif()

add_executable(${PROJECT_NAME} WIN32
  buildTime.cxx
  JavaViewer.cxx
  ManagedListener.cxx
  QueryConnectDialog.cxx
  STrayIcon.cxx
  VNCServerService.cxx
  VNCServerWin32.cxx
  winvnc.cxx
  winvnc.rc)

if(BUILD_JAVA)
  set_source_files_properties(${CMAKE_CURRENT_BINARY_DIR}/winvnc.rc
    PROPERTIES OBJECT_DEPENDS ${CMAKE_SOURCE_DIR}/common/javabin/VncViewer.jar)
endif()

set_target_properties(${PROJECT_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    VERSION ${BUILD_VERSION})

target_link_libraries(${PROJECT_NAME} PRIVATE rfb_win32 rfb Xregion network)

install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
        COMPONENT Runtime
)
