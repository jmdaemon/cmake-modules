# Utility C Library

# Require import_external_library cmake module function
include(Library)

set(ConfigureAsSubproject FALSE)

# If the library is installed on our system
find_library(utility HINTS /usr/local/lib)

# If the library is not installed on our system
if (NOT utility_FOUND)
    # Configure the library as a subproject in our main repository
    if (ConfigureAsSubproject)
        set(UTILITY utility)
        set(UTILITY_SRC ${PROJECT_SOURCE_DIR}/subprojects/${UTILITY})
        import_external_library(
            NAME ${UTILITY}
            TYPE SHARED
            SOURCE_DIR ${UTILITY_SRC}
            HEADERS ${UTILITY_SRC}/include
            PATH ${UTILITY_SRC}/build/release/lib/lib${UTILITY}.so)
    else()
    # Fetch and build it with FetchContent 
    include(FetchContent)
    FetchContent_Declare(
        utility
        GIT_REPOSITORY https://github.com/jmdaemon/utility.git
        GIT_TAG master)
    FetchContent_MakeAvailable(utility)
    endif()
endif()
