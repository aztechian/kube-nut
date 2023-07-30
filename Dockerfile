FROM alpine:3
MAINTAINER Ian Martin "ian@imartin.net"
ARG NUT_VERSION=2.8.0-r4 NUT_EXPORTER_VERSION=3.0.0
ENV USER=nut RUNDIR=/var/run/nut ALLOW_NO_DEVICES=yes

RUN apk add -Uuv nut=$NUT_VERSION libusb libusb-compat ca-certificates curl openssh-client && \
  mkdir -p $RUNDIR && \
  echo "0" > $RUNDIR/upsd.pid && \
  echo "0" > $RUNDIR/upsmon.pid && \
  chown -R $USER $RUNDIR && \
  chmod 750 $RUNDIR && \
  curl -sL https://github.com/DRuggeri/nut_exporter/releases/download/v$NUT_EXPORTER_VERSION/nut_exporter-v$NUT_EXPORTER_VERSION-linux-amd64 -o /usr/local/bin/nut_exporter && \
  chmod 755 /usr/local/bin/nut_exporter

COPY config/* /etc/nut/
COPY entrypoint.sh /entrypoint

EXPOSE 3493 9199
USER 0
ENTRYPOINT ["sh", "/entrypoint"]
