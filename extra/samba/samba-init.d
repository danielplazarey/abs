#!/usr/bin/runscript
# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/files/3.6/samba.initd,v 1.3 2011/09/14 22:52:33 polynomial-c Exp $

extra_started_commands="reload"

depend() {
	after slapd
	need net
	use cupsd
}

DAEMONNAME="${SVCNAME##samba.}"
[ "${DAEMONNAME}" != "samba" ] && daemon_list=${DAEMONNAME}

signal_do() {
	local signal="$1"
	[ -z "${signal}" ] && return 0

	local result=0 last_result=0 daemon= cmd_exec=
	for daemon in ${daemon_list} ; do
		eval cmd_exec=\$${daemon}_${signal}
		if [ -n "${cmd_exec}" ]; then
			ebegin "${my_service_name} -> ${signal}: ${daemon}"
			#echo ${cmd} '->' ${!cmd}
			${cmd_exec} > /dev/null
			last_result=$?
			eend ${last_result}
		fi
		result=$(( ${result} + ${last_result} ))
	done
	return ${result}
}

mkdir_sambadirs() {
	[ -d /var/run/samba ] || mkdir -p /var//run/samba
}

start() {
	${my_service_PRE}
	mkdir_sambadirs
	signal_do start && return 0

	eerror "Error: starting services (see system logs)"
	signal_do stop
	return 1
}
stop() {
	${my_service_PRE}
	if signal_do stop ; then
	    ${my_service_POST}
	    return 0
	fi
}
reload() {
	${my_service_PRE}
	signal_do reload
}
