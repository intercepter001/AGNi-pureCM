#!/bin/sh
export KERNELDIR=`readlink -f .`

if [ ! -f $KERNELDIR/.config ];
then
  make defconfig psn_i9305_oc_v2.3.3_defconfig
fi

. $KERNELDIR/.config

export ARCH=arm

cd $KERNELDIR/
nice -n 10 make -j4 || exit 1

mkdir -p $KERNELDIR/BUILT_I9305/lib/modules

rm $KERNELDIR/BUILT_I9305/lib/modules/*
rm $KERNELDIR/BUILT_I9305/zImage

find -name '*.ko' -exec cp -av {} $KERNELDIR/BUILT_I9305/lib/modules/ \;
${CROSS_COMPILE}strip --strip-unneeded $KERNELDIR/BUILT_I9305/lib/modules/*
cp $KERNELDIR/arch/arm/boot/zImage $KERNELDIR/BUILT_I9305/

