# X11 stuff. It's in a if() so that we can say REQUIRED
if(UNIX AND NOT (APPLE OR WIN32))
  find_package(X11 REQUIRED)
endif()

add_subdirectory(tx) #user interface library
add_subdirectory(vncconfig)
add_subdirectory(vncpasswd)
add_subdirectory(vncviewer)
add_subdirectory(x0vncserver) #vnc simple server
