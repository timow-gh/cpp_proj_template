set(CPACK_PACKAGE_NAME cpp_proj_example)
#set(CPACK_PACKAGE_VENDOR MyCompany)
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "CPP template project")
set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CPACK_PACKAGE_NAME})
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
set(CPACK_VERBATIM_VARIABLES YES)

#set(parent_dir ${CMAKE_CURRENT_LIST_DIR})
#cmake_path(GET parent_dir PARENT_PATH parent_dir)
#
#set(CPACK_RESOURCE_FILE_LICENSE ${parent_dir}/License)
#set(CPACK_RESOURCE_FILE_README ${parent_dir}/Readme.md)
#set(CPACK_PACKAGE_DESCRIPTION_FILE ${parent_dir}/Description.txt)
#set(CPACK_RESOURCE_FILE_WELCOME ${parent_dir}/Welcome.txt)

include(CPack)

if (WIN32)
    set(CPACK_GENERATOR ZIP WIX)
elseif (APPLE)
    set(CPACK_GENERATOR TGZ productbuild)
elseif (CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(CPACK_GENERATOR TGZ RPM)
else ()
    set(CPACK_GENERATOR TGZ)
endif ()

set(CPACK_VERBATIM_VARIABLES YES)
set(CPACK_SOURCE_IGNORE_FILES
        /\\.git/
        /\\.idea/
        \\.swp
        \\.orig
        /CMakeLists\\.txt\\.user
        /out/
        )