# FIS GT.M

GT.M, an abbreviation of Greenwitch Technology M, is a key-value database
optimized for high performance transaction processing. The data structure
follows the schema-less tree structure.

Additionally, GT.M is a development platform and compiler for Mumps.

For more information on FIS GT.M, check the [Wikipedia][wiki-gtm] entry.

## GT.M Docker Images

In order to run GT.M in docker, download [docker]. The images are published
on docker.io as `mreitsma/fis-gtm`. The entry point for the containers sets up
the environment to be able to run `mumps` directly.

## Install locally

GT.M can be installed locally on various platforms. To install, download the
latest version from [sourceforge], and execute the `gtminstall` script or run
`configure`.

[wiki-gtm]: https://en.wikipedia.org/wiki/GT.M
[docker]: https://www.docker.com/get-docker
[sourceforge]: https://sourceforge.net/projects/fis-gtm/
