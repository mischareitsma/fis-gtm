#!/bin/bash
# Download and install GT.M

# Exit on error
set -e

gtm_version=${1}

if [ -z ${gtm_version} ]; then
	echo "Missing required parameter GT.M version"
	exit 1
fi

# Install prerequisites
mkdir /tmp/fis-gtm
GTM_FILENAME=gtm_$(echo ${gtm_version} | tr -d .-)_linux_x8664_pro.tar.gz
wget -q -O /tmp/fis-gtm/${GTM_FILENAME} https://sourceforge.net/projects/fis-gtm/files/GT.M-amd64-Linux/${gtm_version}/${GTM_FILENAME}
cd /tmp/fis-gtm
tar -xzf ${GTM_FILENAME}

./configure << END
gtm
gtm
n
/opt/fis-gtm
y
y
n
n
n
y
END
