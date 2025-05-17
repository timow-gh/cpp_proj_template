# Basic package information
set(CPACK_PACKAGE_NAME "cpp_proj_template")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "cpp_proj_template")

# Make sure package directory is set correctly
if(NOT DEFINED CPACK_PACKAGE_DIRECTORY)
  set(CPACK_PACKAGE_DIRECTORY "${CMAKE_SOURCE_DIR}/out/packages")
endif()

set(CPACK_PACKAGE_VENDOR "MyCompany")
set(CPACK_PACKAGE_CONTACT "me@example.com")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "cpp_proj_template")

# These are still needed for proper versioning
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})

# Create standardized package filenames with version info

# Make sure the build type is correctly passed to CPack
if(CMAKE_BUILD_TYPE)
  set(CPACK_BUILD_CONFIG "${CMAKE_BUILD_TYPE}")
  set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}-${CMAKE_SYSTEM_NAME}-${CMAKE_BUILD_TYPE}")
else()
  set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}-${CMAKE_SYSTEM_NAME}")
endif()

# Ensure CPack uses the correct build configuration
set(CPACK_CMAKE_GENERATOR_PLATFORM "${CMAKE_GENERATOR_PLATFORM}")
set(CPACK_CMAKE_GENERATOR_TOOLSET "${CMAKE_GENERATOR_TOOLSET}")

# # Tell CPack which projects to install
# # Format: <build directory>;<project name>;<configuration>;<component or "ALL">
# if(CMAKE_BUILD_TYPE)
#   set(CPACK_INSTALL_CMAKE_PROJECTS "${CMAKE_BINARY_DIR};${PROJECT_NAME};${CMAKE_BUILD_TYPE};ALL")
# else()
#   # Fall back to Release if CMAKE_BUILD_TYPE not set
#   if(WIN32)
#     # Windows often uses multi-config generators, so we need to specify a config
#     set(CPACK_INSTALL_CMAKE_PROJECTS "${CMAKE_BINARY_DIR};${PROJECT_NAME};Release;ALL")
#   else()
#     # For single-config generators, just use whatever was built
#     set(CPACK_INSTALL_CMAKE_PROJECTS "${CMAKE_BINARY_DIR};${PROJECT_NAME};ALL;ALL")
#   endif()
# endif()

# # Force debug output to help diagnose what's being packaged
# message(STATUS "CMake binary dir: ${CMAKE_BINARY_DIR}")
# message(STATUS "Project name: ${PROJECT_NAME}")
# message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
# message(STATUS "CPACK_INSTALL_CMAKE_PROJECTS: ${CPACK_INSTALL_CMAKE_PROJECTS}")
# message(STATUS "CPACK_PACKAGE_DIRECTORY: ${CPACK_PACKAGE_DIRECTORY}")
# message(STATUS "Components: ${CPACK_COMPONENTS_ALL}")

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