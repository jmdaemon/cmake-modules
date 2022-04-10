# Utility C Library

set(UTILITY utility)
set(UTILITY_SRC ${PROJECT_SOURCE_DIR}/subprojects/utility)
set(UTILITY_HEADERS ${UTILITY_SRC}/include)
set(UTILITY_LIB_PATH ${UTILITY_SRC}/build/release/lib)
set(LIB_UTILITY ${UTILITY_LIB_PATH}/lib${UTILITY}.so)

#set(UTILITY_SRCS    ${UTILITY_LIBD}/src/file.c)

#find_library(${UTILITY_LIB}
    #NAMES ${UTILITY_LIB} libutility
    #HINTS ${UTILITY_LIBP} ${UTILITY_LIB_BIN}
    ##HINTS ${UTILITY_LIBP} ${UTILITY_LIBP}/lib${UTILITY_LIB}.so ${UTILITY_LIBD}
    ##IMPORTED_LOCATION /usr/local/lib/libhello-user.dll
    ##IMPORTED_LOCATION /usr/local/lib/libhello-user.dll
    #)

#add_library(${UTILITY_LIB} SHARED IMPORTED)
#set_property(
#TARGET ${UTILITY_LIB}
#PROPERTY IMPORTED_LOCATION ${UTILITY_LIB_BIN})

#set_property(
#TARGET ${UTILITY_LIB}
#PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${UTILITY_HEADERS})

add_library(${UTILITY} SHARED IMPORTED)
set_property(
TARGET ${UTILITY}
PROPERTY IMPORTED_LOCATION ${LIB_UTILITY})

set_property(
TARGET ${UTILITY}
PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${UTILITY_HEADERS})

if(NOT ${UTILITY})
    message(FATAL_ERROR "${UTILITY} not found!")
endif()
