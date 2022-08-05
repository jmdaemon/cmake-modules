# Unity Testing Framework
include(Library)

set(LIB_NAME Unity)
set(LIB_NAMES unity libunity)
set(LIB_PUBLIC_HEADER unity.h)
set(LIB_HEADER_DIR unity)
set(LIB_GIT_REPO https://github.com/throwtheswitch/unity)

# Subproject variables
set(LIB_SUBPROJECT "${PROJECT_SOURCE_DIR}/subprojects/unity")
set(LIB_SUBPROJECT_INCLUDE "${PROJECT_SOURCE_DIR}/subprojects/unity/src")

include_lib(
    NAME ${LIB_NAME}
    TYPE STATIC
    NAMES ${LIB_NAMES}
    PUB ${LIB_PUBLIC_HEADER}
    HDRD ${LIB_HEADER_DIR}
    REPO ${LIB_GIT_REPO}
    SP ${LIB_SUBPROJECT}
    SPI ${LIB_SUBPROJECT_INCLUDE}
    SPD ${LIB_SUBPROJECT_DIR})
