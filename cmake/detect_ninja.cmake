# This module automatically detects and uses Ninja if available
# To use it, include this file near the start of your top-level CMakeLists.txt

# Only run detection if no generator was explicitly specified
if(NOT CMAKE_GENERATOR)
  find_program(NINJA_EXECUTABLE ninja)
  if(NINJA_EXECUTABLE)
    set(CMAKE_GENERATOR "Ninja" CACHE INTERNAL "Generator used by this build" FORCE)
    message(STATUS "Ninja found at ${NINJA_EXECUTABLE} - using Ninja generator")
  else()
    message(STATUS "Ninja not found - using default generator")
  endif()
endif()