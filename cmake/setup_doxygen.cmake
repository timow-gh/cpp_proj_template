macro(enable_doxygen)
    find_program(DOXYGEN_EXECUTABLE doxygen)

    if (NOT DOXYGEN_EXECUTABLE)
        message(FATAL_ERROR "Doxygen not found. Documentation will not be generated.")
    endif ()

    # if doxygen is found, generate the documentation
    if (DOXYGEN_EXECUTABLE)
        # configure doxygen file
        # @ONLY means only replace variables of the form @VAR@ (and not ${VAR})
        configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/Doxyfile.in ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Doxyfile @ONLY)

        # Define the custom target for building the documentation
        add_custom_target(
                docs ALL
                COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Doxyfile
                WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                COMMENT "Generating API documentation with Doxygen"
                VERBATIM
        )
    endif ()
endmacro()