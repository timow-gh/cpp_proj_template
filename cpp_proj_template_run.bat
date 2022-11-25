set BUILD_DIR=..\cpp_proj_template_build
set SOURCE_DIR=.\
set INSTALL_DIR=..\cpp_proj_template_install

mkdir %BUILD_DIR%

set CMAKE_GENERATOR="Visual Studio 16 2019"
set PRESET="windows-msvc-debug-developer-mode"

cmake   -B %BUILD_DIR% -S %SOURCE_DIR% -G %CMAKE_GENERATOR% -A x64 ^
        --preset %PRESET% ^
        -DBUILD_SHARED_LIBS=ON ^
        -DCMAKE_CXX_STANDARD=20 ^
        -Dcpp_proj_template_BUILD_TESTS=ON ^
        -Dcpp_proj_template_BUILD_BENCMARKS=ON ^
        -Dcpp_proj_template_WARNINGS_AS_ERRORS=ON ^
        -Dcpp_proj_template_BUILD_PACKAGE=OFF

cmake --build %BUILD_DIR% --config Debug --parallel 24

mkdir %INSTALL_DIR%

cmake --install %BUILD_DIR% --config Debug --prefix %INSTALL_DIR%

set FIND_PACKAGE_TEST_DIR=..\cpp_proj_template_find_package_test
set FIND_PACKAGE_TEST_BUILD_DIR="%FIND_PACKAGE_TEST_DIR%\cpp_proj_template_build"
set FIND_PACKAGE_TEST_SOURCE_DIR=.\test\test_example_library_install\template_find_package_install_test
set FIND_PACKAGE_TEST_INSTALL_DIR="%FIND_PACKAGE_TEST_DIR%\cpp_proj_template_install"

rmdir /S /Q %FIND_PACKAGE_TEST_DIR%
mkdir %FIND_PACKAGE_TEST_DIR%

cmake   -B %FIND_PACKAGE_TEST_BUILD_DIR% ^
        -S %FIND_PACKAGE_TEST_SOURCE_DIR% ^
        -G %CMAKE_GENERATOR% -A x64 ^
        --preset %PRESET% ^
        -DBUILD_SHARED_LIBS=ON ^
        -DCMAKE_CXX_STANDARD=20 ^
        -DCMAKE_PREFIX_PATH=%INSTALL_DIR%

cmake --build %FIND_PACKAGE_TEST_BUILD_DIR% --config Debug --parallel 24

cmake --install %FIND_PACKAGE_TEST_BUILD_DIR% --config Debug --prefix %FIND_PACKAGE_TEST_INSTALL_DIR%

.\%FIND_PACKAGE_TEST_BUILD_DIR%\bin\Debug\use_installdird.exe
.\%FIND_PACKAGE_TEST_INSTALL_DIR%\bin\use_installdird.exe
