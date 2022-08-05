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

# Use case
# Enable all logging
# Enable specific logging levels

#set(LOGLEVEL 0)

#function(log_msg msg loglevel)
function(log_msg msg upperbound)
    #if (${loglevel} == )
    if(("${LOG_LEVEL}" STREQUAL "${upperbound}") OR (NOT "${ENABLE_LOGGING}" STREQUAL OFF) OR ("${LOG_LEVEL}" GREATER "${upperbound}"))
        message(STATUS "${msg}")
    endif()
    #if (ENABLE_LOGGING)
    #endif()
endfunction()

function(log_trace msg)
    #if(("${LOG_LEVEL}" STREQUAL "${LOG_TRACE}") OR ("${ENABLE_LOGGING}") OR ("${LOG_LEVEL}" GREATER "${LOG_TRACE}"))
    #if(("${LOG_LEVEL}" STREQUAL "${LOG_TRACE}") OR (NOT "${ENABLE_LOGGING}" STREQUAL OFF) OR ("${LOG_LEVEL}" GREATER "${LOG_TRACE}"))
    #if(("${LOG_LEVEL}" STREQUAL "${LOG_TRACE}") OR ("${LOG_LEVEL}" GREATER "${LOG_TRACE}"))
    log_msg("${Magenta}TRACE${ColorReset} ${msg}" ${LOG_TRACE})
    #endif()
endfunction()

function(log_debug msg)
    #if(("${LOG_LEVEL}" STREQUAL "${LOG_DEBUG}") OR ("${ENABLE_LOGGING}") OR ("${LOG_LEVEL}" GREATER "${LOG_DEBUG}"))
    #if(("${LOG_LEVEL}" STREQUAL "${LOG_DEBUG}") OR (NOT "${ENABLE_LOGGING}" STREQUAL OFF) OR ("${LOG_LEVEL}" GREATER "${LOG_DEBUG}"))
    #if(("${LOG_LEVEL}" STREQUAL "${LOG_DEBUG}") OR ("${LOG_LEVEL}" GREATER "${LOG_DEBUG}"))
    log_msg("${Blue}DEBUG${ColorReset} ${msg}" ${LOG_DEBUG})
    #endif()
endfunction()

function(log_info msg)
    #if(("${LOG_LEVEL}" STREQUAL "${LOG_INFO}") OR ("${ENABLE_LOGGING}") OR ("${LOG_LEVEL}" GREATER "${LOG_INFO}"))
    #if(("${LOG_LEVEL}" STREQUAL "${LOG_INFO}") OR (NOT "${ENABLE_LOGGING}" STREQUAL OFF) OR ("${LOG_LEVEL}" GREATER "${LOG_INFO}"))
    #if(("${LOG_LEVEL}" STREQUAL "${LOG_INFO}") OR ("${LOG_LEVEL}" GREATER "${LOG_INFO}"))
    log_msg("${Green}INFO${ColorReset} ${msg}" ${LOG_INFO})
    #endif()
endfunction()

function(log_warn msg)
    #if(("${LOG_LEVEL}" STREQUAL "${LOG_WARN}") OR ("${ENABLE_LOGGING}") OR ("${LOG_LEVEL}" GREATER "${LOG_ERROR}"))
    #if(("${LOG_LEVEL}" STREQUAL "${LOG_WARN}") OR (NOT "${ENABLE_LOGGING}" STREQUAL OFF) OR ("${LOG_LEVEL}" GREATER "${LOG_WARN}"))
    #if(("${LOG_LEVEL}" STREQUAL "${LOG_WARN}") OR ("${LOG_LEVEL}" GREATER "${LOG_ERROR}"))
    log_msg("${Red}WARN${ColorReset} ${msg}" ${LOG_WARN})
    #endif()
endfunction()

function(debug variableName)
    if (ENABLE_LOGGING)
        debug("${variableName}=\${${variableName}}")
    endif()
endfunction()
