set(INCLUDE_FILE_SOURCE region.h  Xregion.h)

add_library(Xregion STATIC
  Region.c
  ${INCLUDE_FILE_SOURCE})

if(UNIX)
  libtool_create_control_file(Xregion)
endif()

#install library files
install(TARGETS Xregion
   RUNTIME DESTINATION ${BIN_DIR}
   LIBRARY DESTINATION ${BIN_DIR}
   ARCHIVE DESTINATION ${LIB_DIR}
)

#install header files
INSTALL(FILES ${INCLUDE_FILE_SOURCE} DESTINATION "${INCLUDE_DIR}/Xregion")