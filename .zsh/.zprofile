#!/bin/sh
# .profile

if test -z "${XDG_RUNTIME_DIR}"; then
    export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
    if ! test -d "${XDG_RUNTIME_DIR}"; then
        mkdir "${XDG_RUNTIME_DIR}"
        chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi

if [ -f ~/.bashrc ]; then . .bashrc; fi

if [[ ! $DISPLAY ]]; then
  sx sh ~/.xinitrc 2> .xsession-errors
  #startx 2> .xsession-errors
fi
