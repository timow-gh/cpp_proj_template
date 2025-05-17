#!/bin/bash

# Define preset to use
PRESET="unixlike-clang-release"
PACKAGE_PRESET="package-unixlike-clang-release"

# Configure the project using the preset
echo "Configuring project with preset: $PRESET"
cmake --preset "conf-$PRESET"

# Build the project
echo "Building project"
cmake --build --preset "build-$PRESET" --parallel

# Run tests
echo "Running tests"
ctest --preset "test-$PRESET"

# Install the project (using the install location from CMakePresets.json)
echo "Installing project"
cmake --install ./out/build/$PRESET

# Package the project using the proper package preset command
echo "Creating package"
cpack --preset $PACKAGE_PRESET

exit 0
