FROM alpine:3
MAINTAINER Ian Martin "ian@imartin.net"
ARG NUT_VERSION=2.8.0-r4
ENV USER=nut RUNDIR=/var/run/nut ALLOW_NO_DEVICES=yes

RUN apk add -Uuv nut=$NUT_VERSION libusb libusb-compat ca-certificates curl openssh-client && \
  mkdir -p $RUNDIR && \
  echo "0" > $RUNDIR/upsd.pid && \
  echo "0" > $RUNDIR/upsmon.pid && \
  chown -R $USER $RUNDIR && \
  chmod 750 $RUNDIR

COPY config/* /etc/nut/
COPY entrypoint.sh /entrypoint

EXPOSE 3493 9199
USER 0
ENTRYPOINT ["sh", "/entrypoint"]
