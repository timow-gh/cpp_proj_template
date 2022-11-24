# Creating an installable package using CPack

## benchmark

Patch the benchmark install command from

``` CMake
  install(
    DIRECTORY "${PROJECT_SOURCE_DIR}/docs/"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/../share/doc/${PROJECT_NAME}")
```

to

``` CMake
  install(
    DIRECTORY "${PROJECT_SOURCE_DIR}/docs/"
    DESTINATION "${CMAKE_INSTALL_DOCDIR}")
```

The first command sets an absolute path which cannot be used in a relocatable package. When packaging with CPack,
NSIS will complain about the absolute path. This cannot be changed with CPack variables or NSIS options, the CMake
project needs to get this right.

## Project Tests

- Test using by add_subdirectory
- Test using by FetchContent
- ~~Automate the tests of the installed package for all three usages~~
- Make the project install test part of the ctest suite?
- Test packaging with CPack

## Warnings and tools

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
