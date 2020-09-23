project(vncconfig)

include_directories(${CMAKE_BINARY_DIR}/win)

add_executable(${PROJECT_NAME} WIN32
  Legacy.cxx
  PasswordDialog.cxx
  vncconfig.cxx
  vncconfig.rc)

target_link_libraries(${PROJECT_NAME} PRIVATE rfb_win32 Xregion network)

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
