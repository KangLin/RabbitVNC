project(winvnc4)

#set(VNCVIEWER_JAR_PATH ${CMAKE_SOURCE_DIR}/common/javabin/VncViewer.jar)
set(SOURCE_FILES
    buildTime.cxx
    JavaViewer.cxx
    ManagedListener.cxx
    QueryConnectDialog.cxx
    STrayIcon.cxx
    VNCServerService.cxx
    VNCServerWin32.cxx
    winvnc.cxx
    )
add_executable(${PROJECT_NAME}
    ${SOURCE_FILES}
    winvnc.rc)

option(BUILD_JAVA "Build java" ON)
if(BUILD_JAVA)
    set_source_files_properties(${CMAKE_CURRENT_SOURCE_DIR_DIR}/winvnc.rc
        PROPERTIES OBJECT_DEPENDS ${CMAKE_SOURCE_DIR}/common/javabin/VncViewer.jar)
endif()

target_link_libraries(${PROJECT_NAME} PRIVATE rfb_win32 rfb Xregion network)

target_compile_options(${PROJECT_NAME} PRIVATE "/SUBSYSTEM:CONSOLE")

set_target_properties(${PROJECT_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    VERSION ${BUILD_VERSION})

INSTALL(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
    COMPONENT Runtime
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    COMPONENT Runtime
    )
