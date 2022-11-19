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

## Project usage test

- Make the projedt install test part of the ctest suite
- Test using by add_subdirectory
- Test using by FetchContent

## Warnings

- Add warnings to the project
- Add usage of static analyzers
    - cppcheck
    - clang-tidy

```CMake
  add_cxx_compiler_flag(-Wall)
  add_cxx_compiler_flag(-Wextra)
  add_cxx_compiler_flag(-Wshadow)
  add_cxx_compiler_flag(-Werror RELEASE)
  add_cxx_compiler_flag(-Werror RELWITHDEBINFO)
  add_cxx_compiler_flag(-Werror MINSIZEREL)
  if (NOT BENCHMARK_ENABLE_TESTING)
    # Disable warning when compiling tests as gtest does not use 'override'.
    add_cxx_compiler_flag(-Wsuggest-override)
  endif()
  add_cxx_compiler_flag(-pedantic)
  add_cxx_compiler_flag(-pedantic-errors)
  add_cxx_compiler_flag(-Wshorten-64-to-32)
  add_cxx_compiler_flag(-fstrict-aliasing)
  # Disable warnings regarding deprecated parts of the library while building
  # and testing those parts of the library.
  add_cxx_compiler_flag(-Wno-deprecated-declarations)
  if (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
    # Intel silently ignores '-Wno-deprecated-declarations',
    # warning no. 1786 must be explicitly disabled.
    # See #631 for rationale.
    add_cxx_compiler_flag(-wd1786)
  endif()
  # Disable deprecation warnings for release builds (when -Werror is enabled).
  add_cxx_compiler_flag(-Wno-deprecated RELEASE)
  add_cxx_compiler_flag(-Wno-deprecated RELWITHDEBINFO)
  add_cxx_compiler_flag(-Wno-deprecated MINSIZEREL)
  if (NOT BENCHMARK_ENABLE_EXCEPTIONS)
    add_cxx_compiler_flag(-fno-exceptions)
  endif()

  if (HAVE_CXX_FLAG_FSTRICT_ALIASING)
    if (NOT CMAKE_CXX_COMPILER_ID STREQUAL "Intel") #ICC17u2: Many false positives for Wstrict-aliasing
      add_cxx_compiler_flag(-Wstrict-aliasing)
    endif()
  endif()
  # ICC17u2: overloaded virtual function "benchmark::Fixture::SetUp" is only partially overridden
  # (because of deprecated overload)
  add_cxx_compiler_flag(-wd654)
  add_cxx_compiler_flag(-Wthread-safety)
  if (HAVE_CXX_FLAG_WTHREAD_SAFETY)
    cxx_feature_check(THREAD_SAFETY_ATTRIBUTES)
  endif()
  ```

## Components

- Add dev and release components to the project
