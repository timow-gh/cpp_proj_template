cmake_minimum_required(VERSION 3.28) # CMakePresets are supported since version 3.21

# Make all modules available to this project and other projects that consume this project by
# adding the cmake directory to the CMAKE_MODULE_PATH
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake)

# Auto-detect and use Ninja if available (must be before project() call)
include(detect_ninja)

project(cpp_proj_template
        VERSION 0.1.0
        LANGUAGES CXX)


include(warnings)
include(static_analysis)

include(cmake/CPM.cmake)
if (NOT CPM_SOURCE_CACHE AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/CPMSourceVariable.cmake")
    include(CPMSourceVariable.cmake)
endif ()

if (NOT CPM_SOURCE_CACHE)
    message(AUTHOR_WARNING "CPM_SOURCE_CACHE not set. The source files are downloaded for every build. This is not recommended.
        Set the CPM_SOURCE_CACHE variable to a directory of your choice to cache the cloned git repositories.
        Set the CPM_SOURCE_CACHE variable in CPMSourceVariable.cmake to keep your paths private.")
endif ()

# Set common properties for cross platform builds
include(project_preamble)
project_preamble()

# Use IS_TOP_LEVEL_PROJECT to detect if this project is the top level project.
# If this project is not the top level project, use the IS_TOP_LEVEL_PROJECT variable
# to remove project specific settings like WarningsAsErrors or StaticAnalysis.
# The use of settings of this project should not affect the settings of the parent project.
if ((CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR))
    set(IS_TOP_LEVEL_PROJECT TRUE)
else ()
    set(IS_TOP_LEVEL_PROJECT FALSE)
endif ()

if (IS_TOP_LEVEL_PROJECT)
    option(${PROJECT_NAME}_USE_SCCACHE "Use sccache" ON)
    option(${PROJECT_NAME}_USE_WARNINGS "Compile using warnings." ON)
    option(${PROJECT_NAME}_WARNINGS_AS_ERRORS "Treat compiler warnings as errors " ON)
    option(${PROJECT_NAME}_STATIC_ANALYSIS "" ON)
    option(${PROJECT_NAME}_USE_CPPCHECK "" OFF)
    option(${PROJECT_NAME}_TESTS "" ON)
    option(${PROJECT_NAME}_BENCHMARKS "" ON)
else ()
    option(${PROJECT_NAME}_USE_SCCACHE "Use sccache" OFF)
    option(${PROJECT_NAME}_USE_WARNINGS "Compile using warnings." OFF)
    option(${PROJECT_NAME}_WARNINGS_AS_ERRORS "Treat compiler warnings as errors" OFF)
    option(${PROJECT_NAME}_STATIC_ANALYSIS "" OFF)
    option(${PROJECT_NAME}_USE_CPPCHECK "" OFF)
    option(${PROJECT_NAME}_TESTS "" OFF)
    option(${PROJECT_NAME}_BENCHMARKS "" OFF)
endif ()
# It is possible to exclude this project from installation by setting the following option to OFF.
# This is useful if you want to use this project as a subproject in another project.
option(${PROJECT_NAME}_INSTALL "Install project targets" ON)
option(${PROJECT_NAME}_PACK "Create package" ON)
option(${PROJECT_NAME}_BUILD_DOCUMENTATION "Build documentation" OFF)

if (${PROJECT_NAME}_USE_SCCACHE)
    include(setup_sccache)
    enable_sccache()
endif ()

if (${PROJECT_NAME}_USE_CPPCHECK)
    include(cppcheck)
    create_cppcheck_target(${TARGET_NAME})
endif ()

# Use find_package to find dependencies that are installed on the system
# Example:
# find_package(Boost REQUIRED)

# Add dependencies using the FetchContent module. This will download the dependencies and
# build them with this project.
add_subdirectory(dependencies)

if (${PROJECT_NAME}_BUILD_DOCUMENTATION)
    include(setup_doxygen)
    enable_doxygen()
endif ()

# Add the source code of this project
add_subdirectory(src)

if (${PROJECT_NAME}_TESTS)
    include(CTest)
    # "This command should be in the source directory root because ctest expects to find a test
    # file in the build directory root.", CMake docs
    enable_testing()
    add_subdirectory(test)
endif ()

if (${PROJECT_NAME}_BENCHMARKS)
    add_subdirectory(benchmark)
endif ()

if (${PROJECT_NAME}_INSTALL)
    # CPack configuration
    set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
    set(CPACK_PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
    set(CPACK_PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
    set(CPACK_PACKAGE_VERSION_PATCH "${PROJECT_VERSION_PATCH}")
    set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "C++ Project Template providing runtime and development components.")
    set(CPACK_PACKAGE_VENDOR "Project Vendor") # Please update with actual vendor
    set(CPACK_PACKAGE_CONTACT "contact@example.com") # Please update with actual contact
    set(CPACK_PACKAGE_FILENAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH}-${CMAKE_SYSTEM_NAME}")
    # Removed global CPACK_RESOURCE_FILE_LICENSE, will be set per generator if needed or NSIS specific one.

    # Define components
    set(CPACK_COMPONENTS_ALL runtime dev)
    set(CPACK_COMPONENT_RUNTIME_DISPLAY_NAME "Runtime")
    set(CPACK_COMPONENT_RUNTIME_DESCRIPTION "Runtime libraries and executables required to run the application.")
    set(CPACK_COMPONENT_DEV_DISPLAY_NAME "Development")
    set(CPACK_COMPONENT_DEV_DESCRIPTION "Header files and static/import libraries for development.")

    # Create separate archives for each component for archive generators (like ZIP)
    set(CPACK_ARCHIVE_COMPONENT_INSTALL ON)    
    if(MSVC)
        # Always configure the NSIS template on Windows, regardless of whether NSIS is the current generator
        find_program(NSIS_MAKENSIS_EXECUTABLE NAMES makensis.exe
                    PATHS "C:/Program Files (x86)/NSIS"
                        "C:/Program Files/NSIS")
        if(NOT NSIS_MAKENSIS_EXECUTABLE)
            message(WARNING "NSIS (makensis.exe) not found. NSIS installers will not be available. Install NSIS if you want to create installers.")
        else()
            message(STATUS "NSIS (makensis.exe) found at ${NSIS_MAKENSIS_EXECUTABLE}")
            # First create a license file for NSIS in a reliable location
            file(COPY "${CMAKE_CURRENT_SOURCE_DIR}/License" 
                    DESTINATION "${CMAKE_CURRENT_BINARY_DIR}")
            file(TO_NATIVE_PATH "${CMAKE_CURRENT_BINARY_DIR}/License" LICENSE_FILE_NATIVE)
        
            # Set proper license file and other NSIS variables
            set(CPACK_NSIS_PACKAGE_NAME "${CPACK_PACKAGE_NAME} ${CPACK_PACKAGE_VERSION}")
            
            message(STATUS "NSIS: LICENSE_FILE_NATIVE is set to: ${LICENSE_FILE_NATIVE}")         
            # Set the license file directly for CPack
            set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_BINARY_DIR}/License")
            message(STATUS "NSIS: CPACK_RESOURCE_FILE_LICENSE is set to: ${CPACK_RESOURCE_FILE_LICENSE}")

            set(CPACK_NSIS_INSTALLER_ICON_NAME "${CMAKE_CURRENT_SOURCE_DIR}/assets/icon.ico")
            set(CPACK_NSIS_INSTALLER_MUI_ICON_NAME "${CMAKE_CURRENT_SOURCE_DIR}/assets/icon.ico")       
            set(CPACK_NSIS_MUI_FINISHPAGE_RUN "bin\\\\example_executable.exe") 
            set(CPACK_NSIS_CREATE_ICONS_EXTRA "CreateShortCut '$INSTDIR\\\\bin\\\\example_executable.exe' '$SMPROGRAMS\\\\${CPACK_PACKAGE_NAME}.lnk'")
            set(CPACK_NSIS_DISPLAY_NAME "${CPACK_PACKAGE_NAME} version ${CPACK_PACKAGE_VERSION}")
            set(CPACK_NSIS_INSTALL_ROOT "$PROGRAMFILES64") # Or "$PROGRAMFILES" for 32-bit default
            set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL ON)                
            set(CPACK_NSIS_MODIFY_PATH OFF)  # Disable default AddToPath to avoid length check warnings
            set(CPACK_NSIS_EXECUTABLES_DIRECTORY "${CMAKE_INSTALL_BINDIR}")

            install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/add_to_path.ps1"
                  DESTINATION "bin/"
                  COMPONENT runtime)

            install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/remove_from_path.ps1"
                  DESTINATION "bin/"
                  COMPONENT runtime)

            # -- Add <install-dir>\bin to the system PATH -------------------------------
            string(CONCAT _ADD_TO_PATH_CMD
            "DetailPrint \\\"Adding $INSTDIR\\\\bin to the system PATH\\\"\\n"
            # Run the PowerShell script with elevation
            "ExecShell \\\"runas\\\" \\\"powershell.exe\\\" "
            "\\\"-NoLogo -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File $\\\\\\\"$INSTDIR\\\\bin\\\\add_to_path.ps1$\\\\\\\" -InstallPath $\\\\\\\"$INSTDIR$\\\\\\\" "
            # Hide the PowerShell window
            "SW_HIDE \\\" \\n")
            set(CPACK_NSIS_EXTRA_INSTALL_COMMANDS "${_ADD_TO_PATH_CMD}")

            # -- Remove <install-dir>\bin from the system PATH -------------------------------
            string(CONCAT _REMOVE_FROM_PATH_CMD
            "DetailPrint \\\"Removing $INSTDIR\\\\bin from the system PATH\\\"\\n"
            # Run the PowerShell script with elevation
            "ExecShell \\\"runas\\\" \\\"powershell.exe\\\" "
            "\\\"-NoLogo -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File $\\\\\\\"$INSTDIR\\\\bin\\\\remove_from_path.ps1$\\\\\\\" -InstallPath $\\\\\\\"$INSTDIR$\\\\\\\" "
            # Hide the PowerShell window
            "SW_HIDE \\\" \\n")
            set(CPACK_NSIS_EXTRA_UNINSTALL_COMMANDS "${_REMOVE_FROM_PATH_CMD}")

            set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL ON)
            set(CPACK_NSIS_CONTACT "${CPACK_PACKAGE_CONTACT}")
            set(CPACK_NSIS_HELP_LINK "https://example.com")
            set(CPACK_NSIS_URL_INFO_ABOUT "https://example.com")
        endif()
    endif()

    include(CPack)
endif()
