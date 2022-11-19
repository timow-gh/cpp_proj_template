include(FetchContent)
add_subdirectory(fmt)

if (cpp_proj_template_BUILD_TESTS)
    add_subdirectory(googletest)
endif ()