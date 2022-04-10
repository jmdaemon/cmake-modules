# Utility functions for creating library modules

include(CMakeParseArguments)
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

function(make_static_shared_lib)
    # Set arguments
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME CSTANDARD)
    set(_MULTI_VALUE_ARGS HEADERS SOURCES DEPS SRC_GROUP_FILES)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})
    set(LIB_TYPES SHARED STATIC)

    foreach(LIB_TYPE LIB_TYPES)
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

