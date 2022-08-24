# Library.cmake - Include CMake projects and libraries

# Variable length arguments for CMake functions:
# Note: Don't append a '_' suffix to ARG_PREFIX, it breaks the parameter matching
# set(ARG_PREFIX LIB)    # Uses LIB_ prefix for variables
# set(_OPTIONS_ARGS)     # Optional toggleable flags
# set(_ONE_VALUE_ARGS)   # Arguments which accept one value
# set(_MULTI_VALUE_ARGS) # Arguments which accept multiple values
# Parses the arguments:
# cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

# Imports
include(FetchContent)
include(CMakeParseArguments)    # Parse lists of function arguments
include(Utilities)              # Includes color, logging statements

# Constants
set(USR /usr/lib CACHE INTERNAL "System-wide installed libraries directory")
set(USR_LOCAL /usr/local/lib CACHE INTERNAL "Locally installed libraries")
set(USR_INCLUDE /usr/include CACHE INTERNAL "System-wide installed library headers")
set(USR_LOCAL_INCLUDE /usr/local/include CACHE INTERNAL "Locally installed library headers")

# Functions

# Create executables
function(make_bin)
    set(ARG_PREFIX BIN)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME)
    set(_MULTI_VALUE_ARGS HDRS SRCS DEPS)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

    # Create binary
    set(BN_NAME ${BIN_NAME}-bin)
    add_executable(${BN_NAME} ${BIN_SRCS})
    target_include_directories(${BN_NAME} PUBLIC ${BIN_HDRS})
    target_link_libraries(${BN_NAME} PRIVATE ${BIN_DEPS})

    # Rename binary executable without -bin suffix
    set_target_properties(${BN_NAME} PROPERTIES OUTPUT_NAME ${BIN_NAME})
endfunction()

# Create either a static or shared library
function(make_lib)
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME TYPE HDR)
    set(_MULTI_VALUE_ARGS HDRS SRCS DEPS)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

    # Static library targets have  _static suffix
    if(${LIB_TYPE} STREQUAL STATIC)
        set(TARGET ${LIB_NAME}_static)
    elseif(${LIB_TYPE} STREQUAL SHARED)
        set(TARGET ${LIB_NAME})
    endif()

    # Create library target
    set(LB_NAME ${TARGET})
    add_library(${LB_NAME} ${LIB_TYPE} ${LIB_SRCS})
    target_include_directories(${LB_NAME} PUBLIC ${LIB_HDRS})
    target_link_libraries(${LB_NAME} PRIVATE ${LIB_DEPS})

    if (EXISTS ${LIB_HDR})
        set_target_properties(${LB_NAME} PROPERTIES PUBLIC_HEADER ${LIB_HDR})
    endif()

    # Rename static library without _static suffix
    set_target_properties(${LB_NAME} PROPERTIES OUTPUT_NAME ${LIB_NAME})
endfunction()

# Creates static and shared library targets
function(make_ssl)
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME HDR)
    set(_MULTI_VALUE_ARGS HDRS SRCS DEPS)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

    # Build both library types
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

# Imports a static/shared library target
function(import_lib)
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME TYPE)
    set(_MULTI_VALUE_ARGS HDRS PATH)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

    # Create library target
    add_library(${LIB_NAME} ${LIB_TYPE} IMPORTED)
    set_property(TARGET ${LIB_NAME} PROPERTY IMPORTED_LOCATION ${LIB_PATH})       # Import library
    set_property(TARGET ${LIB_NAME} INTERFACE_INCLUDE_DIRECTORIES ${LIB_HDRS})    # Import library headers
endfunction()

