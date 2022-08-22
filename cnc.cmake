include(Library)

# Library variables 
set(LIB_NAME cnc)
set(LIB_NAMES ${LIB_NAME} lib${LIB_NAME})
set(LIB_PUBLIC_HEADER InputParser.h)
set(LIB_GIT_REPO https://github.com/jmdaemon/cnc)

# Subproject variables
set(LIB_SUBPROJECT ${PROJECT_SOURCE_DIR}/subprojects/${LIB_NAME})
set(LIB_SUBPROJECT_INCLUDE ${PROJECT_SOURCE_DIR}/subprojects/${LIB_NAME}/include)
set(LIB_SUBPROJECT_DIR command)

include_lib(
    NAME ${LIB_NAME}
    PUB ${LIB_PUBLIC_HEADER}
    REPO ${LIB_GIT_REPO}
    SP ${LIB_SUBPROJECT}
    SPI ${LIB_SUBPROJECT_INCLUDE}
    SPD ${LIB_SUBPROJECT_DIR}
    NAMES ${LIB_NAMES})
