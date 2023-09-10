#!/bin/bash

BUILD_DIR=../cpp_proj_template_build
SOURCE_DIR=./
INSTALL_DIR=../cpp_proj_template_install

mkdir $BUILD_DIR 

cmake -B $BUILD_DIR -S $SOURCE_DIR -G Ninja --preset "unixlike-clang-release" \
-DBUILD_SHARED_LIBS=ON \
-DCMAKE_CXX_STANDARD=20

threads=`nproc`
cmake --build $BUILD_DIR  --config Release --parallel --parallel $threads

mkdir $INSTALL_DIR
cmake --install ./$BUILD_DIR --config Release --prefix $INSTALL_DIR
