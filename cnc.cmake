# CNC
# Required Import
include(Library)

# Library Variables 
set(LIB_NAME cnc)
set(LIB_NAMES cnc libcnc)
set(LIB_PUBLIC_HEADER cnc.h)
set(LIB_GIT_REPO https://github.com/jmdaemon/cnc)

## Subproject variables
set(LIB_SUBPROJECT "${PROJECT_SOURCE_DIR}/subprojects/cnc")
set(LIB_SUBPROJECT_INCLUDE "${PROJECT_SOURCE_DIR}/subprojects/cnc/include")

include_lib(
        ${LIB_NAME}
        ${LIB_NAMES}
        ${LIB_PUBLIC_HEADER}
        ${LIB_GIT_REPO}
        ${LIB_SUBPROJECT}
        ${LIB_SUBPROJECT_INCLUDE})
