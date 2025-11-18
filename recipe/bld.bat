cmake -B build -G"Ninja"              ^
  -DCMAKE_BUILD_TYPE=Release          ^
  -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%      ^
  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%   ^
  -DEIGEN_BUILD_PKGCONFIG=ON ^
  -DEIGEN_BUILD_BLAS=OFF ^
  -DEIGEN_BUILD_LAPACK=OFF ^
if errorlevel 1 exit 1

cmake --build build --config Release --target install
if errorlevel 1 exit 1

rem Just make the basic tests as all the tests take too long to run.
FOR /L %%A IN (1,1,8) DO (
  cmake --build build --config Release --target basicstuff_%%A
)
if errorlevel 1 exit 1
ctest --test-dir build -R basicstuff* -V
if errorlevel 1 exit 1