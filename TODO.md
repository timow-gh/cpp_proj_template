# Creating an installable package using CPack

## Project Tests

- Test using by add_subdirectory
- Test using by FetchContent
- ~~Automate the tests of the installed package for all three usages~~
- ~~Make the project install test part of the ctest suite?~~ - No
- ~~Test packaging with CPack~~

## Warnings and tools

- add stack protection, see sqlitecpp
- ~~add sccache~~
- ~~Add warnings to the project~~
- Add option to use cppcheck
- ~~Add settings for clang-tidy~~
- ~~Add documentation generation~~
- Add code coverage
- Add sanitizers

## CMake install improvements

- Add dev and release components to the project
- Remove the need for Config.cmake.in files when installing targets
    - A custom function is needed that wraps target_link_libraries. This function must collect the dependencies of the
      target and use them to generate the Config.cmake file.
