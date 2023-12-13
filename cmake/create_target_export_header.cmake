include_guard()

# Creates the name of the export header file given by the call to the cmake function: generate_export_header()
function(create_target_export_file_name target_export_name output_var_name)
    set(GENERATED_TARGET_EXPORTS_FILE_NAME "")
    string(TOLOWER "${target_export_name}_export.h" GENERATED_TARGET_EXPORTS_FILE_NAME)
    set(${output_var_name} "${GENERATED_TARGET_EXPORTS_FILE_NAME}" PARENT_SCOPE)
endfunction()

# Creates the export header file for the given target
#
# target_name: The name of the target to generate the export header file for
# target_export_name: The name of the export header file to be generated
#
# Will create the export header file in the current binary directory.
# The path to the export header file will be: ${CMAKE_CURRENT_BINARY_DIR}/${target_export_name}/${target_export_name}_export.h
# The output variables hold the name of the export header file and the directory where it is located. This is useful
# for calls to target_include_directories() to include the export header file and install the export header file.
#
# output_header_file_name: The name of the export header file to be generated.
# output_export_header_dir: The directory where the relative project path to the export header file is located.
function(create_target_export_header target_name target_export_name output_header_file_name output_export_header_dir)
include(GenerateExportHeader)

generate_export_header(${target_name}
        BASE_NAME ${target_export_name}
)

set(TARGET_EXPORT_HEADER_NAME "")
create_target_export_file_name(${target_export_name} TARGET_EXPORT_HEADER_NAME)

set(TARGET_EXPORT_HEADER_DIR "${CMAKE_CURRENT_BINARY_DIR}/export_header_includes/")

file(COPY
        ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_EXPORT_HEADER_NAME}
        DESTINATION
        ${TARGET_EXPORT_HEADER_DIR}/${target_export_name}
)
file(REMOVE
        ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_EXPORT_HEADER_NAME}
)

set(${output_header_file_name} "${TARGET_EXPORT_HEADER_NAME}" PARENT_SCOPE)
set(${output_export_header_dir} "${TARGET_EXPORT_HEADER_DIR}" PARENT_SCOPE)
endfunction()