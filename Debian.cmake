set(CPACK_PACKAGE_NAME ${PROJECT_NAME}
    CACHE STRING "The resulting package name")

set(CPACK_PACKAGE_DESCRIPTION_SUMMARY ${CMAKE_PROJECT_DESCRIPTION}
    CACHE STRING "Package description for the package metadata")

set(CPACK_VERBATIM_VARIABLES YES)
set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CPACK_PACKAGE_NAME})

# Stores the output into _packages
# This is good for keeping an archive of all past project versions
set(CPACK_PACKAGE_DIRECTORY "${CMAKE_SOURCE_DIR}/_packages/${CMAKE_PROJECT_NAME}-${CMAKE_PROJECT_VERSION}")

# Set package install path
set(CPACK_PACKAGING_INSTALL_PREFIX "/usr/")

# Set package versions
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})

# Set maintainer name and email
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "$ENV{MAINTAINER_NAME}")
set(CPACK_PACKAGE_CONTACT "$ENV{MAINTAINER_EMAIL}")

# Include project resource files
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")

set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_CURRENT_SOURCE_DIR}/README.md")

# Naming scheme for Debian packages
# When set, this generates app_0.1.0_amd64.deb
# instead of app-0.1.0-Linux.deb (note the underscores)
set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)

# Create .deb, .tgz, .zip files
set(CPACK_GENERATOR "DEB;TGZ;ZIP")

set(CPACK_DEBIAN_PACKAGE_DEPENDS ${DEB_DEPENDS})

set(CPACK_SOURCE_IGNORE_FILES
    /dist
    /.*build.*
    /\\\\.DS_Store)

include(CPack)
