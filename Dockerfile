FROM alpine:3.18

RUN apk add --no-cache bash python3 py3-pip curl

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 8080

CMD ["/run.sh"]
