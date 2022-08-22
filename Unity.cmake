include(Library)

# Library variables
set(TARG_NAME Unity)
set(LIB_NAME unity)
set(LIB_NAMES ${LIB_NAME} lib${LIB_NAME})
set(LIB_HEADER_DIR ${LIB_NAME})
set(LIB_GIT_REPO https://github.com/throwtheswitch/unity)

# Subproject variables
set(LIB_SUBPROJECT ${PROJECT_SOURCE_DIR}/subprojects/${LIB_NAME})
set(LIB_SUBPROJECT_INCLUDE ${PROJECT_SOURCE_DIR}/subprojects/${LIB_NAME}/src)

include_lib(
    NAME ${LIB_NAME}
    TARG_NAME ${TARG_NAME}
    TYPE STATIC
    NAMES ${LIB_NAMES}
    HDRD ${LIB_HEADER_DIR}
    REPO ${LIB_GIT_REPO}
    SP ${LIB_SUBPROJECT}
    SPI ${LIB_SUBPROJECT_INCLUDE})
