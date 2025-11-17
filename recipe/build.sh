#!/bin/sh
set -ex

cmake -S . -B build -G Ninja ${CMAKE_ARGS} \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DEIGEN_BUILD_PKGCONFIG=ON \
  -DEIGEN_BUILD_BLAS=OFF \
  -DEIGEN_BUILD_LAPACK=OFF \
  ..

cmake --build build --config Release --target install

# Build and run some basic tests
cmake  --build build  --target basicstuff
ctest --test-dir build -R basicstuff*