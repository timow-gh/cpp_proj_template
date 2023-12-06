include_guard()

macro(create_target_export_header target_name target_export_name)
include(GenerateExportHeader)
generate_export_header(${target_name}
        BASE_NAME ${target_export_name}
)
string(TOLOWER "${target_export_name}_export.h" GENERATED_TARGET_EXPORTS_FILE_NAME)
file(COPY
        ${CMAKE_CURRENT_BINARY_DIR}/${GENERATED_TARGET_EXPORTS_FILE_NAME}
        DESTINATION
        ${CMAKE_CURRENT_BINARY_DIR}/export_header_includes/${target_export_name}
)
file(REMOVE
        ${CMAKE_CURRENT_BINARY_DIR}/${GENERATED_TARGET_EXPORTS_FILE_NAME}
)
endmacro()