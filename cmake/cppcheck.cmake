include_guard()

function(enable_cppcheck targetName)
    find_program(CPPCHECK_PROGRAM_PATH cppcheck)

    if (NOT CPPCHECK_PROGRAM_PATH)
        message(AUTHOR_WARNING "cppcheck not found!")
        return()
    endif ()

    set_target_properties(${targetName}
            PROPERTIES CXX_CPPCHECK
            "${CPPCHECK_PROGRAM_PATH};--enable=warning;--suppress=*:*/fmt/*;--error-exitcode=10"
    )
endfunction()