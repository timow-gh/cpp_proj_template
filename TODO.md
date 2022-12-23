# Creating an installable package using CPack

## Project Tests

- Test using by add_subdirectory
- Test using by FetchContent
- ~~Automate the tests of the installed package for all three usages~~
- ~~Make the project install test part of the ctest suite?~~ - No
- ~~Test packaging with CPack~~

## Warnings and tools

- add stack protection, see sqlitecpp
- add sccache
- ~~Add warnings to the project~~
- Add usage of static analyzers
    - cppcheck
    - clang-tidy
- Add include-what-you-use
- Add documentation generation
    - Doxygen or Sphinx
- Add code coverage
- Add sanitizers
    - AddressSanitizer
    - ThreadSanitizer
    - UndefinedBehaviorSanitizer
    - MemorySanitizer
- Add fuzzing

## CMake improvements

- Add dev and release components to the project
- Remove the need for Config.cmake.in files when installing targets
