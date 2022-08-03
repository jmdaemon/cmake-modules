# Utility functions for library modules

# Global constants
set(USR /usr/lib)
set(USR_LOCAL /usr/local/lib)
set(USR_INCLUDE /usr/include)

# Parse lists of function arguments
include(CMakeParseArguments)

# Create a library from c/cpp sources
function(make_library)
    # Arguments:
    #LIB_NAME       # Name of the library target
    #LIB_TYPE       # Type of the library to build
    #LIB_CSTANDARD  # CXX Standard
    #LIB_HEADERS    # Library headers
    #LIB_SOURCES    # Library sources
    #LIB_DEPS       # Library dependencies

    # Set make_library arguments
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME TYPE CSTANDARD)
    set(_MULTI_VALUE_ARGS HEADERS SOURCES DEPS SRC_GROUP_FILES)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

    # Show make_library arguments
    #message(STATUS "======================")
    #message(STATUS "make_library arguments: ${LIB_NAME}, followed by ${ARGN}")
    #message(STATUS "LIB_NAME: ${LIB_NAME}")
    #message(STATUS "LIB_TYPE: ${LIB_TYPE}")
    #message(STATUS "LIB_CSTANDARD: ${LIB_CSTANDARD}")
    #message(STATUS "LIB_HEADERS: ${LIB_HEADERS}")
    #message(STATUS "LIB_SOURCES: ${LIB_SOURCES}")
    #message(STATUS "LIB_DEPS: ${LIB_DEPS}")
    #message(STATUS "======================")

    if(${LIB_TYPE} STREQUAL STATIC)
        # Build a static library
        set(TARGET ${LIB_NAME}_static)
    elseif(${LIB_TYPE} STREQUAL SHARED)
        # Build a shared library
        set(TARGET ${LIB_NAME})
    endif()
    # Add a library target
    add_library(${TARGET} ${LIB_TYPE})

    # Set the library sources
    target_sources(${TARGET}
        PRIVATE ${LIB_SOURCES}
        PUBLIC  ${LIB_HEADERS})

    # Include the library headers and link the dependencies
    target_include_directories(${TARGET} PUBLIC ${LIB_HEADERS})
    target_link_libraries(${TARGET} PRIVATE ${LIB_DEPS})
    target_compile_features(${TARGET} PUBLIC ${LIB_CSTANDARD})

    source_group(
        TREE "${PROJECT_SOURCE_DIR}/include"
        PREFIX "Header Files"
        FILES ${LIB_SRC_GROUP_FILES})
endfunction()

#### make_lib
function(make_lib)
    # make_lib - Similar to make_library except with slightly less options
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME TYPE HDR)
    set(_MULTI_VALUE_ARGS HDRS SRCS DEPS)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

    # Suffix static libs with _static
    if(${LIB_TYPE} STREQUAL STATIC)
        set(TARGET ${LIB_NAME}_static)
    elseif(${LIB_TYPE} STREQUAL SHARED)
        set(TARGET ${LIB_NAME})
    endif()

    # Build library
    set(LIB_NAME ${TARGET})
    add_library(${LIB_NAME}
        ${LIB_TYPE}
        ${LIB_SRCS})
    target_include_directories(${LIB_NAME} PUBLIC ${LIB_HDRS})
    if (EXISTS ${LIB_HDR})
        set_target_properties(${LIB_NAME} PROPERTIES PUBLIC_HEADER ${LIB_HDR})
    endif()
    target_link_libraries(${LIB_NAME} PRIVATE ${LIB_DEPS})
endfunction()

#### make_ssl
function(make_ssl)
    # make_ssl - Make static and shared libraries
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME HDR)
    set(_MULTI_VALUE_ARGS HDRS SRCS DEPS)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

    # Suffix static libs with _static
    #if(${LIB_TYPE} STREQUAL STATIC)
        #set(TARGET ${LIB_NAME}_static)
    #elseif(${LIB_TYPE} STREQUAL SHARED)
        #set(TARGET ${LIB_NAME})
    #endif()

    # Build library
    #set(LIB_NAME ${TARGET})
    #add_library(${LIB_NAME}
        #${LIB_TYPE}
        #${LIB_SRCS})
    #target_include_directories(${LIB_NAME} PUBLIC ${LIB_HDRS})
    #set_target_properties(${LIB_NAME} PROPERTIES PUBLIC_HEADER ${LIB_HDR})
    #target_link_libraries(${LIB_NAME} PRIVATE ${LIB_DEPS})

    set(LIB_TYPES SHARED STATIC)
    foreach(LIB_TYPE ${LIB_TYPES})
        make_lib(
            NAME ${LIB_NAME}
            TYPE ${LIB_TYPE}
            HDRS ${LIB_HDRS}
            HDR ${LIB_HDR}
            SRCS ${LIB_SRCS}
            DEPS ${LIB_DEPS})
    endforeach()
endfunction()

#### make_static_shared_lib
function(make_static_shared_lib)
    # Builds both shared, static libraries without specifying ${SRC_GROUP_FILES}
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME CSTANDARD)
    set(_MULTI_VALUE_ARGS HEADERS SOURCES DEPS)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})
    set(LIB_TYPES SHARED STATIC)

    foreach(LIB_TYPE ${LIB_TYPES})
        make_library(
            NAME "${LIB_NAME}"
            TYPE ${LIB_TYPE}
            CSTANDARD "${LIB_CSTANDARD}"
            HEADERS "${LIB_HEADERS}"
            SOURCES "${LIB_SOURCES}"
            DEPS "${LIB_DEPS}")
    endforeach()
