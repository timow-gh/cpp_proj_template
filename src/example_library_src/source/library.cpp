#include <example_library/library.hpp>
#include <headeronly_supporting_lib/supporting_lib.hpp>
#include <iostream>

namespace example_library
{
void libraryFunction(int value )
{
  std::cout << supporting_lib::supportingLibStringFormat(value) << std::endl;
}
} // namespace example_library
