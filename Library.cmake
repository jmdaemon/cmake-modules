# Utility functions for library modules

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

# Builds both a shared and a static library target
function(make_static_shared_lib)
    # Set arguments
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME CSTANDARD)
    set(_MULTI_VALUE_ARGS HEADERS SOURCES DEPS SRC_GROUP_FILES)
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


# Imports a shared or static library into a CMake Project
function(import_external_library)
    # Set make_library arguments
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME TYPE)
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
endfunction()
