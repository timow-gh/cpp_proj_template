include(FetchContent)
add_subdirectory(fmt)

if (${PROJECT_NAME}_TESTS)
    add_subdirectory(googletest)
endif ()