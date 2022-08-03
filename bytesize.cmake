# Bytesize C Library

# Note that there are a few ways you can specify bytesize
# 1. As a system-wide installed library "in /usr/local/lib/"
# 2. As a subproject in subprojects/bytesize (requires you to build the library first)
# 3. As a dependency to be built alongside the project code
# Note that currently only 1-2 are supported for now

# Imports
include(Library)

# If the library hasn't been imported/included in our project
if (NOT TARGET bytesize)
    # Include the library
    #set(BYTESIZE_LIB_SRC /usr/local/lib)
    set(BYTESIZE_LIB_SRC /usr/lib)
    set(BYTESIZE_LIB_FILE libbytesize.so)
    # Import only if the library was installed system wide
    if (EXISTS "${BYTESIZE_LIB_SRC}/${BYTESIZE_LIB_FILE}")
        import_library(
            NAME bytesize
            TYPE SHARED
            FILE ${BYTESIZE_LIB_FILE}
            #HEADERS ${LOG_C_INCLUDES}
            #DEPS logc
            SOURCE_DIR ${BYTESIZE_LIB_SRC})

    # If the library was not installed system wide
    else()
        # Configure the library as a subproject in our main repository
        message(STATUS "\"libbytesize.so\" not found")
        message(STATUS "Configuring bytesize as a subproject")

        set(BYTESIZE bytesize)
        set(BYTESIZE_SRC ${PROJECT_SOURCE_DIR}/subprojects/${BYTESIZE})
        set(BYTESIZE_FILE ${BYTESIZE_SRC}/build/release/lib/lib${BYTESIZE}.so)
        # If the generated library exists
        if (EXISTS ${BYTESIZE_FILE})
            # Import the shared library
            # Note that this requires you to first generate the library
            import_external_library(
                NAME ${BYTESIZE}
                TYPE SHARED
                SOURCE_DIR ${BYTESIZE_SRC}
                HEADERS ${BYTESIZE_SRC}/include
                #HEADERS ${LOG_C_INCLUDES} ${BYTESIZE_SRC}/include
                #DEPS logc
                PATH ${BYTESIZE_FILE})
        else()
            # Fetch the git repository
            # Specify some build commands
            # Add the library
        endif()
    endif()
endif()
