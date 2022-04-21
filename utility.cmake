# Utility C Library

# Require import_external_library cmake module function
include(Library)

# If the library hasn't been imported/included in our project
if (NOT TARGET utility)
    # Include the library
    set(UTILITY_LIB_SRC /usr/local/lib)
    set(UTILITY_LIB_FILE libutility.so)
    # Import only if the library was installed system wide
    if (EXISTS "${UTILITY_LIB_SRC}/${UTILITY_LIB_FILE}")
        import_library(
            NAME utility
            TYPE SHARED
            FILE ${UTILITY_LIB_FILE}
            SOURCE_DIR ${UTILITY_LIB_SRC})

    # If the library was not installed system wide
    else()
        # Configure the library as a subproject in our main repository
        message(STATUS "\"libutility.so\" not found")
        message(STATUS "Configuring utility as a subproject")

        set(UTILITY utility)
        set(UTILITY_SRC ${PROJECT_SOURCE_DIR}/subprojects/${UTILITY})
        set(UTILITY_FILE ${UTILITY_SRC}/build/release/lib/lib${UTILITY}.so)
        # If the generated library exists
        if (EXISTS ${UTILITY_FILE})
            # Import the shared library
            # Note that this requires you to first generate the library
            import_external_library(
                NAME ${UTILITY}
                TYPE SHARED
                SOURCE_DIR ${UTILITY_SRC}
                HEADERS ${UTILITY_SRC}/include
                PATH ${UTILITY_FILE})
        else()
            # Fetch the git repository
            # Specify some build commands
            # Add the library
        endif()
    endif()
endif()
