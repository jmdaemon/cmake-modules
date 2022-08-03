# Bytesize C Library

# You can include bytesize into your project in two ways. You can:
# 1.a Install the library as a package system wide. 
# 2.b Toggle ${USE_AS_SUBMODULE}, and include library as a git submodule in your project.

# *Note* that if you are building Bytesize as a subproject. Bytesize depends on log.c and
# Unity. If these are also configured # as subprojects, then you can include them with:
# include(logc)
# include(Unity)
# Given that you are using my cmake-modules here: https://github.com/jmdaemon/cmake-modules
# Otherwise they must be installed on your system or configured as a subproject manually.

#set(USE_AS_SUBMODULE OFF)

# Library Variables 
set(LIB_NAME bytesize)
set(LIB_INCLUDE_NAME "BYTESIZE")
set(LIB_NAMES bytesize libbytesize)

set(LIB_PUBLIC_HEADER bytesize.h)

set(LIB_SUBPROJECT "${PROJECT_SOURCE_DIR}/subprojects/bytesize")
set(LIB_HEADERS "${PROJECT_SOURCE_DIR}/subprojects/bytesize/include")

set(LIB_GIT_REPO https://github.com/jmdaemon/bytesize)

# Include these headers in your projects

# If the library hasn't been included
if (NOT TARGET ${LIB_NAME})
    message(STATUS "Finding library: ${LIB_NAME}")
    # Find the package on our system
    set(USR /usr/lib)
    set(USR_LOCAL /usr/local/lib)
    set(USR_INCLUDE /usr/include)

    set(LIB_USR ${USR}/lib${LIB_NAME}.so)
    set(LIB_LOCAL ${USR_LOCAL}/lib${LIB_NAME}.so)
    set(LIB_INCLUDE  ${USR_INCLUDE}/${LIB_PUBLIC_HEADER})

    if (EXISTS ${LIB_USR})
        # Found under /usr/local/lib
        message(STATUS "Found: ${LIB_USR}")
        find_library(${LIB_NAME} NAMES ${LIB_NAMES} HINTS ${LIB_USR})
        add_library(${LIB_NAME} SHARED IMPORTED GLOBAL)
        set_target_properties(${LIB_NAME} PROPERTIES
            IMPORTED_LOCATION ${LIB_USR}
            PUBLIC_HEADER ${LIB_INCLUDE})

        # Set headers variable used for other projects
        set(HEADERS_${LIB_INCLUDE_NAME} ${LIB_INCLUDE})

    elseif(${LIB_LOCAL})
        # Found under /usr/lib
        message(STATUS "Found: ${LIB_LOCAL}")
        find_library(${LIB_NAME} NAMES ${LIB_NAMES} HINTS ${LIB_LOCAL})
        add_library(${LIB_NAME} SHARED IMPORTED GLOBAL)
        set_target_properties(${LIB_NAME} PROPERTIES
            IMPORTED_LOCATION ${LIB_LOCAL}
            PUBLIC_HEADER ${LIB_INCLUDE}) # Include public interface headers

        # Set headers variable used for other projects
        set(HEADERS_${LIB_INCLUDE_NAME} ${LIB_INCLUDE})
    endif()
else()
    message(STATUS "Configuring ${LIB_NAME} as a subproject")
    if (EXISTS ${LIB_SUBPROJECT})
        if (NOT ${USE_AS_SUBMODULE})
            message(STATUS, "Configuring ${LIB_NAME} with FetchContent")
            # Configure with FetchContent
            FetchContent_Declare(bytesize
                GIT_REPOSITORY  ${LIB_GIT_REPO}
                SOURCE_DIR      ${LIB_SUBPROJECT})

            add_library(${LIB_NAME})
            target_link_libraries(${LIB_NAME} PUBLIC ${LIB_NAME})
            # Include headers here
        else()
            message(STATUS, "Configuring ${LIB_NAME} as Git Submodule")
            # Configure as local git submodule / subproject
            # Note that this requires you to also have the other libraries that
            # ${LIB_NAME} requires
            add_subdirectory(${LIB_SUBPROJECT})
        endif()
    endif()
endif()
