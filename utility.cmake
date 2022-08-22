include(Library)

# Library variables 
set(LIB_NAME utility)
set(LIB_GIT_REPO https://github.com/jmdaemon/utility)
set(LIB_NAMES ${LIB_NAME} lib${LIB_NAME})

# Subproject variables
set(LIB_SUBPROJECT ${PROJECT_SOURCE_DIR}/subprojects/${LIB_NAME})
set(LIB_SUBPROJECT_INCLUDE ${PROJECT_SOURCE_DIR}/subprojects/${LIB_NAME}/include)

include_lib(
    NAME ${LIB_NAME}
    NAMES ${LIB_NAMES}
    REPO ${LIB_GIT_REPO}
    SP ${LIB_SUBPROJECT}
    SPI ${LIB_SUBPROJECT_INCLUDE})
