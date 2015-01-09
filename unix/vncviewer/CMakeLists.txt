include_directories(${FLTK_INCLUDE_DIR})
include_directories(${GETTEXT_INCLUDE_DIR})

include_directories(${CMAKE_SOURCE_DIR}/common)
set(VNCVIEWER_SOURCES
  DesktopWindow.cxx
  CConn.cxx
  vncviewer.cxx
  buildtime.c)

add_executable(vncviewer ${VNCVIEWER_SOURCES})

target_link_libraries(vncviewer tx rfb network rdr Xregion)

if(X11_FOUND AND X11_XTest_LIB)
  add_definitions(-DHAVE_XTEST)
  target_link_libraries(vncviewer ${X11_XTest_LIB})
else()
  message(WARNING "No XTest extension.  x0vncserver will be view-only.")
endif()

if(X11_FOUND AND X11_Xdamage_LIB)
  add_definitions(-DHAVE_XDAMAGE)
  target_link_libraries(vncviewer ${X11_Xdamage_LIB})
else()
  message(WARNING "No DAMAGE extension.  x0vncserver will have to use the slower polling method.")
endif()

target_link_libraries(vncviewer ${X11_LIBRARIES})

install(FILES vncviewer.man DESTINATION ${MAN_DIR}/man1 RENAME vncviewer.1)
