include(FetchContent)
add_subdirectory(fmt)

if (${PROJECT_NAME}_BUILD_TESTS)
    add_subdirectory(googletest)
endif ()