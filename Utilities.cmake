function(lslib)
    # Set make_library arguments
    set(ARG_PREFIX LIB)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME)
    set(_MULTI_VALUE_ARGS HEADERS)

    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

    message(STATUS, "Library Target Name: ${LIB_NAME}")
    message(STATUS, "Library Headers Directory: ${LIB_HEADERS}")
endfunction()