endfunction()

#### make_static_shared_lib
function(make_static_shared_lib)
    # Builds both a shared and a static library target
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME)
    set(_MULTI_VALUE_ARGS HEADERS SOURCES DEPS)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})
    set(LIB_TYPES SHARED STATIC)

    foreach(LIB_TYPE ${LIB_TYPES})
        make_library(
            NAME "${LIB_NAME}"
            TYPE ${LIB_TYPE}
            CSTANDARD "${LIB_CSTANDARD}"
            HEADERS "${LIB_HEADERS}"
            SOURCES "${LIB_SOURCES}"
            DEPS "${LIB_DEPS}"
            SRC_GROUP_FILES "${LIB_SRC_GROUP_FILES}")
    endforeach()
endfunction()

# Importing libraries & external libraries
function(import_library)
    # import_library - Import a library that has already been built
    # Set make_library arguments
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME TYPE FILE)
    #set(_MULTI_VALUE_ARGS HEADERS SOURCE_DIR DEPS)
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
    #target_include_directories(${LIB_NAME} PUBLIC ${LIB_HEADERS})
    #target_link_libraries(${LIB_NAME} PRIVATE ${LIB_DEPS})
endfunction()

function(import_external_library)
    # import_external_library - Imports a shared or static library into a CMake Project
    # Set make_library arguments
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME TYPE)
    #set(_MULTI_VALUE_ARGS HEADERS SOURCE_DIR PATH FILE DEPS)
    set(_MULTI_VALUE_ARGS HEADERS SOURCE_DIR PATH FILE)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})
    
    add_library(${LIB_NAME} ${LIB_TYPE} IMPORTED)
    # Import the library file
    set_property(
        TARGET ${LIB_NAME}
        PROPERTY IMPORTED_LOCATION ${LIB_PATH})
    # Import the library headers
    set_property(
        TARGET ${LIB_NAME}
        PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${LIB_HEADERS})
    #target_include_directories(${LIB_NAME} PUBLIC ${LIB_HEADERS})
    #target_link_libraries(${LIB_NAME} PRIVATE ${LIB_DEPS})
endfunction()

# include_lib
#function(include_lib
        #${LIB_NAME}
        #${LIB_NAMES}
        #${LIB_PUBLIC_HEADER}
        #${LIB_GIT_REPO}
        #${LIB_SUBPROJECT}
        #${LIB_SUBPROJECT_INCLUDE})
function(include_lib
        LIB_NAME
        LIB_NAMES
        LIB_PUBLIC_HEADER
        LIB_GIT_REPO
        LIB_SUBPROJECT
        LIB_SUBPROJECT_INCLUDE)

    # If the library hasn't been included
    if (NOT TARGET ${LIB_NAME})
        # Find the package on our system
        message(STATUS "Finding library on system: ${LIB_NAME}")

        # Contains the directory to the public library's header
        string(TOUPPER ${LIB_NAME} LIB_INCLUDE_NAME)

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
                PUBLIC_HEADER ${LIB_INCLUDE}) # Include public interface headers

            # Set headers variable used for other projects
            set(HEADERS_${LIB_INCLUDE_NAME} ${LIB_INCLUDE})

        elseif(EXISTS ${LIB_LOCAL})
            # Found under /usr/lib
            message(STATUS "Found: ${LIB_LOCAL}")
            find_library(${LIB_NAME} NAMES ${LIB_NAMES} HINTS ${LIB_LOCAL})
            add_library(${LIB_NAME} SHARED IMPORTED GLOBAL)
            set_target_properties(${LIB_NAME} PROPERTIES
                IMPORTED_LOCATION ${LIB_LOCAL}
                PUBLIC_HEADER ${LIB_INCLUDE})

            set(HEADERS_${LIB_INCLUDE_NAME} ${LIB_INCLUDE})
        endif()
    else()
        message(STATUS "Configuring ${LIB_NAME} as a subproject")
        if (NOT EXISTS ${LIB_SUBPROJECT})
            set(SUBPROJECT_INCLUDE ${LIB_SUBPROJECT_INCLUDE}/${LIB_PUBLIC_HEADER})
            if (NOT ${USE_AS_SUBMODULE})
                message(STATUS, "Configuring ${LIB_NAME} with FetchContent")
                # Configure with FetchContent
                FetchContent_Declare(${LIB_NAME}
                    GIT_REPOSITORY  ${LIB_GIT_REPO}
                    SOURCE_DIR      ${LIB_SUBPROJECT})

                add_library(${LIB_NAME})
                target_link_libraries(${LIB_NAME} PUBLIC ${LIB_NAME})
                # Include subproject headers
                target_include_directories(${LIB_NAME} PUBLIC ${SUBPROJECT_INCLUDE})
                set_target_properties(${LIB_NAME} PROPERTIES PUBLIC_HEADER ${SUBPROJECT_INCLUDE})
            endif()
        else()
            message(STATUS, "Configuring ${LIB_NAME} as Git Submodule")
            # Configure as local git submodule / subproject
            # This builds the library from source (you'll need the library's required build deps)
            add_subdirectory(${LIB_SUBPROJECT})
        endif()
    endif()
endfunction()
