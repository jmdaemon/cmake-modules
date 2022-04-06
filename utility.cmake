# Utility C Library
set(UTILITY_LIBP "${PROJECT_SOURCE_DIR}/subprojects/utility/build/release/lib")
set(UTILITY_LIBD "${PROJECT_SOURCE_DIR}/subprojects/utility")
set(UTILITY_SRCS "${UTILITY_LIBD}/src/file.c")
set(UTILITY_HEADERS "${PROJECT_SOURCE_DIR}/subprojects/utility/include")
set(UTILITY_LIB utility)

find_library(${UTILITY_LIB}
    NAMES ${UTILITY_LIB} libutility
    HINTS ${UTILITY_LIBP} ${UTILITY_LIBD})

