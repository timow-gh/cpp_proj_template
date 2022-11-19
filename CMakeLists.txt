cmake_minimum_required(VERSION 3.21) # CMakePresets are supported since version 3.21

project(cpp_proj_template
        VERSION 0.1.0
        LANGUAGES CXX)

# Make all modules available to this project and other projects that consume this project by
# adding the cmake directory to the CMAKE_MODULE_PATH
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmake/preamble.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmake/setupExportSetInstall.cmake)

# Set common properties for cross platform builds
preamble()

# Create options for the project
option(cpp_proj_template_BUILD_TESTS "Build tests" ON)
option(cpp_proj_template_BUILD_BENCMARKS "Build benchmarks" ON)

# Add dependencies using the FetchContent module. This will download the dependencies and
# build them with this project.
add_subdirectory(dependencies)

# Use find_package to find dependencies that are installed on the system
# Example:
# find_package(Boost REQUIRED)

# Add the source code of this project
add_subdirectory(src)

# Add files for packaging if this project is the top level project
if (CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    # include(CPack) will happen inside the following call
    add_subdirectory(packaging)
endif ()

if (cpp_proj_template_BUILD_BENCMARKS)
    add_subdirectory(benchmark)
endif ()

if (cpp_proj_template_BUILD_TESTS)
    include(CTest)
    # "This command should be in the source directory root because ctest expects to find a test file in the build directory root.", CMake docs
    enable_testing()
    add_subdirectory(test)
endif ()

