#!/bin/sh
export KERNELDIR=`readlink -f .`
CROSS_COMPILE=/Working_Directory/android_prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-

if [ ! -f $KERNELDIR/.config ];
then
   make defconfig psn_n7100_non-oc_new_snappy_voodoo_defconfig
fi

. $KERNELDIR/.config

export ARCH=arm

cd $KERNELDIR/
nice -n 10 make -j4 || exit 1

mkdir -p $KERNELDIR/BUILT_N7100/lib/modules

rm $KERNELDIR/BUILT_N7100/lib/modules/*
rm $KERNELDIR/BUILT_N7100/zImage

find -name '*.ko' -exec cp -av {} $KERNELDIR/BUILT_N7100/lib/modules/ \;
/Working_Directory/android_prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-strip --strip-unneeded $KERNELDIR/BUILT_N7100/lib/modules/*
cp $KERNELDIR/arch/arm/boot/zImage $KERNELDIR/BUILT_N7100/

