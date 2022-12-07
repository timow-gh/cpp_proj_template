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
    │   ├── ...
    │   └── CMakeLists.txt
    │      
    ├── cmake                                       # CMake modules
    │   └── ...
    │                                
    ├── dependencies
    │   │                                
    │   ├── fmt                                     # Downloads and builds fmt using the FetchContent module
    │   │   └── CMakelists.txt
    │   ├── googletest                              # Downloads and builds googletest using the FetchContent module
    │   │   └── CMakelists.txt
    │   ├── ...
    │   └── CMakelists.txt
    │
    ├── src                                         # Source files of this project
    │   │
    │   ├── example_executable                      # example executable that uses example_library
    │   │   ├── ...
    │   │   └── CMakelists.txt
    │   │
    │   ├── example_library_src                     # example_library files
    │   │   ├── example_library             
    │   │   │   └── library.h      
    │   │   ├── source                      
    │   │   │   └── library.cpp
    │   │   └── CMakelists.txt
    │   │
    │   │── headeronly_supporting_lib_src           # headeronly_supporting_lib files
    │   │   ├── headeronly_supporting_lib   
    │   │   │  └── library.h
    │   │   └── CMakelists.txt  
    │   │
    │   └── CMakelists.txt     
    │
    ├── test                                        # Test files
    │   ├── test_install                            # Tests the installed library using find_package()
    │   │   ├── template_find_package_install_test  
    │   │   └── CMakeLists.txt
    │   │
    │   ├── ...
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

- Clang
- CMake 3.21 or older
- Git
- Ninja

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

Talks:

* [C++Now 2017: Daniel Pfeifer “Effective CMake"](https://youtu.be/bsXLMQ6WgIk)
* [More Modern CMake - Deniz Bahadir - Meeting C++ 2018](https://youtu.be/y7ndUhdQuU8)
* [Deep CMake for Library Authors - Craig Scott - CppCon 2019](https://youtu.be/m0DwB4OvDXk)

Books:

* [crascit.com/professional-cmake/](https://crascit.com/professional-cmake/)