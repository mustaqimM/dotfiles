#if test -z "${XDG_RUNTIME_DIR}"; then
  #export XDG_RUNTIME_DIR=/run/user/1000
  #if ! test -d "${XDG_RUNTIME_DIR}"; then
  #   mkdir "${XDG_RUNTIME_DIR}"
  #   chmod 0700 "${XDG_RUNTIME_DIR}"
  #fi
#fi

if [ ! "$DISPLAY" ]; then
  # sx sh ~/.xinitrc 2> .xsession-errors
  LIBSEAT_BACKEND=logind dbus-run-session sway
  # XDG_SESSION_TYPE=wayland dbus-run-session startplasma-wayland
  # startx 2> .xsession-errors
fi
