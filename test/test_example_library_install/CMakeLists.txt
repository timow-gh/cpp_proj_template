set(target_name "example_library")
set(example_library_TEST_INSTALL_DIR "${CMAKE_CURRENT_BINARY_DIR}/${target_name}_test_install_dir")
set(example_library_TEST_SOURCE_DIR "${CMAKE_CURRENT_BINARY_DIR}/${target_name}_find_package_install_test")

add_custom_target(example_library_test_install
        ${CMAKE_COMMAND} --install ${PROJECT_BINARY_DIR} --config ${CMAKE_BUILD_TYPE} --prefix ${example_library_TEST_INSTALL_DIR}

        COMMAND ${CMAKE_COMMAND} -E copy_directory
        ${CMAKE_CURRENT_LIST_DIR}/template_find_package_install_test
        ${example_library_TEST_SOURCE_DIR}

        COMMAND ${CMAKE_COMMAND}
        -B ${example_library_TEST_SOURCE_DIR}/build
        -S ${example_library_TEST_SOURCE_DIR}
        --preset "windows-msvc-debug-developer-mode"
        -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
        -DCMAKE_CXX_STANDARD=${CMAKE_CXX_STANDARD}
        -DCMAKE_PREFIX_PATH=${example_library_TEST_INSTALL_DIR}

        COMMAND ${CMAKE_COMMAND}
        --build ${example_library_TEST_SOURCE_DIR}/build
        --config ${CMAKE_BUILD_TYPE}
        --parallel

        COMMAND ${CMAKE_COMMAND}
        --install ${example_library_TEST_SOURCE_DIR}/build
        --config ${CMAKE_BUILD_TYPE}
        --prefix ${example_library_TEST_SOURCE_DIR}/install
        )

add_custom_target(example_library_clean_test_install
        ${CMAKE_COMMAND} -E rm -Rf ${example_library_TEST_INSTALL_DIR}
        COMMAND ${CMAKE_COMMAND} -E rm -Rf ${example_library_TEST_SOURCE_DIR}
        )