# CNC
include(Library)

set(USE_AS_SUBMODULE OFF)

# Library Variables 
set(LIB_NAME cnc)
set(LIB_NAMES cnc libcnc)
set(LIB_PUBLIC_HEADER InputParser.h)
set(LIB_GIT_REPO https://github.com/jmdaemon/cnc)

# Subproject variables
set(LIB_SUBPROJECT ${PROJECT_SOURCE_DIR}/subprojects/cnc)
set(LIB_SUBPROJECT_INCLUDE ${PROJECT_SOURCE_DIR}/subprojects/cnc/include)
set(LIB_SUBPROJECT_DIR command)

include_lib(
    NAME ${LIB_NAME}
    PUB ${LIB_PUBLIC_HEADER}
    REPO ${LIB_GIT_REPO}
    SP ${LIB_SUBPROJECT}
    SPI ${LIB_SUBPROJECT_INCLUDE}
    SPD ${LIB_SUBPROJECT_DIR}
    NAMES ${LIB_NAMES})
