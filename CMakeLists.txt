cmake_minimum_required(VERSION 3.21) # CMakePresets are supported since version 3.21

project(cpp_proj_template
        VERSION 0.1.0
        LANGUAGES CXX)

# Make all modules available to this project and other projects that consume this project by
# adding the cmake directory to the CMAKE_MODULE_PATH
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
include(project_preamble)
include(setup_export_set_installation)

# Set common properties for cross platform builds
project_preamble()

# Create options for the project
set(ENABLE_DEVELOPER_MODE
        TRUE
        CACHE BOOL "Enable 'developer mode'")

if (ENABLE_DEVELOPER_MODE)
    option(${PROJECT_NAME}_TESTS "Build tests" ON)
    option(${PROJECT_NAME}_BENCHMARKS "Build benchmarks" ON)
    option(${PROJECT_NAME}_WARNINGS_AS_ERRORS "Treat compiler warnings as errors" ON)
    option(${PROJECT_NAME}_STATIC_ANALYSIS "" ON)
else ()
    option(${PROJECT_NAME}_TESTS "Build tests" OFF)
    option(${PROJECT_NAME}_BENCHMARKS "Build benchmarks" OFF)
    option(${PROJECT_NAME}_WARNINGS_AS_ERRORS "Treat compiler warnings as errors" OFF)
    option(${PROJECT_NAME}_STATIC_ANALYSIS "" OFF)
endif ()

option(${PROJECT_NAME}_PACKAGE "Use CPack to create an installer" ON)

# Add dependencies using the FetchContent module. This will download the dependencies and
# build them with this project.
add_subdirectory(dependencies)

# Use find_package to find dependencies that are installed on the system
# Example:
# find_package(Boost REQUIRED)

# Add the source code of this project
add_subdirectory(src)

# Add files for packaging if this project is the top level project
if (${PROJECT_NAME}_PACKAGE)
    # include(CPack) will happen inside the following call
    add_subdirectory(packaging)
endif ()

if (${PROJECT_NAME}_BENCHMARKS)
    add_subdirectory(benchmark)
endif ()

if (${PROJECT_NAME}_TESTS)
    include(CTest)
    # "This command should be in the source directory root because ctest expects to find a test
    # file in the build directory root.", CMake docs
    enable_testing()
    add_subdirectory(test)
endif ()

