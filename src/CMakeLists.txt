set(project_export_set_name "${PROJECT_NAME}TargetsExportSet")

add_subdirectory(example_executable_src)
add_subdirectory(example_library_src)

if (${PROJECT_NAME}_INSTALL)
    include(setup_export_set_installation)
    # Install the export set, using the helper function from cmake/setupExportSetInstall.cmake and the file Config.cmake.in
    # In the Config.cmake.in all dependencies of the project must be listed.
    setup_export_set_installation(
            ${PROJECT_NAME}
            ${project_export_set_name}
            Config.cmake.in
            ${PROJECT_VERSION_MAJOR} ${PROJECT_VERSION_MINOR} ${PROJECT_VERSION_PATCH}
    )
endif ()