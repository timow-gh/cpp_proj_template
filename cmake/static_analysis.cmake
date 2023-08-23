include_guard()

# Enable static analysis for a target
#
# @param targetName Name of the target to enable static analysis for
# @param WARNINGS_AS_ERRORS Set to true, 1 or ON to enable warnings as errors
function(enable_static_analysis targetName WARNINGS_AS_ERRORS)
    if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
        enable_clang_tidy(${targetName})
    elseif (MSVC)
        enable_vs_analysis("" ${targetName})
    else ()
        message(AUTHOR_WARNING "No static analysis enabled for ${CMAKE_CXX_COMPILER_ID}")
    endif ()
endfunction()

# Enable clang-tidy static analysis project wide
function(enable_clang_tidy WARNINGS_AS_ERRORS)
    find_program(CLANGTIDY clang-tidy)

    set(CMAKE_CXX_CLANG_TIDY "" PARENT_SCOPE)
    set(CMAKE_C_CLANG_TIDY "" PARENT_SCOPE)

    if (CLANGTIDY)
        # CMAKE_CXX_CLANG_TIDY
        #
        # This variable is used to initialize the property on each target as it is created. For example:
        #
        # set(CMAKE_CXX_CLANG_TIDY clang-tidy -checks=-*,readability-*)
        # add_executable(foo foo.cxx)
        set(CMAKE_CXX_CLANG_TIDY ${CLANGTIDY} -extra-arg=-Wno-unknown-warning-option)

        # set warnings as errors
        if (WARNINGS_AS_ERRORS)
            list(APPEND CMAKE_CXX_CLANG_TIDY -warnings-as-errors=*)
        endif ()

        # C clang-tidy
        set(CMAKE_C_CLANG_TIDY ${CMAKE_CXX_CLANG_TIDY})

        # set C++ standard
        if (NOT "${CMAKE_CXX_STANDARD}" STREQUAL "")
            if ("${CMAKE_CXX_CLANG_TIDY_DRIVER_MODE}" STREQUAL "cl")
                set(CMAKE_CXX_CLANG_TIDY ${CMAKE_CXX_CLANG_TIDY} -extra-arg=/std:c++${CMAKE_CXX_STANDARD})
            else ()
                set(CMAKE_CXX_CLANG_TIDY ${CMAKE_CXX_CLANG_TIDY} -extra-arg=-std=c++${CMAKE_CXX_STANDARD})
            endif ()
        endif ()

        # set C standard
        if (NOT "${CMAKE_C_STANDARD}" STREQUAL "")
            if ("${CMAKE_C_CLANG_TIDY_DRIVER_MODE}" STREQUAL "cl")
                set(CMAKE_C_CLANG_TIDY ${CMAKE_C_CLANG_TIDY} -extra-arg=/std:c${CMAKE_C_STANDARD})
            else ()
                set(CMAKE_C_CLANG_TIDY ${CMAKE_C_CLANG_TIDY} -extra-arg=-std=c${CMAKE_C_STANDARD})
            endif ()
        endif ()

    else ()
        message(FATAL_ERROR "clang-tidy requested but executable not found")
    endif ()

    message(STATUS "CMAKE_CXX_CLANG_TIDY: ${CMAKE_CXX_CLANG_TIDY}")
    message(STATUS "CMAKE_C_CLANG_TIDY: ${CMAKE_C_CLANG_TIDY}")
endfunction()

# Enable static analysis inside Visual Studio IDE
function(enable_vs_analysis VS_ANALYSIS_RULESET target)
    if ("${VS_ANALYSIS_RULESET}" STREQUAL "")
        # See for other rulesets: C:\Program Files (x86)\Microsoft Visual Studio\20xx\xx\Team Tools\Static Analysis Tools\Rule Sets\
        set(VS_ANALYSIS_RULESET "AllRules.ruleset")
    endif ()
    if (NOT "${CMAKE_CXX_CLANG_TIDY}" STREQUAL "")
        set(_VS_CLANG_TIDY "true")
    else ()
        set(_VS_CLANG_TIDY "false")
    endif ()
    if (CMAKE_GENERATOR MATCHES "Visual Studio")
        set_target_properties(
                ${target}
                PROPERTIES
                VS_GLOBAL_EnableMicrosoftCodeAnalysis true
                VS_GLOBAL_CodeAnalysisRuleSet "${VS_ANALYSIS_RULESET}"
                VS_GLOBAL_EnableClangTidyCodeAnalysis "${_VS_CLANG_TIDY}"
                VS_GLOBAL_RunCodeAnalysis false
        )
    endif ()
endfunction()
