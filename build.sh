#!/bin/bash

BUILD_DIR=../cpp_proj_template_build
SOURCE_DIR=./
INSTALL_DIR=../cpp_proj_template_install

mkdir $BUILD_DIR 

cmake -B $BUILD_DIR -S $SOURCE_DIR -G Ninja --preset "unixlike-clang-release" \
-DBUILD_SHARED_LIBS=ON \
-DCMAKE_CXX_STANDARD=20 \
-Dcpp_proj_template_TESTS=ON \
-Dcpp_proj_template_BENCHMARKS=ON \
-Dcpp_proj_template_WARNINGS_AS_ERRORS=ON \
-Dcpp_proj_template_PACKAGE=OFF

threads=`nproc`
cmake --build $BUILD_DIR  --config Release --parallel --parallel $threads

mkdir $INSTALL_DIR
cmake --install ./$BUILD_DIR --config Release --prefix $INSTALL_DIR
