include_directories(${CMAKE_SOURCE_DIR}/common/javabin ${CMAKE_CURRENT_SOURCE_DIR})

set(VNCVIEWER_JAR_PATH ${CMAKE_SOURCE_DIR}/common/javabin/VncViewer.jar)
SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /SUBSYSTEM:CONSOLE ")

add_executable(winvnc4 WIN32
  buildTime.cxx
  JavaViewer.cxx
  ManagedListener.cxx
  QueryConnectDialog.cxx
  STrayIcon.cxx
  VNCServerService.cxx
  VNCServerWin32.cxx
  winvnc.cxx
  winvnc.rc)

target_link_libraries(winvnc4 rfb rfb_win32 Xregion network rdr ws2_32.lib)

if(BUILD_JAVA)
  set_source_files_properties(${CMAKE_CURRENT_BINARY_DIR}/winvnc.rc
    PROPERTIES OBJECT_DEPENDS ${CMAKE_SOURCE_DIR}/common/javabin/VncViewer.jar)
endif()

install(TARGETS winvnc4
  RUNTIME DESTINATION ${BIN_DIR}
)
