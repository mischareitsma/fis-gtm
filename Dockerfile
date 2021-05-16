FROM centos:7

LABEL maintainer.name="Mischa Reitsma"
LABEL maintainer.email="reitsma.mischa@gmail.com"

RUN groupadd gtm && useradd -g gtm gtm && \
    yum install -y gcc libicu-devel make wget which file && \
    yum clean all && \
    rm -rf /var/cache/yum

ARG gtmVersion=V6.3-014
ADD install_gtm.sh /tmp/
RUN chmod +x /tmp/install_gtm.sh && /tmp/install_gtm.sh ${gtmVersion} && rm -rf /tmp/*

USER gtm

ENTRYPOINT source /opt/fis-gtm/gtmprofile && /bin/bash
