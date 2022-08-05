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
# Use the following to enable viewing logs
# set(GLOBAL ENABLE_LOGGING ON CACHE INTERNAL "View the logging statements/debug info")

    #=======
# Log Levels:
# 0: None
# 1: All
set(LOG_TRACE 2)
set(LOG_DEBUG 3)
set(LOG_INFO 4)
set(LOG_WARN 5)
set(LOG_ERROR 6)
#set(LOG_NONE 0)
#set(LOG_NONE 0)

function(log_msg msg)
    if (ENABLE_LOGGING)
        message(STATUS "${msg}")
    endif()
endfunction()

function(log_info msg)
    log_msg("${Green}INFO${ColorReset} ${msg}")
endfunction()

function(log_debug msg)
    log_msg("${Blue}DEBUG${ColorReset} ${msg}")
endfunction()

function(log_warn msg)
    log_msg("${Red}WARN${ColorReset} ${msg}")
endfunction()

function(log_warn msg)
    log_msg("${Magenta}TRACE${ColorReset} ${msg}")
endfunction()

function(debug variableName)
    if (ENABLE_LOGGING)
        debug("${variableName}=\${${variableName}}")
    endif()
endfunction()
