
# If the library is installed on our system
find_library(cnc HINTS /usr/local/lib)

# If the library is not installed on our system
if (NOT TARGET cnc) 
    # Include the library
    set(CNC_LIB_SRC /usr/local/lib)
    set(CNC_LIB_FILE libcnc.so)
    # Import only if the library was installed system wide
    if (EXISTS "${CNC_LIB_SRC}/${CNC_LIB_FILE}")
        import_library(
            NAME cnc
            TYPE SHARED
            FILE ${CNC_LIB_FILE}
            SOURCE_DIR ${CNC_LIB_SRC})
    # If the library was not installed system wide
    else()
        # Fetch and build it with FetchContent 
        include(FetchContent)
        FetchContent_Declare(
            cnc
            GIT_REPOSITORY https://github.com/jmdaemon/cnc.git
            GIT_TAG master)
        FetchContent_MakeAvailable(cnc)
    endif()
endif()
