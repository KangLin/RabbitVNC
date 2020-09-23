
# Check for zlib
find_package(ZLIB)
if(NOT ZLIB_FOUND)
    add_subdirectory(zlib)
    list(APPEND RabbitVNC_FIND_COMPONENTS zlib)
endif()

add_subdirectory(Xregion)
add_subdirectory(rdr)
add_subdirectory(network)
add_subdirectory(rfb)
list(APPEND RabbitVNC_FIND_COMPONENTS Xregion rdr network rfb)

CONFIGURE_FILE(
    "${CMAKE_SOURCE_DIR}/cmake/RabbitVNCConfig.cmake.in"
    "${CMAKE_BINARY_DIR}/RabbitVNCConfig.cmake"
    IMMEDIATE @ONLY)
INSTALL(FILES "${CMAKE_BINARY_DIR}/RabbitVNCConfig.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/RabbitVNC")
