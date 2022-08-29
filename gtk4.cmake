find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK4 REQUIRED gtk4)
add_definitions(${GTK4_CFLAGS_OTHER})
link_directories(${GTK4_LIBRARY_DIRS})

# These variables are now available for you to use
# ${GTK4_LIBRARIES}, ${GTK4_INCLUDE_DIRS}
# They can be included into your CMake targets like:
#
# target_include_directories(${GTK4_BIN_NAME} PUBLIC ${GTK4_INCLUDE_DIRS})
# target_link_libraries(${GTK4_BIN_NAME} PRIVATE ${GTK4_LIBRARIES})
