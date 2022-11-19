#ifndef CPP_LIB_TEMPLATE_SUPPORTING_LIB_H
#define CPP_LIB_TEMPLATE_SUPPORTING_LIB_H

#include <fmt/format.h>
#include <string>

namespace supporting_lib
{
template <typename T>
std::string supportingLibStringFormat(T value)
{
  return fmt::format("A formatted string from the supporting lib: {}", value);
}
} // namespace supporting_lib

#endif // CPP_LIB_TEMPLATE_SUPPORTING_LIB_H
