
SRCREV = "342c8259381b63296e96ad29519bd4b9c7afbf97"
SRC_URI = " \
    git://github.com/containers/libpod.git;branch=v4.0;protocol=https \
"

PV = "4.0.2+git${SRCPV}"

do_install() {
	cd ${S}/src/.gopath/src/"${PODMAN_PKG}"

	export GOARCH="${BUILD_GOARCH}"
	export GOPATH="${S}/src/.gopath"
	export GOROOT="${STAGING_DIR_NATIVE}/${nonarch_libdir}/${HOST_SYS}/go"

	oe_runmake install DESTDIR="${D}"
	if ${@bb.utils.contains('PACKAGECONFIG', 'docker', 'true', 'false', d)}; then
		oe_runmake install.docker DESTDIR="${D}"
	fi
	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
		rm -f ${D}/${systemd_unitdir}/system/docker.service.rpm
	fi
}

SYSTEMD_SERVICE:${PN} = ""