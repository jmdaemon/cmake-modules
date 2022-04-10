# Require import_external_library cmake module function
include(Library)
# Utility C Library
set(UTILITY utility)
set(UTILITY_SRC ${PROJECT_SOURCE_DIR}/subprojects/${UTILITY})
import_external_library(
    NAME ${UTILITY}
    TYPE SHARED
    SOURCE_DIR ${UTILITY_SRC}
    HEADERS ${UTILITY_SRC}/include
    PATH ${UTILITY_SRC}/build/release/lib/lib${UTILITY}.so
    )
