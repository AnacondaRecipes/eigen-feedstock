md build
cd build

set CMAKE_CONFIG="Release"

cmake -LAH -G"Ninja"              ^
  -DCMAKE_BUILD_TYPE=%CMAKE_CONFIG%         ^
  -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX%      ^
  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%   ^
  -DEIGEN_BUILD_PKGCONFIG=ON ^
  ..
if errorlevel 1 exit 1

cmake --build . --config %CMAKE_CONFIG%
if errorlevel 1 exit 1
cmake --install .
if errorlevel 1 exit 1

rem Just make the basic tests as all the tests take too long to run.
FOR /L %%A IN (1,1,8) DO (
  cmake --build . --config %CMAKE_CONFIG% --target basicstuff_%%A
)
if errorlevel 1 exit 1
ctest -R basicstuff*
if errorlevel 1 exit 1
goto :eof

:TRIM
  SetLocal EnableDelayedExpansion
  Call :TRIMSUB %%%1%%
  EndLocal & set %1=%tempvar%
  GOTO :eof

  :TRIMSUB
  set tempvar=%*
  GOTO :eof
