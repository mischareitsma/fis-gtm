# FIS GT.M

For more information on FIS GT.M, check:
https://www.fisglobal.com/solutions/Banking%20and%20Wealth/Services/Database%20Engine


## Running GT.M

In order to run GT.M, there are three possible solutions:

1. Docker
1. Vagrant
1. Local installation

### Docker

In order to run GT.M in docker, download
[docker](https://www.docker.com/get-docker).

The image `mreitsma/fis-gtm`, found on docker.io, can be used. The entrypoint
of the containers set the environment up to use Mumps directly.

Additionally, the image can be build from scratch by running `docker build`
using the `Dockerfile` that can be found [here](docker/centos/Dockerfile) based
on Cent OS 7, or [here](docker/alpine/Dockerfile) based on alpine. **TODO: The
alpine image is still under construction and cannot be used!**

### Vagrant

In order to run GT.M in Vagrant, download
[Vagrant](https://www.vagrantup.com/downloads.html).

The box `mreitsma/fis-gtm` found on the Vagrant cloud can be used to run GT.M.
**TODO: Still need to create the box, using Packer, cannot use the box at the
moment!**

Additionally, a box can be build from scratch, based on a base CentOS 7 box,
using the Vagrantfile found [here](vagrant/Vagrantfile).

### Install locally

GT.M can be installed locally on various platforms. To install, download the
latest version from [sourceforce](https://sourceforge.net/projects/fis-gtm/),
and execute the `gtminstall` script.
