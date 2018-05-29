FROM alpine:latest

ADD gtminstall /tmp/

RUN apk update && apk add wget which

RUN addgroup gtm && adduser -h /home/gtm -G gtm -D gtm

RUN mkdir -p /opt/fis-gtm

RUN /tmp/gtminstall --group gtm --user gtm --installdir /opt/fis-gtm \
                    --noprompt-for-sys-cfg --prompt-for-group --utf8 default \
                    --verbose --overwrite-existing V6.3-004

USER gtm

ENTRYPOINT source /fis-gtm/gtmprofile && /bin/sh
