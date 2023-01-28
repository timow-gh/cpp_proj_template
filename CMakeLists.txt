cmake_minimum_required(VERSION 3.21) # CMakePresets are supported since version 3.21

project(cpp_proj_template
        VERSION 0.1.0
        LANGUAGES CXX)

# Make all modules available to this project and other projects that consume this project by
# adding the cmake directory to the CMAKE_MODULE_PATH
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
include(project_preamble)
include(setup_export_set_installation)
include(cmake/CPM.cmake)
include(CPMSourceVariable.cmake)

# Set common properties for cross platform builds
project_preamble()

# Create options for the project
set(ENABLE_DEVELOPER_MODE
        TRUE
        CACHE BOOL "Enable 'developer mode'")

if ((CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR))
    set(IS_TOP_LEVEL_PROJECT TRUE)
else ()
    set(IS_TOP_LEVEL_PROJECT FALSE)
endif ()

if (IS_TOP_LEVEL_PROJECT)
    option(${PROJECT_NAME}_USE_SCCACHE "Use sccache" ON)
    option(${PROJECT_NAME}_WARNINGS_AS_ERRORS "Treat compiler warnings as errors" ON)
    option(${PROJECT_NAME}_STATIC_ANALYSIS "" ON)
    option(${PROJECT_NAME}_TESTS "" ON)


    # check if the file CPMSourceVariable.cmake exists in project root
    if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/CPMSourceVariable.cmake")
        include(CPMSourceVariable.cmake)
    else ()
        message(AUTHOR_WARNING "CPMSourceVariable.cmake not found. Set the CPM_SOURCE_CACHE variable to a directory to cache the git clones or create a the CPMSourceVariable.cmake file in the project root. Set the CPM_SOURCE_CACHE variable in CPMSourceVariable.cmake to keep your paths private.")
    endif ()

    if (NOT CPM_SOURCE_CACHE)
        message(AUTHOR_WARNING "CPM_SOURCE_CACHE not set. The source files are downloaded for each project.")
    endif ()
else ()
    option(${PROJECT_NAME}_USE_SCCACHE "Use sccache" OFF)
    option(${PROJECT_NAME}_WARNINGS_AS_ERRORS "Treat compiler warnings as errors" OFF)
    option(${PROJECT_NAME}_STATIC_ANALYSIS "" OFF)
    option(${PROJECT_NAME}_TESTS "" OFF)
endif ()

if (${PROJECT_NAME}_USE_SCCACHE)
    if (NOT "${CMAKE_GENERATOR}" STREQUAL "Ninja")
        message(AUTHOR_WARNING "sccache is only testet with the generator Ninja. Setting ${PROJECT_NAME}_USE_SCCACHE to OFF.")
        set(${PROJECT_NAME}_USE_SCCACHE OFF CACHE BOOL "" FORCE)
    endif ()

    find_program(CCACHE_PROGRAM sccache)
    message(STATUS "CCACHE_PROGRAM=${CCACHE_PROGRAM}")
    if (CCACHE_PROGRAM)
        # Makefile Generators and the Ninja generator prefix compiler commands with the given launcher command line.
        # This is intended to allow launchers to intercept build problems with high granularity. Other generators ignore
        # this property because their underlying build systems provide no hook to wrap individual commands with a launcher.
        set(CMAKE_C_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
        set(CMAKE_CXX_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
    else ()
        message(AUTHOR_WARNING "sccache not found. Please install it or disable USE_SCCACHE")
    endif ()

    include(cmake/sccache_setup.cmake)
    fix_msvc_ninja_compile_flags()
endif ()

message(STATUS "${PROJECT_NAME}_USE_SCCACHE: ${${PROJECT_NAME}_USE_SCCACHE}")
message(STATUS "${PROJECT_NAME}_WARNINGS_AS_ERRORS: ${${PROJECT_NAME}_WARNINGS_AS_ERRORS}")
message(STATUS "${PROJECT_NAME}_STATIC_ANALYSIS: ${${PROJECT_NAME}_STATIC_ANALYSIS}")
# It is possible to exclude this project from installation by setting the following option to OFF.
# This is useful if you want to use this project as a subproject in another project.
option(${PROJECT_NAME}_INSTALL "Install project targets" ON)
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

