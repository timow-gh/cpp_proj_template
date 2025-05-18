@echo off

REM Define preset to use
set PRESET=windows-msvc-release
set PACKAGE_PRESET=package-windows-msvc-release

REM Configure the project using the preset
echo Configuring project with preset: %PRESET%
cmake --preset "conf-%PRESET%"

echo Building project
cmake --build --preset "build-%PRESET%" --parallel --config Release

echo Running tests
ctest --preset "test-%PRESET%" -C Release

echo Installing project
cmake --install .\out\build\conf-%PRESET% --config Release

echo Creating package
cpack --preset "%PACKAGE_PRESET%" -C Release
