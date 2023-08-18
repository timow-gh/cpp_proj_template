include_guard()

# Sets default values that should be used by the whole project.
# Must be called before the first cmake target is created.
function(project_preamble)
    include(GNUInstallDirs)
    if (MSVC)
        set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

        # Set default output directories for windows if it is not already set by another project.
        if (NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
            set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR} PARENT_SCOPE)
        endif ()
        if (NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
            #CMAKE_INSTALL_LIBDIR
            set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR} PARENT_SCOPE)
        endif ()
        if (NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
            #CMAKE_INSTALL_LIBDIR
            set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_BINDIR} PARENT_SCOPE)
        endif ()
    endif ()

    set_property(GLOBAL PROPERTY USE_FOLDERS ON)

    # The default visibility is visible, so we need to explicitly hide symbols.
    set(CMAKE_CXX_VISIBILITY_PRESET hidden PARENT_SCOPE)
    set(CMAKE_VISIBILITY_INLINES_HIDDEN 1 PARENT_SCOPE)
    # CMAKE_LINK_LIBRARIES_ONLY_TARGETS: All linked libraries must be cmake targets.
    # Incase a target is linked to a library without using the target alias, a system library may be linked.
    # To prevent this, we only allow linking to cmake targets.
    # Not allowed: target_link_libraries(myTarget PRIVATE m) -> if m is a system library.
    set(CMAKE_LINK_LIBRARIES_ONLY_TARGETS OFF PARENT_SCOPE) # Off due to google benchmark linking to system libraries.

    # Set the rpath for the executable to the libraries.
    # Ignore Xcode because apple has a different layout.
    if (NOT CMAKE_GENERATOR STREQUAL "Xcode")
        # The loader will look for the libraries at the paths specified in the INSTALL_RPATH.
        # Set relative paths from the executable to the libraries for the rpath.
        file(RELATIVE_PATH relDir
                ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}
                ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})

        # Set the install rpath for all targets in the project.
        set(CMAKE_INSTALL_RPATH $ORIGIN $ORIGIN/${relDir} PARENT_SCOPE)
    endif ()
endfunction()