cmake_minimum_required(VERSION 3.21) # CMakePresets are supported since version 3.21

project(use_installdir_proj
        VERSION 0.1.0
        LANGUAGES CXX)

set(${TARGET_NAME}_MAJOR 0)
set(${TARGET_NAME}_MINOR 1)
set(${TARGET_NAME}_PATCH 0)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
message(STATUS "PROJECT_SOURCE_DIR: ${PROJECT_SOURCE_DIR}")
include(${PROJECT_SOURCE_DIR}/cmake/project_preamble.cmake)

project_preamble()

# Find the installed package
find_package(cpp_proj_template CONFIG REQUIRED)

set(TARGET_NAME use_installdir)
# Use the installed package
add_executable(${TARGET_NAME} main.cpp)
target_link_libraries(${TARGET_NAME} PRIVATE cpp_proj_template::example_library)

set_target_properties(${TARGET_NAME}
        PROPERTIES
        LANGUAGE CXX
        LINKER_LANGUAGE CXX
        DEBUG_POSTFIX d
        VERSION ${${TARGET_NAME}_MAJOR}.${${TARGET_NAME}_MINOR}.${${TARGET_NAME}_PATCH}
        SOVERSION ${PROJECT_VERSION_MAJOR})

if (BUILD_SHARED_LIBS)
    # On Windows, the DLLs must be in the same directory as the executable.
    # Copy the dlls the executable depends into the directory of the executable.
    if (MSVC)
        add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
                COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_RUNTIME_DLLS:${TARGET_NAME}> $<TARGET_FILE_DIR:${TARGET_NAME}>
                COMMAND_EXPAND_LISTS
        )


        # Get all dependencies of the executable
        install(TARGETS ${TARGET_NAME}
                RUNTIME_DEPENDENCY_SET appDeps
                RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        )

        # Install the executable and all its dependencies, except for the system libraries
        install(RUNTIME_DEPENDENCY_SET appDeps
                PRE_EXCLUDE_REGEXES
                [[api-ms-win-.*]] [[ext-ms-.*]] [[kernel32\.dll]] [[msvc.*]] [[vcruntime.*]] [[ucrt.*]]
                POST_EXCLUDE_REGEXES
                [[.*/system32/.*\.dll]]
        )
    endif ()
else ()
    install(TARGETS ${TARGET_NAME} RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
endif ()