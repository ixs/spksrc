TC_ARCH = armada38x
TC_VERS = 6.2.4
TC_KERNEL = 3.10.105
TC_GCC = 4.9.3
TC_GLIBC = 2.20

TC_DIST = armada38x-gcc493_glibc220_hard-GPL
TC_DIST_SITE_PATH = Marvell%20Armada%2038x%20Linux%203.10.105

TC_TARGET = arm-unknown-linux-gnueabi
TC_SYSROOT = $(TC_TARGET)/sysroot

# ensure gnu/hard-float.h is used
TC_EXTRA_CFLAGS = -D__ARM_PCS_VFP=1

include ../../mk/spksrc.tc.mk
