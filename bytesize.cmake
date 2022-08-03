# Bytesize C Library

# Note that there are a few ways you can specify bytesize
# 1. As a system-wide installed library "in /usr/local/lib/"
# 2. As a subproject in subprojects/bytesize (requires you to build the library first)
# 3. As a dependency to be built alongside the project code
# Note that currently only 1-2 are supported for now

# Imports
include(Library)

# Variables 
set(LIB_NAME bytesize)
set(LIB_NAMES bytesize libbytesize)
set(USE_AS_SUBMODULE OFF)

# If the library hasn't been included
if (NOT TARGET ${LIB_NAME})
    message(STATUS "Finding library: ${LIB_NAME}")
    # Find the package on our system
    set(USR /usr/lib)
    set(USR_LOCAL /usr/local/lib)

    set(LIB_USR ${USR}/lib${LIB_NAME}.so)
    set(LIB_LOCAL ${USR_LOCAL}/lib${LIB_NAME}.so)

    if (EXISTS ${LIB_USR})
        # Found under /usr/local/lib
        message(STATUS "Found: ${LIB_USR}")
        find_library(${LIB_NAME} NAMES ${LIB_NAMES} HINTS ${LIB_USR})
        add_library(${LIB_NAME} SHARED IMPORTED GLOBAL)
        set_target_properties(${LIB_NAME} PROPERTIES
            IMPORTED_LOCATION ${LIB_USR})

    elseif(${LIB_LOCAL})
        # Found under /usr/lib
        message(STATUS "Found: ${LIB_LOCAL}")
        find_library(${LIB_NAME} NAMES ${LIB_NAMES} HINTS ${LIB_LOCAL})
        add_library(${LIB_NAME} SHARED IMPORTED GLOBAL)
        set_target_properties(${LIB_NAME} PROPERTIES
            IMPORTED_LOCATION ${LIB_LOCAL})
    endif()
else()
    message(STATUS "Configuring ${LIB_NAME} as a subproject")
    set(SUBPROJECT_BYTESIZE "${PROJECT_SOURCE_DIR}/subprojects/bytesize")
    set(HEADERS_BYTESIZE "${PROJECT_SOURCE_DIR}/subprojects/bytesize/include")
    if (EXISTS ${SUBPROJECT_BYTESIZE})
        if (NOT ${USE_AS_SUBMODULE})
            message(STATUS, "Configuring ${LIB_NAME} with FetchContent")
            # Configure with FetchContent
            FetchContent_Declare(bytesize
                GIT_REPOSITORY  https://github.com/jmdaemon/bytesize
                SOURCE_DIR      ${SUBPROJECT_BYTESIZE})

            add_library(${LIB_NAME})
            target_link_libraries(${LIB_NAME} PUBLIC ${LIB_NAME})
        else()
            message(STATUS, "Configuring ${LIB_NAME} as Git Submodule")
            # Configure as local git submodule / subproject
            # Note that this requires you to also have the other libraries that
            # Bytesize requires (log.c unity) configured as a subproject as well.
            # In addition you must specify:
            # include(logc)
            # include(Unity)
            add_subdirectory(${SUBPROJECT_BYTESIZE})
        endif()
    endif()
endif()
