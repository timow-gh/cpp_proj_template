# CPP project template

This is a template for a C++ project. It borrows heavily from
the [gui_starter_template](https://github.com/cpp-best-practices/gui_starter_template) but avoids using package
managers.

The goal is to support three types of usage:

* Use find_package to find the library if it is installed
* Use add_subdirectory to add the library to your project, if you want to add the source code to your project
* Use FetchContent to download the library and use it in your project

# The Template Project Directory Structure

    cpp_proj_template
    ├── benchmark
    │   ├── ...
    │   └── CMakeLists.txt   
    ├── cmake                               # CMake modules
    │   └── ...                             
    ├── dependencies                        # Downloads and builds 3rd party dependencies using the FetchContent module
    │   ├── ...
    │   └── CMakelists.txt
    │
    ├── src                                 # Source files of this project
    │   │
    │   ├── example_library_src             # cpp_proj_template lib files
    │   │   ├── example_library             
    │   │   │   └── library.h      
    │   │   ├── source                      
    │   │   │   └── library.cpp
    │   │   └── CMakelists.txt
    │   │
    │   │── headeronly_supporting_lib_src   # headeronly_supporting_lib lib files
    │   │   ├── headeronly_supporting_lib   
    │   │   │  └── library.h
    │   │   └── CMakelists.txt  
    │   │
    │   └── CMakelists.txt     
    │
    ├── test                                # Test files
    │   ├── ...
    │   └── CMakelists.txt
    │
    ├── .clang-format                       # specifies the formatting style
    ├── .clang-tidy                         # specifies the clang-tidy checks    
    ├── .gitignore                          
    └── CMakelists.txt

# Build instructions

## Configure cmake

### Windows

Requirements

- Visual Studio 16, 64bit or older
- CMake 3.19 or older
- Git

```
cmake -B <path-to-build-dir> -S <path-to-source-dir> -G "Visual Studio 16 2019" -A x64 -DBUILD_SHARED_LIBS=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=20
```

### Ubuntu

Requirements

- Clang
- CMake 3.19 or older
- Git
- Ninja

```
sudo apt install clang cmake git ninja-build
```

```
cmake -B <path-to-build-dir> -S <path-to-source-dir> -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=20
```

### Build a single target

```
cmake --build <path-to-build-dir> --target <target-name> --config Release --parallel
```

### Build all targets

```
cmake --build <path-to-build-dir> --config Release --parallel
```