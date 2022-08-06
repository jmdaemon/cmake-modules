# Check if Doxygen is installed
find_package(Doxygen)
if (DOXYGEN_FOUND)
    file(COPY Doxyfile DESTINATION ${CMAKE_BINARY_DIR})
    message("Doxygen build started")

    # Ensure that build/docs is created
    file(MAKE_DIRECTORY ${PROJECT_SOURCE_DIR}/build/docs)

    # Note the option ALL builds the docs together with the other targets
    add_custom_target(doc ALL
        COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_BINARY_DIR}/Doxyfile
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        COMMENT "Generating API documentation with Doxygen"
        VERBATIM)
else (DOXYGEN_FOUND)
  message("Doxygen need to be installed to generate the doxygen documentation")
endif (DOXYGEN_FOUND)
