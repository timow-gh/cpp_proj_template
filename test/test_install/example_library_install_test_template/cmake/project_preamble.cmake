# Sets default values that should be used by all projects.
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

    if (NOT CMAKE_GENERATOR STREQUAL "Xcode")
        file(RELATIVE_PATH relDir
                ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_BINDIR}
                ${CMAKE_CURRENT_BINARY_DIR}/${CMAKE_INSTALL_LIBDIR})
        set(CMAKE_INSTALL_RPATH $ORIGIN $ORIGIN/${relDir} PARENT_SCOPE)
    endif ()
endfunction()