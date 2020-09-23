project(vncviewer)

set(SOURCE_FILES
    buildTime.cxx
    ConnectingDialog.cxx
    OptionsDialog.cxx
    CConn.cxx
    ConnectionDialog.cxx
    UserPasswdDialog.cxx
    CConnOptions.cxx
    DesktopWindow.cxx
    vncviewer.cxx
    CConnThread.cxx
    InfoDialog.cxx
    )

set(HEAD_FILES
    CConn.h
    DesktopWindow.h
    OptionsDialog.h
    CConnOptions.h
    InfoDialog.h
    CConnThread.h
    ListenServer.h
    UserPasswdDialog.h
    ConnectingDialog.h
    ListenTrayIcon.h
    ConnectionDialog.h
    MRU.h
    )

add_executable(${PROJECT_NAME} ${HEAD_FILES} ${SOURCE_FILES} vncviewer.rc)

target_link_libraries(${PROJECT_NAME} PRIVATE rfb_win32 Xregion network)
target_link_options(${PROJECT_NAME} PRIVATE "/SUBSYSTEM:WINDOWS")

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
