function(make_test)
    # Set make_test arguments
    set(ARG_PREFIX TEST)
    set(_OPTIONS_ARGS )
    set(_ONE_VALUE_ARGS NAME CSTANDARD)
    set(_MULTI_VALUE_ARGS HEADERS SOURCES DEPS)
    cmake_parse_arguments(${ARG_PREFIX} "${_OPTIONS_ARGS}" "${_ONE_VALUE_ARGS}" "${_MULTI_VALUE_ARGS}" ${ARGN})

    # Show make_tests arguments
    #message(STATUS "======================")
    #message(STATUS "make_library arguments: ${LIB_NAME}, followed by ${ARGN}")
    #message(STATUS "TEST_NAME: ${TEST_NAME}")
    #message(STATUS "TEST_CSTANDARD: ${TEST_CSTANDARD}")
    #message(STATUS "TEST_HEADERS: ${TEST_HEADERS}")
    #message(STATUS "TEST_SOURCES: ${TEST_SOURCES}")
    #message(STATUS "TEST_DEPS: ${TEST_DEPS}")
    #message(STATUS "======================")

    # Set TARGET
    # Creates test- prefix
    #set(${TARGET} "test-${TEST_NAME}")
    set(TARGET ${TEST_NAME})

    # Add tests
    add_executable(${TARGET} ${TEST_SOURCES})
    target_compile_features(${TARGET} PRIVATE ${TEST_CSTANDARD})
    target_link_libraries(${TARGET} PRIVATE ${TEST_DEPS})
    target_include_directories(${TARGET} PUBLIC ${TEST_HEADERS})
    add_test(NAME ${TARGET} COMMAND ${TARGET})
endfunction()

