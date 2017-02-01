FROM gcr.io/stacksmith-images/minideb:jessie-r8
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_IMAGE_VERSION=3.4.1-r2 \
    BITNAMI_APP_NAME=mongodb \
    BITNAMI_APP_USER=mongo

ENV RUN_USER            mongodb
ENV RUN_USER_UID        3027
ENV RUN_GROUP           mongodb
ENV RUN_GROUP_GID       3027

RUN \
    groupadd --gid ${RUN_GROUP_GID} -r ${RUN_GROUP} && \
    useradd -r --uid ${RUN_USER_UID} -g ${RUN_GROUP} ${RUN_USER}

# System packages required
RUN install_packages libssl1.0.0 libc6 libgcc1 libpcap0.8

# Install mongodb
RUN bitnami-pkg unpack mongodb-3.4.1-1 --checksum 1169f363922417c5d445b1edb7ffda8561e6f6a725b072edca7781dd1859fba0

ENV PATH=/opt/bitnami/$BITNAMI_APP_NAME/sbin:/opt/bitnami/$BITNAMI_APP_NAME/bin:$PATH

COPY rootfs/ /
ENTRYPOINT ["/app-entrypoint.sh"]
CMD ["nami", "start", "--foreground", "mongodb"]

RUN chown -R ${RUN_USER}:${RUN_GROUP} /var/lib/mongodb /var/log/mongodb

VOLUME ["/bitnami/$BITNAMI_APP_NAME"]

EXPOSE 27017
