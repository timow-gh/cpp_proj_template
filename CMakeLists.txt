cmake_minimum_required(VERSION 3.28) # CMakePresets are supported since version 3.21

# Make all modules available to this project and other projects that consume this project by
# adding the cmake directory to the CMAKE_MODULE_PATH
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

# Auto-detect and use Ninja if available (must be before project() call)
include(detect_ninja)

project(cpp_proj_template
        VERSION 0.1.0
        LANGUAGES CXX)


include(warnings)
include(static_analysis)

include(cmake/CPM.cmake)
if (NOT CPM_SOURCE_CACHE AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/CPMSourceVariable.cmake")
    include(CPMSourceVariable.cmake)
endif ()

if (NOT CPM_SOURCE_CACHE)
    message(AUTHOR_WARNING "CPM_SOURCE_CACHE not set. The source files are downloaded for every build. This is not recommended.
        Set the CPM_SOURCE_CACHE variable to a directory of your choice to cache the cloned git repositories.
        Set the CPM_SOURCE_CACHE variable in CPMSourceVariable.cmake to keep your paths private.")
endif ()

# Set common properties for cross platform builds
include(project_preamble)
project_preamble()

# Use IS_TOP_LEVEL_PROJECT to detect if this project is the top level project.
# If this project is not the top level project, use the IS_TOP_LEVEL_PROJECT variable
# to remove project specific settings like WarningsAsErrors or StaticAnalysis.
# The use of settings of this project should not affect the settings of the parent project.
if ((CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR))
    set(IS_TOP_LEVEL_PROJECT TRUE)
else ()
    set(IS_TOP_LEVEL_PROJECT FALSE)
endif ()

if (IS_TOP_LEVEL_PROJECT)
    option(${PROJECT_NAME}_USE_SCCACHE "Use sccache" ON)
    option(${PROJECT_NAME}_USE_WARNINGS "Compile using warnings." ON)
    option(${PROJECT_NAME}_WARNINGS_AS_ERRORS "Treat compiler warnings as errors " ON)
    option(${PROJECT_NAME}_STATIC_ANALYSIS "" ON)
    option(${PROJECT_NAME}_USE_CPPCHECK "" OFF)
    option(${PROJECT_NAME}_TESTS "" ON)
    option(${PROJECT_NAME}_BENCHMARKS "" ON)
else ()
    option(${PROJECT_NAME}_USE_SCCACHE "Use sccache" OFF)
    option(${PROJECT_NAME}_USE_WARNINGS "Compile using warnings." OFF)
    option(${PROJECT_NAME}_WARNINGS_AS_ERRORS "Treat compiler warnings as errors" OFF)
    option(${PROJECT_NAME}_STATIC_ANALYSIS "" OFF)
    option(${PROJECT_NAME}_USE_CPPCHECK "" OFF)
    option(${PROJECT_NAME}_TESTS "" OFF)
    option(${PROJECT_NAME}_BENCHMARKS "" OFF)
endif ()
# It is possible to exclude this project from installation by setting the following option to OFF.
# This is useful if you want to use this project as a subproject in another project.
option(${PROJECT_NAME}_INSTALL "Install project targets" ON)
option(${PROJECT_NAME}_BUILD_DOCUMENTATION "Build documentation" OFF)

if (${PROJECT_NAME}_USE_SCCACHE)
    include(setup_sccache)
    enable_sccache()
endif ()

if (${PROJECT_NAME}_USE_CPPCHECK)
    include(cppcheck)
    create_cppcheck_target(${TARGET_NAME})
endif ()

# Use find_package to find dependencies that are installed on the system
# Example:
# find_package(Boost REQUIRED)

# Add dependencies using the FetchContent module. This will download the dependencies and
# build them with this project.
add_subdirectory(dependencies)

if (${PROJECT_NAME}_BUILD_DOCUMENTATION)
    include(setup_doxygen)
    enable_doxygen()
endif ()

# Add the source code of this project
add_subdirectory(src)

add_subdirectory(packaging)

if (${PROJECT_NAME}_TESTS)
    include(CTest)
    # "This command should be in the source directory root because ctest expects to find a test
    # file in the build directory root.", CMake docs
    enable_testing()
    add_subdirectory(test)
endif ()

if (${PROJECT_NAME}_BENCHMARKS)
    add_subdirectory(benchmark)
endif ()


