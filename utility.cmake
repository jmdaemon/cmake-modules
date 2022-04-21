# Utility C Library

# Require import_external_library cmake module function
include(Library)

set(ConfigureAsSubproject FALSE)
set(ConfigureAsExternal FALSE)

function(import_library)
    # Set make_library arguments
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME TYPE FILE)
    set(_MULTI_VALUE_ARGS SOURCE_DIR)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

    # LIB_NAME: The name of the library
    # LIB_TYPE: STATIC or SHARED library
    # FILE: The name of the library file (lib.a, lib.so)
    # SOURCE_DIR: The directory where the library is located
    message(STATUS "Including ${LIB_NAME} library")
    set(LIB_FILE_PATH "${LIB_SOURCE_DIR}/${LIB_FILE}")

    # Find the library on our system
    find_library(${LIB_SOURCE_DIR} NAMES ${LIB_FILE})
    message(STATUS "${LIB_NAME} library location: ${LIB_FILE_PATH}")

    # Add the library as a target on our system
    add_library(${LIB_NAME} ${LIB_TYPE} IMPORTED GLOBAL)
    set_target_properties(${LIB_NAME} PROPERTIES
        IMPORTED_LOCATION "${LIB_FILE_PATH}")

endfunction()

# If the library hasn't been imported/included in our project
if (NOT TARGET utility)
    # Include the library
    set(UTILITY_LIB_SRC /usr/local/lib)
    set(UTILITY_LIB_FILE libutility.so)
    import_library(
        NAME utility
        TYPE SHARED
        FILE ${UTILITY_LIB_FILE}
        SOURCE_DIR ${UTILITY_LIB_SRC})

endif()
# If the library is not installed on our system
if (ConfigureAsExternal)
    message(STATUS "\"libutility.so\" not found")
    message(STATUS "Configuring utility project")

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
    endif()
endif()
