function(setup_export_set_installation project_name export_set_name config_cmake_in_file_name major_version minor_version patch_version)
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

    # Name of ${target_name}'s targets file.
    set(projTargetsFileName "${project_name}Targets")

    # The cmake module path for ${target_name}.
    set(cmakeModulesDir "${CMAKE_INSTALL_LIBDIR}/cmake")

    # Installation path for ${target_name} files.
    set(cmakeProjDir "${cmakeModulesDir}/${project_name}")

    # Installation path and file name of ${target_name}'s targets file.
    set(cmakeProjTargetsFilePath "${cmakeProjDir}/${projTargetsFileName}")

    configure_package_config_file(
            ${${target_name}_CONFIG_IN_FILE}
            ${CMAKE_BINARY_DIR}/${project_name}Config.cmake
            INSTALL_DESTINATION ${cmakeProjDir}
            PATH_VARS cmakeModulesDir cmakeProjTargetsFilePath
            NO_SET_AND_CHECK_MACRO
            NO_CHECK_REQUIRED_COMPONENTS_MACRO)

    install(EXPORT ${export_set_name}
            NAMESPACE ${project_name}::
            FILE ${projTargetsFileName}.cmake
            DESTINATION "${cmakeProjDir}/")

    export(EXPORT ${export_set_name}
            FILE "${CMAKE_BINARY_DIR}/${project_name}Targets.cmake"
            NAMESPACE ${project_name}::
            )

    install(FILES
            "${CMAKE_BINARY_DIR}/${project_name}Config.cmake"
            "${CMAKE_BINARY_DIR}/${project_name}ConfigVersion.cmake"
            DESTINATION "${cmakeProjDir}/")
endfunction()