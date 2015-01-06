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