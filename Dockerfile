FROM centos:7

LABEL maintainer.name="Mischa Reitsma"
LABEL maintainer.email="reitsma.mischa@gmail.com"

ARG gtmVersion=V6.3-014

ADD gtminstall /tmp/

RUN yum install -y gcc libicu-devel make wget which && yum clean all

RUN groupadd gtm && useradd -g gtm gtm

RUN /tmp/gtminstall --group gtm --user gtm --installdir /opt/fis-gtm \
                    --noprompt-for-sys-cfg --prompt-for-group --utf8 default \
                    --verbose ${gtmVersion}

USER gtm

ENTRYPOINT source /opt/fis-gtm/gtmprofile && /bin/bash
