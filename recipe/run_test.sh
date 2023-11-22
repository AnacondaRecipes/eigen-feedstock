#!/bin/sh

test -d ${PREFIX}/include/eigen3

${CXX} -I${PREFIX}/include -o test test.cc

./test
