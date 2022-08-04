# Bytesize C Library

# You can include bytesize into your project in two ways. You can:
# 1.a Install the library as a package system wide. 
# 2.b Toggle ${USE_AS_SUBMODULE}, and include library as a git submodule in your project.
#set(USE_AS_SUBMODULE OFF)

# *Note* that if you are building Bytesize as a subproject. Bytesize depends on log.c and
# Unity. If these are also configured # as subprojects, then you can include them with:
# include(logc)
# include(Unity)
# Given that you are using my cmake-modules here: https://github.com/jmdaemon/cmake-modules
# Otherwise they must be installed on your system or configured as a subproject manually.

# Required Import
include(Library)

# Library Variables 
set(LIB_NAME bytesize)
set(LIB_NAMES bytesize libbytesize)
set(LIB_PUBLIC_HEADER bytesize.h)
set(LIB_GIT_REPO https://github.com/jmdaemon/bytesize)

# Subproject variables
set(LIB_SUBPROJECT "${PROJECT_SOURCE_DIR}/subprojects/bytesize")
set(LIB_SUBPROJECT_INCLUDE "${PROJECT_SOURCE_DIR}/subprojects/bytesize/include")
set(LIB_SUBPROJECT_DIR "")

include_lib(NAME LIB_NAME
    NAMES LIB_NAMES
    PUB LIB_PUBLIC_HEADER
    REPO LIB_GIT_REPO
    SP LIB_SUBPROJECT
    SPI LIB_SUBPROJECT_INCLUDE
    SPD LIB_SUBPROJECT_DIR)
