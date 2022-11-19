cmake_minimum_required(VERSION 3.21) # CMakePresets are supported since version 3.21

project(use_installdir_proj
        VERSION 0.1.0
        LANGUAGES CXX)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmake/preamble.cmake)

preamble()

# Find the installed package
find_package(example_library CONFIG REQUIRED)

# Use the installed package
add_executable(use_installdir main.cpp)
target_link_libraries(use_installdir PRIVATE example_library::example_library)

add_custom_command(TARGET use_installdir POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_RUNTIME_DLLS:use_installdir> $<TARGET_FILE_DIR:use_installdir>
        COMMAND_EXPAND_LISTS
        )