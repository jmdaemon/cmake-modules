# Utility C Library

# Require import_external_library cmake module function
include(Library)

set(ConfigureAsSubproject FALSE)
set(ConfigureAsExternal FALSE)

# If the library hasn't been imported/included in our project
if (NOT utility)
    # Include the library

    set(UTILITY_LIB_SRC /usr/local/lib)
    set(UTILITY_LIB_NAME libutility.so)

    # Find the library on our system
    find_library(${UTILITY_LIB_SRC} NAMES ${UTILITY_LIB_NAME})
    message(STATUS "Utility library location: ${UTILITY_LIB_SRC}/${UTILITY_LIB_NAME}")

    add_library(utility SHARED IMPORTED GLOBAL)
    set_target_properties(utility PROPERTIES
        IMPORTED_LOCATION "${UTILITY_LIB_SRC}/${UTILITY_LIB_NAME}")

endif()
# If the library is not installed on our system
#if (NOT utility_FOUND)
if (ConfigureAsExternal)
    message(STATUS "\"libutility.so\" not found")

    # Configure the library as a subproject in our main repository
    if (ConfigureAsSubproject)
        set(UTILITY utility)
        set(UTILITY_SRC ${PROJECT_SOURCE_DIR}/subprojects/${UTILITY})
        import_external_library(
            NAME ${UTILITY}
            TYPE SHARED
            SOURCE_DIR ${UTILITY_SRC}
            HEADERS ${UTILITY_SRC}/include
            PATH ${UTILITY_SRC}/build/release/lib/lib${UTILITY}.so)
    else()
    # Fetch and build it with FetchContent 
    #include(FetchContent)
    #FetchContent_Declare(
        #utility
        #GIT_REPOSITORY https://github.com/jmdaemon/utility.git
        #GIT_TAG master)
    #FetchContent_MakeAvailable(utility)

    # Fetch and build it
    # Include dependencies
    #include(ExternalProject)
    #find_package(Git REQUIRED)
    #ExternalProject_Add(utility
        #GIT_REPOSITORY https://github.com/jmdaemon/utility.git
        #TIMEOUT 10
        #UPDATE_COMMAND ${GIT_EXECUTABLE} pull
        #CONFIGURE_COMMAND ""
        #BUILD_COMMAND "make release lib"
        #INSTALL_COMMAND ""
        #LOG_DOWNLOAD ON
        ##SOURCE_SUBDIR utility
        #SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/utility
        #BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/utility/build
        #)
    #add_subdirectory(
        #"${CMAKE_CURRENT_BINARY_DIR}/utility"
        #"${CMAKE_CURRENT_BINARY_DIR}/utility/build")
    #include_directories("${utility_SOURCE_DIR}/include")

    set(UTILITY_LIBRARY_SRC ${CMAKE_CURRENT_BINARY_DIR}/_deps/utility)
    set(UTILITY_LIBRARY ${CMAKE_CURRENT_BINARY_DIR}/_deps/utility/build/release/lib/libutility.so)

    # create a custom target called build_scintilla that is part of ALL
    # and will run each time you type make
    add_custom_target(build_utility ALL
        COMMAND "${CMAKE_MAKE_PROGRAM} release lib"
        WORKING_DIRECTORY ${UTILITY_LIBRARY_SRC}
        COMMENT "Build the utility library")

    # now create an imported static target
    add_library(utility STATIC IMPORTED)

    # Import target "utility" for configuration ""
    set_property(TARGET utility APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
    set_target_properties(utility PROPERTIES
      IMPORTED_LOCATION_NOCONFIG "${UTILITY_LIBRARY}")
    endif()
endif()
