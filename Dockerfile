ARG BUILD_FROM=ghcr.io/hassio-addons/base/amd64:11.0.0
FROM $BUILD_FROM

# Copy script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
