#include <benchmark/benchmark.h>
#include <example_library/library.hpp>

static void BM_example_library(benchmark::State& state)
{
  for (auto _: state)
  {
    example_library::libraryFunction(42);
  }
}
BENCHMARK(BM_example_library);

BENCHMARK_MAIN();