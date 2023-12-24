#! /usr/env sh

called_as=$1
shift

case $called_as in
  upsdrvctl)
    exec upsdrvctl -u nut -D start "$@"
    ;;
  upsd)
    exec upsd -u nut -D "$@"
    ;;
  upsmon)
    exec upsmon -u nut -D "$@"
    ;;
  list-drivers)
    exec ls -1 --color=never /usr/lib/nut
    sleep 5
    ;;
  scan)
    exec nut-scanner -N
    ;;
  *)
    echo "Unknown Command: '$called_as'"
    sleep 10
    exit 3
    ;;
esac
