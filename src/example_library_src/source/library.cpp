#include <example_library/library.hpp>
#include <example_library/warnings.hpp>
DISABLE_ALL_WARNINGS
#include <fmt/format.h>
ENABLE_ALL_WARNINGS


namespace example_library
{

// cppcheck should find an error
// static void foo(int x)
//{
//  int buf[10];
//  if (x == 1000)
//  {
//    buf[x] = 0; // <- error
//  }
//}

void libraryFunction(int value)
{
  fmt::print("Hello from example_library! The answer is {}\n", value);
}

} // namespace example_library
