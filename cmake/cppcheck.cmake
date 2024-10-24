include_guard()

# Creates a target cppcheck_target.
# Requires the compilation db to be present at ${CMAKE_BINARY_DIR}/compile_commands.json
function(create_cppcheck_target)
    find_program(CPPCHECK_PROGRAM_PATH cppcheck)

    if (NOT CPPCHECK_PROGRAM_PATH)
        message(AUTHOR_WARNING "cppcheck not found!")
        return()
    endif ()

    set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE BOOL "Export compile commands" FORCE)

    # Make cppcheck_target part of ALL. This ensure it is build along all other targets when building the project.
    add_custom_target(cppcheck_target ALL
            COMMAND "${CPPCHECK_PROGRAM_PATH};--project=${CMAKE_BINARY_DIR}/compile_commands.json;--enable=all;--inconclusive;--std=c++${CMAKE_CXX_STANDARD};--inline-suppr;--suppress=*:*/cpp_proj_template/benchmark/benchmark_example_library.cpp;--suppress=*:*/_deps/*;--suppress=*:*/fmt/*;--suppress=*:*/googlemock/*;--suppress=*:*/googletest/*;--suppress=*:*/date-*;--suppress=unmatchedSuppression;--suppress=missingIncludeSystem;--error-exitcode=10"
            COMMAND_EXPAND_LISTS
            COMMENT "Running cppcheck on the project"
    )
endfunction()
