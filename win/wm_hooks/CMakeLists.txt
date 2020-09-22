project(wm_hooks)
include_directories(${CMAKE_BINARY_DIR}/win ${CMAKE_CURRENT_SOURCE_DIR})

add_library(${PROJECT_NAME} SHARED
  ../wm_hooks/wm_hooks.cxx
  ../wm_hooks/wm_hooks.rc)

# We want the DLL to be named wm_hooks.dll rather than libwm_hooks.dll
set_target_properties(wm_hooks PROPERTIES PREFIX "")

set_target_properties(${PROJECT_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
    VERSION ${BUILD_VERSION})

install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
        COMPONENT Runtime
)
