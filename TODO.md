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

The first command sets an absolute path which cannot be used in a relocatable package.

## Project usage test

- Test using by add_subdirectory
- Test using by FetchContent
- Automate the tests of the installed package for all three usages
- Make the project install test part of the ctest suite?

## Warnings and tools

- Add warnings to the project
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

## CMake Components

- Add dev and release components to the project
