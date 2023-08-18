include_guard()

function(setup_export_set_installation
        project_name
        export_set_name
        config_cmake_in_file_name
        major_version
        minor_version
        patch_version)
    include(GNUInstallDirs)
    include(CMakePackageConfigHelpers)

    set(${target_name}_CONFIG_IN_FILE
            "${PROJECT_SOURCE_DIR}/cmake/${config_cmake_in_file_name}"
            CACHE STRING "Path to the ${project_name} Config*.cmake.in file.")

    message(STATUS "${project_name} ${config_cmake_in_file_name} file path: ${${target_name}_CONFIG_IN_FILE}")

    if (NOT EXISTS "${${target_name}_CONFIG_IN_FILE}")
        message(STATUS "Absolute ${config_cmake_in_file_name} path: ${${target_name}_CONFIG_IN_FILE}")
        message(FATAL_ERROR "Missing file ${config_cmake_in_file_name}")
        return()
    endif ()

    write_basic_package_version_file(
            ${CMAKE_BINARY_DIR}/${project_name}ConfigVersion.cmake
            VERSION ${major_version}.${minor_version}.${patch_version}
            COMPATIBILITY SameMajorVersion)

    # The cmake module path for ${target_name}.
    set(cmake_modules_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake")

    # Installation path for ${target_name} files.
    set(cmake_project_install_dir "${cmake_modules_install_dir}/${project_name}")

    set(proj_targets_file_name "${project_name}Targets")

    # Installation path and file name of ${target_name}'s targets file.
    set(cmake_proj_targets_file_path "${cmake_project_install_dir}/${proj_targets_file_name}")

    # NO_SET_AND_CHECK_MACRO, NO_CHECK_REQUIRED_COMPONENTS_MACRO
    # https://cmake.org/cmake/help/latest/module/CMakePackageConfigHelpers.html
    # Prevents @PACKAGE_INIT@ from defining helper functions.
    #
    # The helper functions are used to set variables for directories and file
    # locations only if they are not already defined.
    #
    # When a package provides imported targets, no such paths are needed and it
    # is not necessary to generate the helper functions.

    configure_package_config_file(
            ${${target_name}_CONFIG_IN_FILE}
            ${CMAKE_BINARY_DIR}/${project_name}Config.cmake
            INSTALL_DESTINATION ${cmake_project_install_dir}
            PATH_VARS cmake_modules_install_dir cmake_proj_targets_file_path
            NO_SET_AND_CHECK_MACRO
            NO_CHECK_REQUIRED_COMPONENTS_MACRO
    )

    install(EXPORT ${export_set_name}
            NAMESPACE ${project_name}::
            FILE ${proj_targets_file_name}.cmake
            DESTINATION "${cmake_project_install_dir}/"
    )

    # writes an export file directly into the build tree
    export(EXPORT ${export_set_name}
            FILE "${CMAKE_BINARY_DIR}/${project_name}Targets.cmake"
            NAMESPACE ${project_name}::
    )

    install(FILES
            "${CMAKE_BINARY_DIR}/${project_name}Config.cmake"
            "${CMAKE_BINARY_DIR}/${project_name}ConfigVersion.cmake"
            DESTINATION "${cmake_project_install_dir}/"
    )

endfunction()