FROM alpine:latest@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412

MAINTAINER Robin Ostlund <me@robinostlund.name>

ENV INST_RCLONE_VERSION=current
ENV ARCH=amd64
ENV SYNC_SRC=
ENV SYNC_DEST=
ENV SYNC_OPTS=-v
ENV RCLONE_OPTS="--config /config/rclone.conf"
ENV CRON=
ENV CRON_ABORT=
ENV FORCE_SYNC=
ENV CHECK_URL=
ENV TZ=

RUN apk -U add ca-certificates fuse wget dcron tzdata \
    && rm -rf /var/cache/apk/* \
    && cd /tmp \
    && wget -q http://downloads.rclone.org/rclone-${INST_RCLONE_VERSION}-linux-${ARCH}.zip \
    && unzip /tmp/rclone-${INST_RCLONE_VERSION}-linux-${ARCH}.zip \
    && mv /tmp/rclone-*-linux-${ARCH}/rclone /usr/bin \
    && rm -r /tmp/rclone*

COPY entrypoint.sh /
COPY sync.sh /
COPY sync-abort.sh /

VOLUME ["/config"]

ENTRYPOINT ["/entrypoint.sh"]

CMD [""]
