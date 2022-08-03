# Bytesize C Library

# Note that there are a few ways you can specify bytesize
# 1. As a system-wide installed library "in /usr/local/lib/"
# 2. As a subproject in subprojects/bytesize (requires you to build the library first)
# 3. As a dependency to be built alongside the project code
# Note that currently only 1-2 are supported for now

# Imports
include(Library)

# Variables 
set(LIB_NAME bytesize)
set(LIB_NAMES bytesize libbytesize)

# If the library hasn't been included
if (NOT TARGET bytesize)
    message(STATUS "Finding library: ${LIB_NAME}")
    # Find the package on our system
    set(USR /usr/lib)
    set(USR_LOCAL /usr/local/lib)

    set(LIB_USR ${USR}/lib${LIB_NAME}.so)
    set(LIB_LOCAL ${USR_LOCAL}/lib${LIB_NAME}.so)

    if (EXISTS ${LIB_USR})
        # Found under /usr/local/lib
        message(STATUS "Found: ${LIB_USR}")
        find_library(${LIB_NAME} NAMES ${LIB_NAMES} HINTS ${LIB_USR})
        add_library(${LIB_NAME} SHARED IMPORTED GLOBAL)
        set_target_properties(${LIB_NAME} PROPERTIES
            IMPORTED_LOCATION ${LIB_USR})

        #find_library(CURL_LIBRARY
    #NAMES curl curllib libcurl_imp curllib_static
    #HINTS "${CMAKE_PREFIX_PATH}/curl/lib"
)
    elseif(${LIB_LOCAL})
        # Found under /usr/lib
        message(STATUS "Found: ${LIB_LOCAL}")
        find_library(${LIB_NAME} NAMES ${LIB_NAMES} HINTS ${LIB_LOCAL})
        add_library(${LIB_NAME} SHARED IMPORTED GLOBAL)
        set_target_properties(${LIB_NAME} PROPERTIES
            IMPORTED_LOCATION ${LIB_LOCAL})
    endif()
    

    #set(BYTESIZE_LIB_SRC /usr/local/lib)
    #set(BYTESIZE_LIB_SRC /usr/lib)
    #set(BYTESIZE_LIB_FILE libbytesize.so)
    # Import only if the library was installed system wide
    #if (EXISTS "${BYTESIZE_LIB_SRC}/${BYTESIZE_LIB_FILE}")
        #import_library(
            #NAME bytesize
            #TYPE SHARED
            #FILE ${BYTESIZE_LIB_FILE}
            #HEADERS ${LOG_C_INCLUDES}
            #DEPS logc
            #SOURCE_DIR ${BYTESIZE_LIB_SRC})

    # If the library was not installed system wide
    # Configure as a subproject
    else()
        message(STATUS "Configuring bytesize as a subproject")
        set(SUBPROJECT_BYTESIZE "${PROJECT_SOURCE_DIR}/subprojects/bytesize")
        set(HEADERS_BYTESIZE "${PROJECT_SOURCE_DIR}/subprojects/bytesize/include")
        if (EXISTS ${SUBPROJECT_BYTESIZE})
            FetchContent_Declare(bytesize
                GIT_REPOSITORY  https://github.com/jmdaemon/bytesize
                SOURCE_DIR      ${SUBPROJECT_BYTESIZE})

            set(LIB_NAME bytesize)
            add_library(${LIB_NAME})
            target_link_libraries(${LIB_NAME} PUBLIC bytesize)
            # Configure logc as a subproject
            #set(LIB_NAME bytesize) # Shared library
            #add_library(${LIB_NAME} SHARED
                #"${PROJECT_SOURCE_DIR}/subprojects/log.c/src/log.c")
            #target_include_directories(${LIB_NAME} PUBLIC ${HEADERS_LOG_C})
            #set_target_properties(${LIB_NAME} PROPERTIES PUBLIC_HEADER "${HEADERS_LOG_C}/log.h")

            ##set(LIB_NAME ${TARGET}_static) # Static library
            #set(LIB_NAME logc_static) # Static library
            #add_library(${LIB_NAME} STATIC
                #"${PROJECT_SOURCE_DIR}/subprojects/log.c/src/log.c")
            #target_include_directories(${LIB_NAME} PUBLIC "${HEADERS_LOG_C}")
        endif()

        # Configure the library as a subproject in our main repository
        #message(STATUS "\"libbytesize.so\" not found")

        #set(BYTESIZE bytesize)
        #set(BYTESIZE_SRC ${PROJECT_SOURCE_DIR}/subprojects/${BYTESIZE})
        #set(BYTESIZE_FILE ${BYTESIZE_SRC}/build/release/lib/lib${BYTESIZE}.so)
        ## If the generated library exists
        #if (EXISTS ${BYTESIZE_FILE})
            ## Import the shared library
            ## Note that this requires you to first generate the library
            #import_external_library(
                #NAME ${BYTESIZE}
                #TYPE SHARED
                #SOURCE_DIR ${BYTESIZE_SRC}
                #HEADERS ${BYTESIZE_SRC}/include
                ##HEADERS ${LOG_C_INCLUDES} ${BYTESIZE_SRC}/include
                ##DEPS logc
                #PATH ${BYTESIZE_FILE})
        #else()
            ## Fetch the git repository
            ## Specify some build commands
            ## Add the library
        #endif()
    endif()
endif()
