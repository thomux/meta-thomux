SUMMARY = "Thomux core image"

IMAGE_FEATURES:append = " ssh-server-dropbear"

IMAGE_INSTALL:append = "  docker \
                          dropbear vim"

LICENSE = "MIT"

inherit core-image
require recipes-core/images/core-image-minimal.bb

IMAGE_ROOTFS_SIZE ?= "8192"
IMAGE_ROOTFS_EXTRA_SPACE:append = "${@bb.utils.contains("DISTRO_FEATURES", "systemd", " + 4096", "", d)}"
