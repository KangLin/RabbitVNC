project(vncviewer)

set(SOURCE_FILES
    buildTime.cxx
    CConn.cxx
    CConnOptions.cxx
    CConnThread.cxx
    ConnectingDialog.cxx
    ConnectionDialog.cxx
    DesktopWindow.cxx
    InfoDialog.cxx
    OptionsDialog.cxx
    UserPasswdDialog.cxx
    vncviewer.cxx
    )

set(HEAD_FILES
    CConn.h
    CConnOptions.h
    
    CConnThread.h
    ConnectingDialog.h
    ConnectionDialog.h
    DesktopWindow.h
    InfoDialog.h
    ListenServer.h
    ListenTrayIcon.h
    MRU.h
    OptionsDialog.h
    UserPasswdDialog.h
    )

add_executable(${PROJECT_NAME} ${HEAD_FILES} ${SOURCE_FILES} vncviewer.rc)
target_compile_definitions(${PROJECT_NAME} PRIVATE _WINDOWS WIN32)
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
