# Manual Installs
# Set default manual installation directory to /usr/local
set(CMAKE_INSTALL_PREFIX /usr/local)

# Manual Uninstall Target
# Usage:
# cmake uninstall .
# sudo make uninstall or sudo ninja uninstall
if(NOT TARGET uninstall)
    file(TO_CMAKE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in" UNINSTALL_MODULE)
    if(EXISTS "${UNINSTALL_MODULE}")
        configure_file(
            "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
            "${CMAKE_CURRENT_BINARY_DIR}/cmake/cmake_uninstall.cmake"
            IMMEDIATE @ONLY)

        add_custom_target(uninstall
            COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/cmake/cmake_uninstall.cmake)
    endif()
endif()

if ((TARGET uninstall) AND (EXISTS "${LOC_PATH}"))
    message(FATAL_ERROR
        "You cannot uninstall in the source directory."
        "You may only uninstall from the build subdirectory."
        "Feel free to remove remove CMakeCache.txt and CMakeFiles.")
endif()
