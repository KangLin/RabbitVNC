include_directories(${CMAKE_SOURCE_DIR}/common)

add_executable(conv conv.cxx)
target_link_libraries(conv RabbitVNC)

add_executable(convertlf convertlf.cxx)
target_link_libraries(convertlf RabbitVNC)

add_executable(hostport hostport.cxx)
target_link_libraries(hostport RabbitVNC)

add_executable(pixelformat pixelformat.cxx)
target_link_libraries(pixelformat RabbitVNC)

add_executable(unicode unicode.cxx)
target_link_libraries(unicode RabbitVNC)

if(BUILD_VIEWER AND FLTK_FOUND)
	include_directories(${CMAKE_SOURCE_DIR}/vncviewer)
	add_executable(gesturehandler gesturehandler.cxx ../../vncviewer/GestureHandler.cxx)
	target_link_libraries(gesturehandler RabbitVNC)

	add_executable(emulatemb emulatemb.cxx ../../vncviewer/EmulateMB.cxx)
	target_link_libraries(emulatemb RabbitVNC  ${GETTEXT_LIBRARIES})
endif()
