#!/bin/sh
CURDIR=`dirname $0`
TMPDIR=`mktemp -d`
export ARCH=arm
make modules_install INSTALL_MOD_PATH=$TMPDIR

kernel_ver=`ls $TMPDIR/lib/modules`
echo "Kernel Version: $kernel_ver"
archive_path=$CURDIR/t66-${kernel_ver}-kernel-module.tar.gz
find $TMPDIR -name source -exec rm -f {} \;
find $TMPDIR -name build -exec rm -f {} \;

#tree $TMPDIR/
tar -C $TMPDIR -zcf $archive_path lib/modules/${kernel_ver}
du -h $archive_path
rm -rf $TMPDIR
