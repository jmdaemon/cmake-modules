
# If the library is installed on our system
find_library(cnc HINTS /usr/local/lib)

# If the library is not installed on our system
if (NOT TARGET cnc) 
    # Fetch and build it with FetchContent 
    include(FetchContent)
    FetchContent_Declare(
        cnc
        GIT_REPOSITORY https://github.com/jmdaemon/cnc.git
        GIT_TAG master)
    FetchContent_MakeAvailable(cnc)
endif()
