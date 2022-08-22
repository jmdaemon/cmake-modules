# You can use this library two ways. Either:
# - Install the library as a package system wide or
# - Set ${USE_AS_SUBMODULE}, and include the library as a git submodule.
include(Library)

# Library variables 
set(LIB_NAME bytesize)
set(LIB_NAMES ${LIB_NAME} lib${LIB_NAME})
set(LIB_GIT_REPO https://github.com/jmdaemon/bytesize)

# Subproject variables
set(LIB_SUBPROJECT ${PROJECT_SOURCE_DIR}/subprojects/${LIB_NAME})
set(LIB_SUBPROJECT_INCLUDE ${PROJECT_SOURCE_DIR}/subprojects/${LIB_NAME}/include)

include_lib(
    NAME ${LIB_NAME}
    NAMES ${LIB_NAMES}
    PUB ${LIB_PUBLIC_HEADER}
    REPO ${LIB_GIT_REPO}
    SP ${LIB_SUBPROJECT}
    SPI ${LIB_SUBPROJECT_INCLUDE})