# Include static/shared libraries as CMake targets
# Libraries can be included as:
# - A package installed on your system.
# - A FetchContent dependency
# - A Git Submodule CMake subproject
function(include_lib)
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS)
    set(_ONE_VALUE_ARGS NAME TARG_NAME TYPE PUB HDRD REPO SP SPI SPD)
    set(_MULTI_VALUE_ARGS NAMES)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

    # If the library hasn't been included
    if ((NOT TARGET ${LIB_NAME}) OR ((NOT TARGET "${TARG_NAME}") AND (NOT "${TARG_NAME}" STREQUAL ""))) 
        # Optional arguments:
        # LIB_TYPE, LIB_HDRD, LIB_SPD, TARG_NAME

        # Show function parameters
        log_debug("=== ${LIB_NAME} Debug Info ===")
        log_debug("LIB_NAME                 : ${LIB_NAME}")
        log_debug("TARG_NAME                : ${TARG_NAME}")
        log_debug("LIB_TYPE                 : ${LIB_TYPE}")
        log_debug("LIB_NAMES                : ${LIB_NAMES}")
        log_debug("LIB_PUBLIC_HEADER        : ${LIB_PUB}")
        log_debug("LIB_HEADER_DIR           : ${LIB_HDRD}")
        log_debug("LIB_GIT_REPO             : ${LIB_REPO}")
        log_debug("LIB_SUBPROJECT           : ${LIB_SP}")
        log_debug("LIB_SUBPROJECT_INCLUDE   : ${LIB_SPI}")
        log_debug("LIB_SUBPROJECT_DIR       : ${LIB_SPD}")

        # Find the package on our system
        log_info("Finding library on system: ${LIB_NAME}")

        # Sets the variable name containing the directory to the library's header
        string(TOUPPER ${LIB_NAME} LIB_INCLUDE_NAME)

        # Include static or shared libraries
        if (("${LIB_TYPE}" STREQUAL "STATIC") AND (NOT "${LIB_TYPE}" STREQUAL ""))
            set(SUFFIX "a")
        else()
            set(SUFFIX "so")
        endif()

        set(LIB_USR ${USR}/lib${LIB_NAME}.${SUFFIX})
        set(LIB_LOCAL ${USR_LOCAL}/lib${LIB_NAME}.${SUFFIX})

        # If the header exists in include/some_dir, include the public header there
        if (NOT "${LIB_HDRD}" STREQUAL "")
            set(HDRD "${LIB_HDRD}/" )
        else()
            set(HDRD "")
        endif()
        set(LIB_INCLUDE ${USR_INCLUDE}/${HDRD})
        set(LIB_LOCAL_INCLUDE  ${USR_LOCAL_INCLUDE}/${HDRD})

        log_debug("Library Paths:")
        log_debug("LIB_USR                  : ${LIB_USR}")
        log_debug("LIB_LOCAL                : ${LIB_LOCAL}")
        log_debug("LIB_INCLUDE              : ${LIB_INCLUDE}")
        log_debug("LIB_LOCAL_INCLUDE        : ${LIB_LOCAL_INCLUDE}")

        if (EXISTS ${LIB_USR})      # Found under /usr/lib
            set(LIB_FOUND ${LIB_USR})
            set(HEADERS_${LIB_INCLUDE_NAME} ${LIB_INCLUDE} CACHE INTERNAL "Dynamically set library header includes")
        elseif(EXISTS ${LIB_LOCAL}) # Found under /usr/local/lib
            set(LIB_FOUND ${LIB_LOCAL})
            set(HEADERS_${LIB_INCLUDE_NAME} ${LIB_LOCAL_INCLUDE} CACHE INTERNAL "Dynamically set library header includes")
        endif()

        if ((EXISTS ${LIB_USR}) OR (EXISTS ${LIB_LOCAL}))
            log_info("Found: ${LIB_FOUND}")

            if (NOT "${TARG_NAME}" STREQUAL "")
                set(LIB_NAME ${TARG_NAME})
            endif()

            find_library(${LIB_NAME} NAMES ${LIB_NAMES} HINTS ${LIB_FOUND})

            # Defaults to SHARED if null, and STATIC if specified
            if ("${LIB_TYPE}" STREQUAL STATIC)
                add_library(${LIB_NAME} STATIC IMPORTED GLOBAL)
            else()
                add_library(${LIB_NAME} SHARED IMPORTED GLOBAL)
            endif()
            set_target_properties(${LIB_NAME} PROPERTIES IMPORTED_LOCATION ${LIB_FOUND})

            log_debug("HEADERS_${LIB_INCLUDE_NAME}: ${HEADERS${LIB_INCLUDE_NAME}}")
            message(STATUS "Using ${LIB_NAME} system package")
            return() # Exit early
        endif()

        # Assume that we're configuring a subproject
        # If the header exists in include/some_dir, include the public header there
        if (NOT "${LIB_SPD}" STREQUAL "")
            set(HDRD "${LIB_SPD}/")
        else()
            set(HDRD "")
        endif()
        set(SUBPROJECT_INCLUDE ${LIB_SPI}/${HDRD})
        log_debug("SUBPROJECT_INCLUDE: ${SUBPROJECT_INCLUDE}")

        if (NOT EXISTS ${LIB_SP})
            if (NOT ${USE_AS_SUBMODULE})
                # Configure with FetchContent
                log_info("Configuring ${LIB_NAME} with FetchContent")
                if (NOT "${TARG_NAME}" STREQUAL "")
                    set(LIB_NAME ${TARG_NAME})
                endif()
                FetchContent_Declare(${LIB_NAME}
                    GIT_REPOSITORY  ${LIB_REPO})
                message(STATUS "Using ${LIB_NAME} as CMake FetchContent project")
                FetchContent_MakeAvailable(${LIB_NAME})
                return()
            endif()
        else()
            # Configure as local git submodule / subproject
            log_info("Configuring ${LIB_NAME} as Git Submodule")
            # This builds the library from source (you'll need the library's required build deps)
            message(STATUS "Using ${LIB_NAME} as Git Submodule CMake project")
            add_subdirectory(${LIB_SP})
            set(HEADERS_${LIB_INCLUDE_NAME} ${SUBPROJECT_INCLUDE} CACHE INTERNAL "Dynamically set library header includes")
            log_debug("HEADERS_${LIB_INCLUDE_NAME}: ${HEADERS_${LIB_INCLUDE_NAME}}")
            return()
        endif()
    endif()
endfunction()

# Include projects using either Git Submodule or FetchContent
function(include_subprojects)
    # Default values
    set(SP_TOGGLE FALSE)
    set(SP_GIT_MODULE FALSE)

    set(ARG_PREFIX SP)
    set(_OPTIONS_ARGS)
    set(_ONE_VALUE_ARGS TOGGLE GIT_MODULE)
    set(_MULTI_VALUE_ARGS INCLUDES)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

    log_debug("SP_TOGGLE    : ${SP_TOGGLE}")
    log_debug("SP_GIT_MODULE: ${SP_GIT_MODULE}")
    log_debug("SP_INCLUDES  : ${SP_INCLUDES}")

    set(USE_AS_SUBPROJECT ${SP_TOGGLE})
    set(USE_AS_SUBMODULE ${SP_GIT_MODULE})

    foreach(inc IN LISTS SP_INCLUDES)
        log_debug("Including subproject: ${inc}")
        include(${inc})
    endforeach()
    
    unset(USE_AS_SUBMODULE)
    unset(USE_AS_SUBPROJECT)
endfunction()
