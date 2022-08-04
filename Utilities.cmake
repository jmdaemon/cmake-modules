# Colors 
# Use these for colored status messages
# Example: message("${Red}This is Red${ColourReset}")
if(NOT WIN32)
  string(ASCII 27 Esc)
  set(ColorReset "${Esc}[m")
  set(ColorBold  "${Esc}[1m")
  set(Red         "${Esc}[31m")
  set(Green       "${Esc}[32m")
  set(Yellow      "${Esc}[33m")
  set(Blue        "${Esc}[34m")
  set(Magenta     "${Esc}[35m")
  set(Cyan        "${Esc}[36m")
  set(White       "${Esc}[37m")
  set(BoldRed     "${Esc}[1;31m")
  set(BoldGreen   "${Esc}[1;32m")
  set(BoldYellow  "${Esc}[1;33m")
  set(BoldBlue    "${Esc}[1;34m")
  set(BoldMagenta "${Esc}[1;35m")
  set(BoldCyan    "${Esc}[1;36m")
  set(BoldWhite   "${Esc}[1;37m")
endif()

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
        message(STATUS "${Green}INFO${ColorReset} ${msg}")
    endif()
endmacro()

macro(log_debug msg)
    get_property(IS_ENABLED GLOBAL PROPERTY ENABLE_LOGGING)
    if (IS_ENABLED)
        message(STATUS "${Blue}DEBUG${ColorReset} ${msg}")
    endif()
endmacro()

macro(log_warn msg)
    get_property(IS_ENABLED GLOBAL PROPERTY ENABLE_LOGGING)
    if (IS_ENABLED)
        message(STATUS "${Red}WARN${ColorReset} ${msg}")
    endif()
endmacro()

macro(log_warn msg)
    get_property(IS_ENABLED GLOBAL PROPERTY ENABLE_LOGGING)
    if (IS_ENABLED)
        message("${Magenta}TRACE${ColorReset} ${msg}")
    endif()
endmacro()

macro(debug variableName)
    get_property(IS_ENABLED GLOBAL PROPERTY ENABLE_LOGGING)
    if (IS_ENABLED)
        debug("${variableName}=\${${variableName}}")
    endif()
endmacro()
