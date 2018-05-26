FROM registry-all.docker.ing.net/rhel7

LABEL maintainer.name="Mischa Reitsma"
LABEL maintainer.email="Mischa.Reitsma@ing.nl"

# Install prerequisites
RUN yum install -y \
    at \
    gdb \
    git \
    gpgme-devel \
    ksh \
    libgcrypt-devel \
    libicu-devel \
    ncurses-term \
    openssl* \
    strace \
    sysstat
RUN yum clean

# Add the Profile user
RUN groupadd profile && useradd -g profile -m -d /home/profile -s /usr/bin/ksh