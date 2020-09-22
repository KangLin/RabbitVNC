
# Check for zlib
find_package(ZLIB)
if(NOT ZLIB_FOUND)
    add_subdirectory(zlib)
endif()

add_subdirectory(rdr)
add_subdirectory(network)
add_subdirectory(Xregion)
add_subdirectory(rfb)
