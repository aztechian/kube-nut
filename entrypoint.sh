#! /usr/env sh

called_as=$1
shift

# setup for upsdrvctl and upsd. They expect a pid file in /var/run/nut and access
mkdir -p $RUNDIR
chown -R $USER $RUNDIR
chmod 750 $RUNDIR
echo "0" > $RUNDIR/upsd.pid
echo "0" > $RUNDIR/upsmon.pid

case $called_as in
  upsdrvctl)
    exec upsdrvctl -u root -D start "$@"
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
