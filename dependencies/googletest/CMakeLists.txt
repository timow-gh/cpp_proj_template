CPMAddPackage(
        NAME googletest
        GITHUB_REPOSITORY google/googletest
        GIT_TAG release-1.12.1
        GIT_SHALLOW TRUE
        OPTIONS "INSTALL_GTEST OFF"
)

if(googletest_ADDED)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        target_compile_options(gtest_main INTERFACE
                "-Wno-weak-vtables"
                )
    endif ()
endif()