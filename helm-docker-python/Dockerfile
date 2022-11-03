FROM alpine:latest
RUN apk add --no-cache util-linux
RUN mkdir -p /tmp
ADD manage-startup-script.sh /
CMD ["/bin/ash" "-c" "/manage-startup-script.sh"]
