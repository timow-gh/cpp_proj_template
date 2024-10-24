#ifndef EXAMPLE_LIBRARY_WARNINGS_HPP
#define EXAMPLE_LIBRARY_WARNINGS_HPP

#define DO_PRAGMA(X) _Pragma(#X)

#if defined(_MSC_VER)
#define DISABLE_ALL_WARNINGS DO_PRAGMA(warning(push, 0))
#elif defined(__clang__)
#define DISABLE_ALL_WARNINGS                                                                                                               \
  DO_PRAGMA(clang diagnostic push)                                                                                                         \
  DO_PRAGMA(clang diagnostic ignored "-Weverything")
#elif defined(__GNUC__)
#define DISABLE_ALL_WARNINGS                                                                                                               \
  DO_PRAGMA(GCC diagnostic push)                                                                                                           \
  DO_PRAGMA(GCC diagnostic ignored "-Wall")                                                                                                \
  DO_PRAGMA(GCC diagnostic ignored "-Wextra")                                                                                              \
  DO_PRAGMA(GCC diagnostic ignored "-Wpedantic")                                                                                           \
  DO_PRAGMA(GCC diagnostic ignored "-Wuseless-cast")                                                                                       \
  DO_PRAGMA(GCC diagnostic ignored "-Wold-style-cast")                                                                                     \
  DO_PRAGMA(GCC diagnostic ignored "-Wsign-conversion")                                                                                    \
  DO_PRAGMA(GCC diagnostic ignored "-Wconversion")                                                                                         \
  DO_PRAGMA(GCC diagnostic ignored "-Wdouble-promotion")                                                                                   \
  DO_PRAGMA(GCC diagnostic ignored "-Wnull-dereference")
#endif

#if defined(_MSC_VER)
#define ENABLE_ALL_WARNINGS DO_PRAGMA(warning(pop))
#elif defined(__clang__)
#define ENABLE_ALL_WARNINGS DO_PRAGMA(clang diagnostic pop)
#elif defined(__GNUC__)
#define ENABLE_ALL_WARNINGS DO_PRAGMA(GCC diagnostic pop)
#endif

#endif // EXAMPLE_LIBRARY_WARNINGS_HPP
