[![linux](https://github.com/timow-gh/cpp_proj_template/actions/workflows/linux.yml/badge.svg?branch=main)](https://github.com/timow-gh/cpp_proj_template/actions/workflows/linux.yml)
[![macos](https://github.com/timow-gh/cpp_proj_template/actions/workflows/macos.yml/badge.svg?branch=main)](https://github.com/timow-gh/cpp_proj_template/actions/workflows/macos.yml)
[![windows](https://github.com/timow-gh/cpp_proj_template/actions/workflows/windows.yml/badge.svg?branch=main)](https://github.com/timow-gh/cpp_proj_template/actions/workflows/windows.yml)

# CPP project template

This is a template for a C++ project. It is based on the project
[gui_starter_template](https://github.com/cpp-best-practices/gui_starter_template) but avoids using package
managers.

The goal is to support three types of usage:

* Use find_package to find the library if it is installed
* Use add_subdirectory to add the library to your project, if you want to add the source code to your project
* Use FetchContent to download the library and use it in your project

# The Template Project Directory Structure

    cpp_proj_template
    │   
    ├── benchmark                                   # Downloads and builds the benchmark library
    │   ├── ...                                     # Benchmark cpp files
    │   └── CMakeLists.txt
    │      
    ├── cmake                                       # CMake modules
    │   ├── Config.cmake.in                         # Config file for find_package. When installing the project, this file is modified and copied to the install directory.
    │   ├── CPM.cmake                               # OPTIONAL Use CPM to download and build dependencies in a shared directory across different projects.
    │   ├── cppcheck.cmake                          # OPTIONAL Use cppcheck per target to check the code for errors
    │   ├── setup_doxygen.cmake                     # OPTIONAL Find the doxygen executable and configure the doxygen documentation
    │   ├── project_preamble.cmake                  # Generic options to be used in all projects                
    │   ├── setup_sccache.cmake                     # OPTIONAL Looks for sccache to speed up the compilation
    │   ├── setup_exeport_set_installation.cmake    # Function that configures the installation of the project targets
    │   ├── static_analysis.cmake                   # OPTIONAL Configures clang-tidy project wide
    │   └── warnings.cmake                          # OPTIONAL Configures warnings per target
    │                                
    ├── dependencies                                # Dependency sources are downloaded using FetchContent if not found in the CPM cache directory 
    │   ├── fmt                                     
    │   │   └── CMakelists.txt
    │   ├── googletest                              
    │   │   └── CMakelists.txt
    │   └── CMakelists.txt
    │
    ├── src                                         # Source files of this project
    │   ├── example_executable                      # example executable that uses example_library
    │   │   ├── main.cpp
    │   │   └── CMakelists.txt
    │   │
    │   ├── example_library_src                     # example_library files. Library may be build as static or shared library.
    │   │   │                                       #
    │   │   │                                       # The idea of this example lib is to print a message to the console 
    │   │   │                                       # using the header-only supporting lib, while not exposing the header-only lib to the user.
    │   │   ├── example_library             
    │   │   │   └── library.h      
    │   │   ├── source                      
    │   │   │   └── library.cpp
    │   │   └── CMakelists.txt
    │   │
    │   └── CMakelists.txt     
    │
    ├── test                                        # Test files
    │   ├── test_install                            # Tests the installed library targets using find_package()
    │   │   ├── template_find_package_install_test  
    │   │   └── CMakeLists.txt
    │   ├── using_google_test                       # Tests the library by using the targets of the build directory
    │   └── CMakelists.txt
    │
    ├── .clang-format                               # specifies the formatting style
    ├── .clang-tidy                                 # specifies the clang-tidy checks    
    ├── .gitignore                          
    └── CMakelists.txt

# Build instructions

## Setup

### Platform: Windows

Requirements

- Visual Studio 16, 64bit or older
- CMake 3.21 or older
- Git

### Platform: Ubuntu

Requirements

- Clang or GCC
- CMake 3.21 or older
- Git
- Ninja

## Example build scripts

Take a look at the example build scripts for windows (*.bat) and ubuntu (*.sh) in the main directory or use the
commands below.

## Configure cmake

### Platform: Windows

```
cmake -B <path-to-build-dir> -S <path-to-source-dir> -G "Visual Studio 16 2019" -A x64 -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=20
```

### Platform: Ubuntu

```
cmake -B <path-to-build-dir> -S <path-to-source-dir> -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=20
```

## Build a single target, all platforms

```
cmake --build <path-to-build-dir> --target <target-name> --config Release --parallel
```

## Build all targets, all platforms

```
cmake --build <path-to-build-dir> --config Release --parallel
```

## Install the project, all platforms

```
cmake --install <path-to-build-dir> --config Release --prefix <path-to-install-dir>
```

# Resources

Example projects

* [cpp-best-practices/gui_starter_template](https://github.com/cpp-best-practices/gui_starter_template)
* [aminya/project_options](https://github.com/aminya/project_options)
* [gitlab.io/modern-cmake/](https://cliutils.gitlab.io/modern-cmake/)
* [Modern-CMake-for-Cpp](https://github.com/PacktPublishing/Modern-CMake-for-Cpp)

Talks:

* [C++Now 2017: Daniel Pfeifer “Effective CMake"](https://youtu.be/bsXLMQ6WgIk)
* [More Modern CMake - Deniz Bahadir - Meeting C++ 2018](https://youtu.be/y7ndUhdQuU8)
* [Deep CMake for Library Authors - Craig Scott - CppCon 2019](https://youtu.be/m0DwB4OvDXk)

Books:

* [crascit.com/professional-cmake/](https://crascit.com/professional-cmake/)