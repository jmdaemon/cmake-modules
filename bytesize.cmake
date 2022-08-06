# Bytesize C Library

# You can include bytesize into your project in two ways. You can:
# 1.a Install the library as a package system wide. 
# 2.b Toggle ${USE_AS_SUBMODULE}, and include library as a git submodule in your project.
include(Library)

set(USE_AS_SUBMODULE OFF)

# Library Variables 
set(LIB_NAME bytesize)
set(LIB_NAMES bytesize libbytesize)
set(LIB_PUBLIC_HEADER bytesize.h)
set(LIB_GIT_REPO https://github.com/jmdaemon/bytesize)

# Subproject variables
set(LIB_SUBPROJECT "${PROJECT_SOURCE_DIR}/subprojects/bytesize")
set(LIB_SUBPROJECT_INCLUDE "${PROJECT_SOURCE_DIR}/subprojects/bytesize/include")

include_lib(
    NAME ${LIB_NAME}
    NAMES ${LIB_NAMES}
    PUB ${LIB_PUBLIC_HEADER}
    REPO ${LIB_GIT_REPO}
    SP ${LIB_SUBPROJECT}
    SPI ${LIB_SUBPROJECT_INCLUDE})
