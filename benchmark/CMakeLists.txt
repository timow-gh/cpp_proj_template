# Boilerplate
# Use the google benchmark lib to perform benchmarks
# Make the lib benchmark available using FetchContent
FetchContent_Declare(
        benchmark
        GIT_REPOSITORY https://github.com/google/benchmark.git
        GIT_TAG v1.7.1
        GIT_SHALLOW TRUE)

set(BENCHMARK_ENABLE_TESTING OFF CACHE BOOL "Enable testing of the benchmark library." FORCE)
set(BENCHMARK_ENABLE_EXCEPTIONS ON CACHE BOOL "Enable the use of exceptions in the benchmark library." FORCE)
set(BENCHMARK_ENABLE_LTO OFF CACHE BOOL "Enable link time optimisation of the benchmark library." FORCE)
if (MSVC)
    #OFF, because of a bug in msvc 2017, see https://developercommunity.visualstudio.com/t/incompatible-release-settings-ltcg-and-incremental/422384
    set(BENCHMARK_ENABLE_LTO OFF CACHE BOOL "Enable link time optimisation of the benchmark library." FORCE)
endif ()
set(BENCHMARK_USE_LIBCXX OFF CACHE BOOL "Build and test using libc++ as the standard library." FORCE)
set(BENCHMARK_ENABLE_WERROR OFF CACHE BOOL "Build Release candidates with -Werror." FORCE)
set(BENCHMARK_FORCE_WERROR OFF CACHE BOOL "Build Release candidates with -Werror regardless of compiler issues." FORCE)
set(BENCHMARK_ENABLE_INSTALL OFF CACHE BOOL "Enable installation of benchmark. (Projects embedding benchmark may want to turn this OFF.)" FORCE)
set(BENCHMARK_ENABLE_DOXYGEN OFF CACHE BOOL "Build documentation with Doxygen." FORCE)
set(BENCHMARK_INSTALL_DOCS OFF CACHE BOOL "Enable installation of documentation." FORCE)
set(BENCHMARK_DOWNLOAD_DEPENDENCIES OFF CACHE BOOL "Allow the downloading and in-tree building of unmet dependencies" FORCE)
set(BENCHMARK_ENABLE_GTEST_TESTS OFF CACHE BOOL "Enable building the unit tests which depend on gtest" FORCE)
set(BENCHMARK_USE_BUNDLED_GTEST OFF CACHE BOOL "Use bundled GoogleTest. If disabled, the find_package(GTest) will be used." FORCE)
set(BENCHMARK_ENABLE_LIBPFM OFF CACHE BOOL "Enable performance counters provided by libpfm" FORCE)

mark_as_advanced(BENCHMARK_ENABLE_TESTING)
mark_as_advanced(BENCHMARK_ENABLE_EXCEPTIONS)
mark_as_advanced(BENCHMARK_ENABLE_DOXYGEN)
mark_as_advanced(BENCHMARK_INSTALL_DOCS)
mark_as_advanced(BENCHMARK_DOWNLOAD_DEPENDENCIES)
mark_as_advanced(BENCHMARK_ENABLE_GTEST_TESTS)
mark_as_advanced(BENCHMARK_USE_BUNDLED_GTEST)
mark_as_advanced(BENCHMARK_ENABLE_LIBPFM)

FetchContent_MakeAvailable(benchmark)

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    target_compile_options(benchmark INTERFACE
            "-Wno-weak-vtables"
    )
endif ()

set_target_properties(benchmark
        PROPERTIES
        DEBUG_POSTFIX d)

set_target_properties(benchmark_main
        PROPERTIES
        DEBUG_POSTFIX d)

set(LIBS cpp_proj_template::example_library benchmark::benchmark_main)

function(create_benchmark benchMarkName)
    add_executable(${benchMarkName} ${benchMarkName}.cpp)
    target_link_libraries(${benchMarkName} PRIVATE "${LIBS}")
endfunction()

create_benchmark(benchmark_example_library)
