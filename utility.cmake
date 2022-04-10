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
    # Ensure the library exists and is not null
    if(NOT ${LIB_NAME})
        message(FATAL_ERROR "${LIB_NAME} not found!")
    endif()
endfunction()

# Utility C Library
set(UTILITY utility)
set(UTILITY_SRC ${PROJECT_SOURCE_DIR}/subprojects/${UTILITY})
import_external_library(
    NAME ${UTILITY}
    TYPE SHARED
    SOURCE_DIR ${UTILITY_SRC}
    HEADERS ${UTILITY_SRC}/include
    PATH ${UTILITY_SRC}/build/release/lib/lib${UTILITY}.so
    )
