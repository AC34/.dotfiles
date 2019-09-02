#!/usr/bin/env bash











#functions
#is_debian

#is_net_alive

#is_root_user
if [ ${EUID:-${UID} = 0 ]; then
		return 1
else
		return 0
fi
#is_isntalled

#confirm


