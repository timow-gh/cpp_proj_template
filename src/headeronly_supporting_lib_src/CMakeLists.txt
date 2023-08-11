# This file uses the same techniques as the example_library.
# Commands are only commented if they are different from the example_library.

set(TARGET_NAME headeronly_supporting_lib)
# This library is a header-only library, so we don't need to add any source files and set the library type to INTERFACE
add_library(${TARGET_NAME} INTERFACE)
add_library(${PROJECT_NAME}::${TARGET_NAME} ALIAS ${TARGET_NAME})

# Since this is a header-only library, we don't need to link any libraries but all targets
# that use this library need to link fmt. Therefore we add fmt as an interface library.
target_link_libraries(${TARGET_NAME} INTERFACE fmt::fmt)

# The header only library doesn't have need an export header.
# Therefore we don't need to include the ${CMAKE_CURRENT_BINARY_DIR}/export_header_includes/ directory
target_include_directories(${TARGET_NAME} INTERFACE "$<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>")

set(${TARGET_NAME}_MAJOR 0)
set(${TARGET_NAME}_MINOR 1)
set(${TARGET_NAME}_PATCH 0)
message(STATUS "Configuring ${TARGET_NAME} ${${TARGET_NAME}_MAJOR}.${${TARGET_NAME}_MINOR}.${${TARGET_NAME}_PATCH}")

set_target_properties(${TARGET_NAME}
        PROPERTIES
        LANGUAGE CXX
        DEBUG_POSTFIX d
        VERSION ${${TARGET_NAME}_MAJOR}.${${TARGET_NAME}_MINOR}.${${TARGET_NAME}_PATCH}
        SOVERSION ${${TARGET_NAME}_MAJOR}
)

add_warnings_and_compile_options(${TARGET_NAME} "${${PROJECT_NAME}_WARNINGS_AS_ERRORS}")
if (${PROJECT_NAME}_STATIC_ANALYSIS)
    enable_static_analysis(${TARGET_NAME} "${${PROJECT_NAME}_WARNINGS_AS_ERRORS}")
endif ()

if (${PROJECT_NAME}_INSTALL)
    # We don't need to install the headeronly_supporting_lib headers, since this library is not intended to be used
    # directly by other projects.
    #    install(DIRECTORY "include/${TARGET_NAME}" DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}")

    # We need to install the export set, if this project builds shared libraries.
    # In this case, the linked libraries need to be exported, so that the targets can be found by other projects.
    # For this lib, we need to export fmt.
    install(TARGETS ${TARGET_NAME}
            EXPORT ${project_export_set_name}
            RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
            LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
            ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
            INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
endif ()
