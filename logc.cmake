#
# Log.c
#

# Configures log.c as a git submodule/subproject
# Usage:
# 1. Include the library with target_link_libraries(TARGET logc)
# 2. Include the headers with target_include_directories(TARGET ${HEADERS_LOG_C})

# If the library hasn't been imported/included in our project
if (NOT TARGET logc)
    # Configure as a subproject
    set(SUBPROJECT_LOGC "${PROJECT_SOURCE_DIR}/subprojects/log.c")
    set(HEADERS_LOG_C "${PROJECT_SOURCE_DIR}/subprojects/log.c/src")
    if (EXISTS ${SUBPROJECT_LOGC})
        # Configure logc as a subproject
        set(LIB_NAME logc) # Shared library
        add_library(${LIB_NAME} SHARED
            "${PROJECT_SOURCE_DIR}/subprojects/log.c/src/log.c")
        target_include_directories(${LIB_NAME} PUBLIC ${HEADERS_LOG_C})
        set_target_properties(${LIB_NAME} PROPERTIES PUBLIC_HEADER "${HEADERS_LOG_C}/log.h")

        #set(LIB_NAME ${TARGET}_static) # Static library
        set(LIB_NAME logc_static) # Static library
        add_library(${LIB_NAME} STATIC
            "${PROJECT_SOURCE_DIR}/subprojects/log.c/src/log.c")
        target_include_directories(${LIB_NAME} PUBLIC "${HEADERS_LOG_C}")
    else()
        FetchContent_Declare(
            logc
            GIT_REPOSITORY https://github.com/rxi/log.c
            GIT_TAG        master
        )
        FetchContent_MakeAvailable(logc)
        # Get the source directory of log.c
        set(LOG_C_SRC_DIR ${logc_SOURCE_DIR})

        # Add the library
        add_library(logc SHARED)
        target_sources(logc
            PRIVATE "${LOG_C_SRC_DIR}/src/log.c"
            PUBLIC  "${LOG_C_SRC_DIR}/src")
        target_include_directories(logc PUBLIC "${LOG_C_SRC_DIR}/src")
        set_target_properties(logc PROPERTIES LINKER_LANGUAGE C)
        set(LOG_C_INCLUDES "${LOG_C_SRC_DIR}/src")
    endif()
endif()
