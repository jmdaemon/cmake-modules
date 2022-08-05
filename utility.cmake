# Utility C Library
include(Library)

set(USE_AS_SUBMODULE OFF)

# Library Variables 
set(LIB_NAME utility)
set(LIB_NAMES ${LIB_NAME} lib${LIB_NAME})
set(LIB_PUBLIC_HEADER file.h)
set(LIB_GIT_REPO https://github.com/jmdaemon/utility)

# Subproject variables
set(LIB_SUBPROJECT ${PROJECT_SOURCE_DIR}/subprojects/utility)
set(LIB_SUBPROJECT_INCLUDE ${PROJECT_SOURCE_DIR}/subprojects/utility/include)

include_lib(
    NAME ${LIB_NAME}
    NAMES ${LIB_NAMES}
    PUB ${LIB_PUBLIC_HEADER}
    REPO ${LIB_GIT_REPO}
    SP ${LIB_SUBPROJECT}
    SPI ${LIB_SUBPROJECT_INCLUDE})
