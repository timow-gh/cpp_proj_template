# Basic package information
set(CPACK_PACKAGE_NAME "cpp_proj_template")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "cpp_proj_template")

set(CPACK_PACKAGE_VENDOR "MyCompany")
set(CPACK_PACKAGE_CONTACT "me@example.com")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "cpp_proj_template")

# These are still needed for proper versioning
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})

# Create standardized package filenames with version info
set(CPACK_ARCHIVE_COMPONENT_INSTALL OFF)
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}-${CMAKE_SYSTEM_NAME}")

# Source package ignore patterns
set(CPACK_SOURCE_IGNORE_FILES
    "/\\\\.git/"
    "/\\\\.idea/"
    "/\\\\.cache/"
    "\\\\.swp"
    "\\\\.orig"
    "/CMakeLists\\\\.txt\\\\.user"
    "/out/"
)

include(CPack)