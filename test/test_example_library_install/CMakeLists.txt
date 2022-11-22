set(target_name "example_library")
set(example_library_TEST_INSTALL_DIR "${CMAKE_CURRENT_BINARY_DIR}/${target_name}_test_install_dir")
set(example_library_TEST_SOURCE_DIR "${CMAKE_CURRENT_BINARY_DIR}/${target_name}_find_package_install_test")

add_custom_target(TestInstall_example_library
        ${CMAKE_COMMAND} --install ${PROJECT_BINARY_DIR} --config ${CMAKE_BUILD_TYPE} --prefix ${example_library_TEST_INSTALL_DIR}

        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_CURRENT_LIST_DIR}/template_find_package_install_test
        ${example_library_TEST_SOURCE_DIR}

        COMMAND ${CMAKE_COMMAND}
        -B ${example_library_TEST_SOURCE_DIR}/build
        -S ${example_library_TEST_SOURCE_DIR}
        --preset "windows-msvc-debug-developer-mode"
        -DCMAKE_PREFIX_PATH=${example_library_TEST_INSTALL_DIR}

        COMMAND ${CMAKE_COMMAND}
        --build ${example_library_TEST_SOURCE_DIR}/build
        --config ${CMAKE_BUILD_TYPE}
        --parallel

        COMMAND ${CMAKE_COMMAND}
        --build ${example_library_TEST_SOURCE_DIR}/build
        --config ${CMAKE_BUILD_TYPE}
        --parallel

        COMMAND ${CMAKE_COMMAND}
        --install ${example_library_TEST_SOURCE_DIR}/build
        --config ${CMAKE_BUILD_TYPE}
        --prefix ${example_library_TEST_SOURCE_DIR}/install

        COMMAND ${CMAKE_COMMAND}
        )

add_custom_target(Cleanup_TestInstall_example_library
        ${CMAKE_COMMAND} -E rm -R ${example_library_TEST_INSTALL_DIR}
        COMMAND
        ${CMAKE_COMMAND} -E rm -R ${example_library_TEST_SOURCE_DIR}
        )