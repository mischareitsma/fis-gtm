#!/bin/bash

# GT.M installation variables
export version="V63004"
export platform="linux_x8664"
export build_type="pro"

export gtm_user="gtm"
export gtm_group="gtm"

export package=gtm_${version}_${platform}_${build_type}.tar.gz
export distribution=/vagrant/${package}
export install_dir=/opt/fis-gtm/

# Create gtm user

groupadd ${gtm_group}
useradd -c "GT.M User" -g ${gtm_group} -m ${gtm_user}
passwd -d ${gtm_user}

# Install prerequisites

yum install -y gdb git libicu-devel strace wget

# Fetch ICU version and pass in --utf8 flag for the install script

#TODO: Test with default ICU
export icu_version=$(icuinfo -v | grep "name=\"version\"" | awk -F'>' '{print $2}' | awk -F'<' '{print $1}')

echo "Installing GT.M: ${version}, ${platform}, ${build_type}"

temp_dir=$(mktemp -d)
cp ${distribution} ${temp_dir}
cd ${temp_dir}
tar -xzvf ${package}
sudo ./gtminstall \
    --distrib $(pwd) \
	--group ${gtm_group} \
	--installdir ${install_dir} \
	--noprompt-for-sys-cfg \
    --prompt-for-group \
	--user ${gtm_user} \
	--utf8 ${icu_version} \
	--verbose \
    ${version}

cd -
rm -rf ${temp_dir}

cp motd /etc/motd
