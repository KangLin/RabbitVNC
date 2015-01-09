include_directories(${X11_INCLUDE_DIR})

include_directories(${CMAKE_SOURCE_DIR}/common)
include_directories(${CMAKE_SOURCE_DIR}/unix/tx)

add_executable(vncconfig 
  buildtime.c
  vncExt.c
  vncconfig.cxx
  QueryConnectDialog.cxx)

target_link_libraries(vncconfig tx rfb network rdr ${X11_LIBRARIES})

if(X11_FOUND AND X11_XTest_LIB)
  add_definitions(-DHAVE_XTEST)
  target_link_libraries(vncconfig ${X11_XTest_LIB})
else()
  message(WARNING "No XTest extension.  x0vncserver will be view-only.")
endif()

if(X11_FOUND AND X11_Xdamage_LIB)
  add_definitions(-DHAVE_XDAMAGE)
  target_link_libraries(vncconfig ${X11_Xdamage_LIB})
else()
  message(WARNING "No DAMAGE extension.  x0vncserver will have to use the slower polling method.")
endif()

install(TARGETS vncconfig DESTINATION ${BIN_DIR})
install(FILES vncconfig.man DESTINATION ${MAN_DIR}/man1 RENAME vncconfig.1)
