#include <example_library/library.hpp>
#include <headeronly_supporting_lib/supporting_lib.hpp>
#include <iostream>

namespace example_library
{

// cppcheck should find an error
//static void foo(int x)
//{
//  int buf[10];
//  if (x == 1000)
//  {
//    buf[x] = 0; // <- error
//  }
//}

void libraryFunction(int value)
{
  std::cout << supporting_lib::supportingLibStringFormat(value) << std::endl;
}

} // namespace example_library
