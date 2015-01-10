include_directories(${CMAKE_SOURCE_DIR}/common)

set(INCLUDE_FILE_SOURCE Socket.h TcpSocket.h)

add_library(network STATIC
  TcpSocket.cxx ${INCLUDE_FILE_SOURCE})

if(WIN32)
	target_link_libraries(network ws2_32)
endif()

if(UNIX)
  libtool_create_control_file(network)
endif()

#install library files
install(TARGETS network #ARCHIVE
   RUNTIME DESTINATION ${BIN_DIR}
   LIBRARY DESTINATION ${BIN_DIR}
   ARCHIVE DESTINATION ${LIB_DIR}
)

#install header files
INSTALL(FILES ${INCLUDE_FILE_SOURCE} DESTINATION "${INCLUDE_DIR}/network")
