# Basic package information
set(CPACK_PACKAGE_NAME "cpp_proj_template")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "cpp_proj_template")

set(CPACK_PACKAGE_VENDOR "MyCompany")
set(CPACK_PACKAGE_CONTACT "me@example.com")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Template project")

# These are still needed for proper versioning
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})

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