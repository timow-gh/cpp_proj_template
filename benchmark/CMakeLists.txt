# Boilerplate
# Use the google benchmark lib to perform benchmarks
# Make the lib benchmark available using FetchContent
FetchContent_Declare(
        benchmark
        GIT_REPOSITORY https://github.com/google/benchmark.git
        GIT_TAG v1.6.0)

set(BENCHMARK_DOWNLOAD_DEPENDENCIES OFF CACHE BOOL "" FORCE)
set(BENCHMARK_ENABLE_GTEST_TESTS OFF CACHE BOOL "" FORCE)
set(BENCHMARK_ENABLE_TESTING OFF CACHE BOOL "" FORCE)
set(BENCHMARK_ENABLE_EXCEPTIONS OFF CACHE BOOL "" FORCE)
set(BENCHMARK_ENABLE_INSTALL ON CACHE BOOL "" FORCE)
if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    set(BENCHMARK_USE_LIBCXX ON CACHE BOOL "" FORCE)
else ()
    set(BENCHMARK_USE_LIBCXX OFF CACHE BOOL "" FORCE)
endif ()
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

set(LIBS example_library::example_library benchmark::benchmark_main)

function(create_benchmark benchMarkName)
    add_executable(${benchMarkName} ${benchMarkName}.cpp)
    target_link_libraries(${benchMarkName} PRIVATE "${LIBS}")
endfunction()

create_benchmark(benchmark_example_library)
