project(vncconfig)

add_executable(${PROJECT_NAME} 
  buildtime.c
  vncExt.c
  vncconfig.cxx
  QueryConnectDialog.cxx)

target_link_libraries(${PROJECT_NAME} PRIVATE tx)

if(X11_FOUND AND X11_XTest_LIB)
  target_compile_definitions(${PROJECT_NAME} PRIVATE HAVE_XTEST)
  target_link_libraries(${PROJECT_NAME} PRIVATE ${X11_XTest_LIB})
else()
  message(WARNING "No XTest extension. x0vncserver will be view-only.")
endif()

if(X11_FOUND AND X11_Xdamage_LIB)
  target_compile_definitions(${PROJECT_NAME} PRIVATE HAVE_XDAMAGE)
  target_link_libraries(${PROJECT_NAME} PRIVATE ${X11_Xdamage_LIB})
else()
  message(WARNING "No DAMAGE extension.  x0vncserver will have to use the slower polling method.")
endif()

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

install(FILES ${PROJECT_NAME}.man
    DESTINATION ${CMAKE_INSTALL_DATADIR}/man1 RENAME ${PROJECT_NAME}.1
        COMPONENT Runtime)
