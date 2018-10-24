#!/bin/bash

# the first and only argument to the script is the version
JULIAVER=$1
JULIABIN=/test/julia-$JULIAVER/bin/julia
PKGNAME="PipeLayout"

## install the image (when necessary)
/test/install-julia.sh $JULIAVER

cd /mnt && if [[ -a .git/shallow ]]; then git fetch --unshallow; fi

# install SCIP
wget http://scip.zib.de/download/release/SCIPOptSuite-6.0.0-Linux.deb
dpkg -i SCIPOptSuite-6.0.0-Linux.deb
export SCIPOPTDIR="/usr"

# run tests
$JULIABIN -e "using Pkg; Pkg.update(); Pkg.clone(\"/mnt/\", \"$PKGNAME\"); Pkg.build(\"$PKGNAME\"); Pkg.test(\"$PKGNAME\"; coverage=true)"
TEST_EXIT=$?                    # return with this

# save coverage results back to host
PKGDIR=`$JULIABIN -e "print(Pkg.dir(\"$PKGNAME\"))"`
rsync -mav --include="*/" --include="*.cov" --exclude="*" $PKGDIR/ /mnt/
exit $TEST_EXIT
