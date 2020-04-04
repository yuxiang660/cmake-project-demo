#!/bin/sh

# "set -x" expands variables and prints a little + sign before the line.

SOURCE_DIR=`pwd`
BUILD_DIR=${BUILD_DIR:-./build}
BUILD_TYPE=${BUILD_TYPE:-Debug}
INSTALL_DIR=${INSTALL_DIR:-./export}
CXX=${CXX:-g++}

mkdir -p $BUILD_DIR \
  && cd $BUILD_DIR \
  && cmake \
           -DCMAKE_BUILD_TYPE=$BUILD_TYPE \
           -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR \
           -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
           $SOURCE_DIR \

if [ "$*" = "" ] ; then
    make
elif [ "$*" = "doc" ] ; then
    make doxygen
elif [ "$*" = "install" ] ; then
    cd src && make install
else
    echo "Usage: 1. './build.sh', 2. './build doc', 3. './build.sh install'"
fi
