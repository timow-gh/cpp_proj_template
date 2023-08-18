include_guard()

macro(fix_msvc_ninja_compile_flags)
    if (MSVC)
        if (CMAKE_BUILD_TYPE STREQUAL "Debug")
            string(REPLACE "/Zi" "/Z7" CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}")
            string(REPLACE "/Zi" "/Z7" CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}")
        elseif (CMAKE_BUILD_TYPE STREQUAL "Release")
            string(REPLACE "/Zi" "/Z7" CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}")
            string(REPLACE "/Zi" "/Z7" CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}")
        elseif (CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
            string(REPLACE "/Zi" "/Z7" CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
            string(REPLACE "/Zi" "/Z7" CMAKE_C_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS_RELWITHDEBINFO}")
        endif ()
    endif ()
endmacro()

function(target_fix_msvc_ninja_compile_flags target)
    if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        string(REPLACE "/Zi" "/Z7" target_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}")
        string(REPLACE "/Zi" "/Z7" target_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}")
        set_target_properties(${target}
                PROPERTIES
                CMAKE_CXX_FLAGS "${target_CXX_FLAGS_DEBUG}"
                CMAKE_C_FLAGS "${target_C_FLAGS_DEBUG}"
                )
    elseif (CMAKE_BUILD_TYPE STREQUAL "Release")
        string(REPLACE "/Zi" "/Z7" target_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}")
        string(REPLACE "/Zi" "/Z7" target_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}")
        set_target_properties(${target}
                PROPERTIES
                CMAKE_CXX_FLAGS "${target_CXX_FLAGS_RELEASE}"
                CMAKE_C_FLAGS "${target_C_FLAGS_RELEASE}"
                )
    elseif (CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
        string(REPLACE "/Zi" "/Z7" target_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
        string(REPLACE "/Zi" "/Z7" target_C_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS_RELWITHDEBINFO}")
        set_target_properties(${target}
                PROPERTIES
                CMAKE_CXX_FLAGS "${target_CXX_FLAGS_RELWITHDEBINFO}"
                CMAKE_C_FLAGS "${target_C_FLAGS_RELWITHDEBINFO}"
                )
    endif ()
endfunction()

macro(enable_sccache)
    if (NOT "${CMAKE_GENERATOR}" STREQUAL "Ninja")
        message(AUTHOR_WARNING "sccache is only testet with the generator Ninja. Setting ${PROJECT_NAME}_USE_SCCACHE to OFF.")
        set(${PROJECT_NAME}_USE_SCCACHE OFF CACHE BOOL "" FORCE)
    else ()
        find_program(CCACHE_PROGRAM sccache)
        if (CCACHE_PROGRAM)
            # Makefile Generators and the Ninja generator prefix compiler commands with the given launcher command line.
            # This is intended to allow launchers to intercept build problems with high granularity. Other generators ignore
            # this property because their underlying build systems provide no hook to wrap individual commands with a launcher.
            set(CMAKE_C_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")
            set(CMAKE_CXX_COMPILER_LAUNCHER "${CCACHE_PROGRAM}")

            fix_msvc_ninja_compile_flags()
        else ()
            message(FATAL_ERROR "sccache not found. Please install it or disable USE_SCCACHE")
        endif ()
    endif ()
endmacro()
