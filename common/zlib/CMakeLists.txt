# It seems like gcc for Win32 doesn't support the visibility attribute,
# so disable it to make it stop complaining.
if(WIN32)
  add_definitions(-DNO_VIZ)
endif()

add_library(zlib STATIC 
    adler32.c
    compress.c
    crc32.c
    gzio.c
    uncompr.c
    deflate.c
    trees.c
    zutil.c
    inflate.c
    infblock.c
    inftrees.c
    infcodes.c
    infutil.c
    inffast.c)

set(INCLUDE_FILE_SOURCE 
	deflate.h
	infcodes.h
	inffixed.h
	infutil.h
  	zconf.h
  	zutil.h
	infblock.h
	inffast.h
 	inftrees.h
  	trees.h
	zlib.h
)
#install library files
install(TARGETS zlib
   RUNTIME DESTINATION ${BIN_DIR}
   LIBRARY DESTINATION ${BIN_DIR}
   ARCHIVE DESTINATION ${LIB_DIR}
)

#install header files
INSTALL(FILES ${INCLUDE_FILE_SOURCE} DESTINATION "${INCLUDE_DIR}/zlib")
