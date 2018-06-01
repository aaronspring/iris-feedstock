#!/bin/bash

# Make sure iris can find the udunits2 library while it's in the temporary
# build environment. This is necessary because the build process also compiles
# the pyke rules, which requires importing iris.

SITECFG=lib/iris/etc/site.cfg
echo "[System]" > $SITECFG
echo "udunits2_path = $PREFIX/lib/libudunits2${SHLIB_EXT}" >> $SITECFG

rm -rf lib/iris/tests/results lib/iris/tests/*.npz

$PYTHON -m pip install --no-deps --ignore-installed .


# Without this line, the OS X build fails reproducibly with
# https://github.com/conda-forge/iris-feedstock/pull/2#issuecomment-217468453.
python -c "import iris.fileformats.netcdf; iris.fileformats.netcdf._pyke_kb_engine()"
