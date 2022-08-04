
# Imports
include(Utilities)
include(ExternalProject)
include(FetchContent)

# Variables
set(LIB_NAME doctest)
set(LIB_REPO https://github.com/onqtam/doctest.git)

set(USE_EXTERNAL_PROJECT OFF)

# If the library hasn't been included before yet
if (NOT TARGET ${LIB_NAME})
    # Try building with FetchContent
    if (NOT ${USE_EXTERNAL_PROJECT})
        message(STATUS "Building ${LIB_NAME} with FetchContent")
        FetchContent_Declare(${LIB_NAME}
            GIT_REPOSITORY  ${LIB_REPO})
        FetchContent_MakeAvailable(${LIB_NAME})
        #set(DOCTEST_INCLUDE_DIR  CACHE INTERNAL "Path to include folder for doctest")
        #set(DOCTEST_SOURCE_DIR ${source_dir})
        FetchContent_GetProperties(doctest)

        # Export global variables for projects
        set(DOCTEST_SOURCE_DIR ${doctest_SOURCE_DIR} CACHE INTERNAL "Source folder for doctest")
        set(DOCTEST_INCLUDE_DIR ${doctest_SOURCE_DIR}/doctest CACHE INTERNAL "Header directory for doctest")
        log_debug(STATUS "DOCTEST_INCLUDE_DIR: ${DOCTEST_INCLUDE_DIR}")
        log_debug(STATUS "DOCTEST_SOURCE_DIR: ${DOCTEST_SOURCE_DIR}")
        #FetchContent_GetProperties(doctest)
        #if(NOT doctest_POPULATED)
          #FetchContent_Populate(doctest)
          #add_subdirectory(${doctest_SOURCE_DIR} ${doctest_BINARY_DIR})
        #endif()
        return()
    elseif(${USE_EXTERNAL_PROJECT})
        find_package(Git REQUIRED)
        ExternalProject_Add( # https://github.com/onqtam/doctest/blob/master/doc/markdown/build-systems.md
            doctest
            PREFIX ${CMAKE_BINARY_DIR}/doctest
            GIT_REPOSITORY https://github.com/onqtam/doctest.git
            TIMEOUT 10
            UPDATE_COMMAND ${GIT_EXECUTABLE} pull
            CONFIGURE_COMMAND ""
            BUILD_COMMAND ""
            INSTALL_COMMAND ""
            LOG_DOWNLOAD ON)

        ExternalProject_Get_Property(doctest source_dir) # Expose required variable (DOCTEST_INCLUDE_DIR) to parent scope
        set(DOCTEST_INCLUDE_DIR ${source_dir}/doctest CACHE INTERNAL "Path to include folder for doctest")
        set(DOCTEST_SOURCE_DIR ${source_dir})
        return()
    endif()
endif()
