# Utility C Library
set(UTILITY_LIB utility)

set(UTILITY_LIBR    ${PROJECT_SOURCE_DIR}/subprojects/utility/build/release/lib)
set(UTILITY_LIB_BIN ${UTILITY_LIBR}/${UTILITY_LIB}.so)
set(UTILITY_LIBD    ${PROJECT_SOURCE_DIR}/subprojects/utility)
#set(UTILITY_SRCS    ${UTILITY_LIBD}/src/file.c)
set(UTILITY_HEADERS ${PROJECT_SOURCE_DIR}/subprojects/utility/include)

find_library(${UTILITY_LIB}
    NAMES ${UTILITY_LIB} libutility
    HINTS ${UTILITY_LIBP} ${UTILITY_LIB_BIN}
    #HINTS ${UTILITY_LIBP} ${UTILITY_LIBP}/lib${UTILITY_LIB}.so ${UTILITY_LIBD}
    #IMPORTED_LOCATION /usr/local/lib/libhello-user.dll
    #IMPORTED_LOCATION /usr/local/lib/libhello-user.dll
    )
