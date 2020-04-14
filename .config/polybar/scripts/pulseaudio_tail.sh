#!/bin/sh

sink=0

volume_up() {
    pactl set-sink-volume $sink +1%
}

volume_down() {
    pactl set-sink-volume $sink -1%
}

volume_mute() {
    pactl set-sink-mute $sink toggle
}

volume_print() {
    if pacmd list-sinks | grep active | head -n 1 | grep -q speaker; then
        icon=""
    elif pacmd list-sinks | grep active | head -n 1 | grep -q headphones; then
        icon=""
    else
        icon="婢"
    fi

    muted=$(pamixer --sink $sink --get-mute)

    if [ "$muted" = true ]; then
        echo "$icon --"
    else
        echo "$icon $(pamixer --sink $sink --get-volume)"
    fi
}

listen() {
    volume_print

    pactl subscribe | grep --line-buffered "sink" | while read -r e; do
        volume_print;
    done
}

case "$1" in
    --up)
        volume_up
        ;;
    --down)
        volume_down
        ;;
    --mute)
        volume_mute
        ;;
    *)
        listen
        ;;
esac
