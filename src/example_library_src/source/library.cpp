#include <example_library/library.hpp>
#include <fmt/format.h>

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

void libraryFunction(int value) {
  fmt::print("Hello from example_library! The answer is {}\n", value);
}

} // namespace example_library
