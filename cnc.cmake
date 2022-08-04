# CNC
# Required Import
include(Library)

set(USE_AS_SUBMODULE OFF)

# Library Variables 
set(LIB_NAME cnc)
set(LIB_NAMES cnc libcnc)
set(LIB_PUBLIC_HEADER InputParser.h)
set(LIB_GIT_REPO https://github.com/jmdaemon/cnc)

## Subproject variables
set(LIB_SUBPROJECT ${PROJECT_SOURCE_DIR}/subprojects/cnc)
set(LIB_SUBPROJECT_INCLUDE ${PROJECT_SOURCE_DIR}/subprojects/cnc/include)
set(LIB_SUBPROJECT_DIR command)

include_lib(
        ${LIB_NAME}
        ${LIB_NAMES}
        ${LIB_PUBLIC_HEADER}
        ${LIB_GIT_REPO}
        ${LIB_SUBPROJECT}
        ${LIB_SUBPROJECT_INCLUDE}
        ${LIB_SUBPROJECT_DIR}
        )
