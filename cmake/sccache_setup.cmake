include_guard()

macro(fix_msvc_ninja_compile_flags)
    if (MSVC)
        if (CMAKE_BUILD_TYPE STREQUAL "Debug")
            string(REPLACE "/Zi" "/Z7" CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}")
            string(REPLACE "/Zi" "/Z7" CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}")
            message(STATUS "CMAKE_CXX_FLAGS_DEBUG=${CMAKE_CXX_FLAGS_DEBUG}")
            message(STATUS "CMAKE_C_FLAGS_DEBUG=${CMAKE_C_FLAGS_DEBUG}")
        elseif (CMAKE_BUILD_TYPE STREQUAL "Release")
            string(REPLACE "/Zi" "/Z7" CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}")
            string(REPLACE "/Zi" "/Z7" CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}")
            message(STATUS "CMAKE_CXX_FLAGS_RELEASE=${CMAKE_CXX_FLAGS_RELEASE}")
            message(STATUS "CMAKE_C_FLAGS_RELEASE=${CMAKE_C_FLAGS_RELEASE}")
        elseif (CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
            string(REPLACE "/Zi" "/Z7" CMAKE_CXX_FLAGS_RELWITHDEBINFO "${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
            string(REPLACE "/Zi" "/Z7" CMAKE_C_FLAGS_RELWITHDEBINFO "${CMAKE_C_FLAGS_RELWITHDEBINFO}")
            message(STATUS "CMAKE_CXX_FLAGS_RELWITHDEBINFO=${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
            message(STATUS "CMAKE_C_FLAGS_RELWITHDEBINFO=${CMAKE_C_FLAGS_RELWITHDEBINFO}")
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
