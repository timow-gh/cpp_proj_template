set(TARGET_NAME example_executable)

add_executable(${TARGET_NAME} main.cpp)
target_link_libraries(${TARGET_NAME} PRIVATE example_library::example_library)

set_target_properties(${TARGET_NAME}
        PROPERTIES
        LANGUAGE CXX
        LINKER_LANGUAGE CXX
        DEBUG_POSTFIX d
        VERSION ${${TARGET_NAME}_MAJOR}.${${TARGET_NAME}_MINOR}.${${TARGET_NAME}_PATCH}
        SOVERSION ${PROJECT_VERSION_MAJOR})

include(Warnings)
add_warnings_and_compile_options(${TARGET_NAME} cpp_proj_template_WARNINGS_AS_ERRORS)

install(TARGETS
        ${TARGET_NAME}
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})