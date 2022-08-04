function(lstarget)
    # Set make_library arguments
    set(ARG_PREFIX TARGET)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME)
    set(_MULTI_VALUE_ARGS HEADERS)

    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

    message(STATUS, "Target Name: ${TARGET_NAME}")
    message(STATUS, "Headers Directory: ${TARGET_HEADERS}")
endfunction()

# Debugging 

## Logging functions
set_property(GLOBAL PROPERTY ENABLE_LOGGING OFF)

macro(log_info msg)
    get_property(IS_ENABLED GLOBAL PROPERTY ENABLE_LOGGING)
    if (IS_ENABLED)
        message(STATUS "INFO ${msg}")
    endif()
endmacro()

macro(log_debug msg)
    get_property(IS_ENABLED GLOBAL PROPERTY ENABLE_LOGGING)
    if (IS_ENABLED)
        message(STATUS "DEBUG ${msg}")
    endif()
endmacro()

macro(log_warn msg)
    get_property(IS_ENABLED GLOBAL PROPERTY ENABLE_LOGGING)
    if (IS_ENABLED)
        message(STATUS "WARN ${msg}")
    endif()
endmacro()

macro(log_warn msg)
    get_property(IS_ENABLED GLOBAL PROPERTY ENABLE_LOGGING)
    if (IS_ENABLED)
        message(STATUS "TRACE ${msg}")
    endif()
endmacro()

macro(debug variableName)
    get_property(IS_ENABLED GLOBAL PROPERTY ENABLE_LOGGING)
    if (IS_ENABLED)
        debug("${variableName}=\${${variableName}}")
    endif()
endmacro()
