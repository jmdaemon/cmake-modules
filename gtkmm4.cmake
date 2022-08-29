find_package(PkgConfig REQUIRED)
pkg_check_modules(GTKMM4 REQUIRED gtkmm-4.0)
add_definitions(${GTKMM4_CFLAGS_OTHER})
link_directories(${GTKMM4_LIBRARY_DIRS})

# These variables are now available for you to use
# ${GTKMM4_LIBRARIES}, ${GTKMM4_INCLUDE_DIRS}
# They can be included into your CMake targets like:
#
# target_include_directories(${GTKMM4_BIN_NAME} PUBLIC ${GTKMM4_INCLUDE_DIRS})
# target_link_libraries(${GTKMM4_BIN_NAME} PRIVATE ${GTKMM4_LIBRARIES})
