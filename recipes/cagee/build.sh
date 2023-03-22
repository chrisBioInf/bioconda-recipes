#!/bin/bash

set -e
set -x

if [ "$(uname)" = "Darwin" ]; then
  # LDFLAGS fix: https://github.com/AnacondaRecipes/intel_repack-feedstock/issues/8
  export LDFLAGS="-Wl,-pie -Wl,-headerpad_max_install_names -Wl,-rpath,$PREFIX/lib -L$PREFIX/lib"
else
  export LDFLAGS="-L$PREFIX/lib"
  export MKL_THREADING_LAYER="GNU"
fi
# https://bioconda.github.io/contributor/troubleshooting.html#zlib-errors
export CFLAGS="-I$PREFIX/include"
export CPATH=${PREFIX}/include


mkdir -p build
cd build

cmake -DCMAKE_PREFIX_PATH:PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX} \
  -DCMAKE_BUILD_TYPE="Release" \
  ..

make 
make install

