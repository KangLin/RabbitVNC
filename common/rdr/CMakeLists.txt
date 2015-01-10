include_directories(${CMAKE_SOURCE_DIR}/common ${ZLIB_INCLUDE_DIRS})

set(INCLUDE_FILE_SOURCE
	Exception.h
	HexInStream.h
	MemOutStream.h
	types.h
	FdInStream.h
	HexOutStream.h
	OutStream.h
	ZlibInStream.h
	FdOutStream.h
	InStream.h
	RandomStream.h
	ZlibOutStream.h
	FixedMemOutStream.h
	MemInStream.h
	SubstitutingInStream.h
)

set(SOURCE_FILE
    Exception.cxx 
    FdInStream.cxx 
    FdOutStream.cxx
    HexInStream.cxx
    HexOutStream.cxx
    InStream.cxx
    RandomStream.cxx
    ZlibInStream.cxx
    ZlibOutStream.cxx
)

add_library(rdr STATIC
	${SOURCE_FILE}
	${INCLUDE_FILE_SOURCE}
    )

set(RDR_LIBRARIES ${ZLIB_LIBRARIES})
if(WIN32)
	set(RDR_LIBRARIES ${RDR_LIBRARIES} ws2_32)
endif()

target_link_libraries(rdr ${RDR_LIBRARIES})

if(UNIX)
  libtool_create_control_file(rdr)
endif()

#install library files
install(TARGETS rdr
   RUNTIME DESTINATION ${BIN_DIR}
   LIBRARY DESTINATION ${BIN_DIR}
   ARCHIVE DESTINATION ${LIB_DIR}
)

#install header files
INSTALL(FILES ${INCLUDE_FILE_SOURCE} DESTINATION "${INCLUDE_DIR}/rdr")