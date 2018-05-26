#!/bin/bash

echo "Running ${0}"

echo "Setting variables for installation of GT.M"

export platform="linux_x8664"
export build_type="pro"
export version="V6.3-004"

export gtm_user="vagrant"
export gtm_group="vagrant"

export install_dir=/opt/fis-gtm

echo "Platform: ${platform}"
echo "Build type: ${build_type}"
echo "GT.M version: ${version}"

echo "GT.M user: ${gtm_user}"
echo "GT.M group: ${gtm_group}"

echo "Installation dir: ${install_dir}"

echo "Installing prerequisites and additional packages"
yum install -y git libicu-devel strace wget

# Fetch ICU version and pass in --utf8 flag for the install script
sudo /vagrant/gtminstall --group ${gtm_group} --installdir ${install_dir} \
                  --noprompt-for-sys-cfg --prompt-for-group \
                  --user ${gtm_user} --utf8 default --verbose ${version}

echo "Finalizing environment configuration"
cp /vagrant/motd /etc/motd
echo "LC_ALL=en_US.utf-8" >> /etc/locale.conf
echo "source ${install_dir}/gtmprofile" >> /home/vagrant/.bashrc
