#if test -z "${XDG_RUNTIME_DIR}"; then
	export XDG_RUNTIME_DIR=/run/user/1000
	#if ! test -d "${XDG_RUNTIME_DIR}"; then
	#	mkdir "${XDG_RUNTIME_DIR}"
	#	chmod 0700 "${XDG_RUNTIME_DIR}"
	#fi
#fi

#if [ ! "$DISPLAY" ]; then
#    dbus-run-session sway
#fi
