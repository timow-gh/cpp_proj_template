set REL_REPOSITORY_PATH=.\
set REPOSITORY_PARENT_PATH=

pushd %REL_REPOSITORY_PATH%
cd ..\
set REPOSITORY_PARENT_PATH=%CD%
popd

echo "REL_REPOSITORY_PATH=%REL_REPOSITORY_PATH%"
echo "REPOSITORY_PARENT_PATH=%REPOSITORY_PARENT_PATH%"

set SOURCE_DIR=%REPOSITORY_PARENT_PATH%\cpp_proj_template
echo "SOURCE_DIR=%SOURCE_DIR%"

set PRESET=windows-msvc-release

set BUILD_DIR=%REPOSITORY_PARENT_PATH%\cpp_proj_template_build\%PRESET%
echo "BUILD_DIR=%BUILD_DIR%"
mkdir %BUILD_DIR%

set INSTALL_DIR=%REPOSITORY_PARENT_PATH%\cpp_proj_template_install\%PRESET%
echo "INSTALL_DIR=%INSTALL_DIR%"

cd %SOURCE_DIR%

cmake   -B %BUILD_DIR% -S %SOURCE_DIR% ^
        --preset %PRESET% ^
        -DBUILD_SHARED_LIBS=ON ^
        -DCMAKE_CXX_STANDARD=20

cmake --build %BUILD_DIR% --parallel 24

pushd %REL_REPOSITORY_PATH%

cd %BUILD_DIR%
ctest -C
cpack -C

popd

mkdir %INSTALL_DIR%
cmake --install %BUILD_DIR% --prefix %INSTALL_DIR%
