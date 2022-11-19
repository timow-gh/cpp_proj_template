# This file uses the same techniques as the example_library.
# Commands are only commented if they are different from the example_library.

file(GLOB HEADER_FILES ${CMAKE_CURRENT_LIST_DIR}/include/headeronly_supporting_lib/*.hpp)

set(TARGET_NAME headeronly_supporting_lib)
# This library is a header-only library, so we don't need to add any source files and set the library type to INTERFACE
add_library(${TARGET_NAME} INTERFACE)

# The header only library doesn't have need an export header.
# Therefore we don't need to include the ${CMAKE_CURRENT_BINARY_DIR}/export_header_includes/ directory
target_include_directories(${TARGET_NAME} INTERFACE "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>")

add_library(${TARGET_NAME}::${TARGET_NAME} ALIAS ${TARGET_NAME})

set(${TARGET_NAME}_MAJOR 0)
set(${TARGET_NAME}_MINOR 1)
set(${TARGET_NAME}_PATCH 0)
message(STATUS "Configuring ${TARGET_NAME} ${${TARGET_NAME}_MAJOR}.${${TARGET_NAME}_MINOR}.${${TARGET_NAME}_PATCH}")

set_target_properties(${TARGET_NAME}
        PROPERTIES
        LANGUAGE CXX
        DEBUG_POSTFIX d
        VERSION 0.1.0
        SOVERSION 0
        )

target_link_libraries(${TARGET_NAME} INTERFACE
        fmt::fmt
        )

install(DIRECTORY "include/${TARGET_NAME}" DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}")
install(TARGETS
        ${TARGET_NAME}
        EXPORT ${TARGET_NAME}TargetsExportSet
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

setupExportSetInstall("${TARGET_NAME}" "${TARGET_NAME}TargetsExportSet" "headeronly_supporting_libConfig.cmake.in" ${${TARGET_NAME}_MAJOR} ${${TARGET_NAME}_MINOR} ${${TARGET_NAME}_PATCH})

