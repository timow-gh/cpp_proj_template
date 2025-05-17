@echo off

REM Define preset to use
set PRESET=windows-msvc-release
set PACKAGE_PRESET=package-windows-msvc-release

REM Configure the project using the preset
echo Configuring project with preset: %PRESET%
cmake --preset "%PRESET%"

REM Build the project
echo Building project
cmake --build --preset "%PRESET%" --parallel

REM Run tests
echo Running tests
ctest --preset "test-%PRESET%"

REM Install the project (using the install location from CMakePresets.json)
echo Installing project
cmake --install .\out\build\%PRESET%

REM Package the project using the proper package preset command
echo Creating package
pack --preset $PACKAGE_PRESET
