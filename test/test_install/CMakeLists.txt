set(test_target "example_library")
set(${test_target}_TEST_INSTALL_DIR "${CMAKE_CURRENT_BINARY_DIR}/${test_target}_install_dir")
set(${test_target}_TEST_SOURCE_DIR "${CMAKE_CURRENT_BINARY_DIR}/${test_target}_use_install_test")
set(${test_target}_TEMPLATE_PROJECT_DIR_NAME "${test_target}_install_test_template")

set(PRESET "")
if (MSVC)
    set(PRESET "windows-msvc-debug")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    set(PRESET "unixlike-clang-debug")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(PRESET "unixlike-gcc-debug")
else ()
    message(AUTHOR_WARNING "Unsupported compiler")
endif ()

# Possible extension:
# - Test with different CXX_STANDARD values for the test project
# - Test with different BUILD_SHARED_LIBS values for the test project

add_custom_target(test_install
        ${CMAKE_COMMAND} --install ${PROJECT_BINARY_DIR} --config ${CMAKE_BUILD_TYPE} --prefix ${${test_target}_TEST_INSTALL_DIR}

        COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${CMAKE_CURRENT_LIST_DIR}/${${test_target}_TEMPLATE_PROJECT_DIR_NAME}"
        ${${test_target}_TEST_SOURCE_DIR}

        COMMAND ${CMAKE_COMMAND}
        -B ${${test_target}_TEST_SOURCE_DIR}/build
        -S ${${test_target}_TEST_SOURCE_DIR}
        --preset "${PRESET}"
        # Test with the same BUILD_SHARED_LIBS value as the main project
        -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
        -DCMAKE_PREFIX_PATH=${${test_target}_TEST_INSTALL_DIR}

        COMMAND ${CMAKE_COMMAND}
        --build ${${test_target}_TEST_SOURCE_DIR}/build
        --config ${CMAKE_BUILD_TYPE}
        --parallel

        COMMAND ${CMAKE_COMMAND}
        --install ${${test_target}_TEST_SOURCE_DIR}/build
        --config ${CMAKE_BUILD_TYPE}
        --prefix ${${test_target}_TEST_SOURCE_DIR}/install
)

add_custom_target(test_install_clean
        ${CMAKE_COMMAND} -E rm -Rf ${${test_target}_TEST_INSTALL_DIR}
        COMMAND ${CMAKE_COMMAND} -E rm -Rf ${${test_target}_TEST_SOURCE_DIR}
)
