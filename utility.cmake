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
