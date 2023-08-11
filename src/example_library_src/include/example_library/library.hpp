#ifndef CPP_LIB_TEMPLATE_LIBRARY_H
#define CPP_LIB_TEMPLATE_LIBRARY_H

#include <example_library/example_library_export.h>

namespace example_library
{

/**
 * @brief Prints the value to the console
 *
 * This function prints the given value to the console using the
 * headeronly_supporting_lib print function.
 * The headeronly_supporting_lib is not exposed to the user of the library example_library.
 *
 * @param value The value to print
 */
EXAMPLE_LIBRARY_EXPORT void libraryFunction(int value);
}

#endif // CPP_LIB_TEMPLATE_LIBRARY_H
