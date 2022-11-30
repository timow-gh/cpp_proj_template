include_guard()

# Sets the variable ${target}_INHERITANCE_PROPERTY to either INTERFACE or PRIVATE
macro(private_or_interface_inheritance_property target)
    set(${target}_INHERITANCE_PROPERTY "")
    get_target_property(target_type ${target} TYPE)
    if (${target_type} STREQUAL "INTERFACE_LIBRARY")
        set(${target}_INHERITANCE_PROPERTY "INTERFACE")
    else ()
        set(${target}_INHERITANCE_PROPERTY "PRIVATE")
    endif ()
endmacro()