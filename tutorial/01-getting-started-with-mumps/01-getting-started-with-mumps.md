# Getting Started with Mumps

This document will help to get started with mumps.

## A GT.M environment

To get started with mumps, first install GT.M or use Vagrant or Docker
to virtualize an environment with GT.M.

### Docker

A docker image based on CentOS 7 with GT.M preinstalled can be downloaded
from docker.io, the name of the image is `mreitsma/fis-gtm`

The entrypoint sources the gtmprofile file, which sets environment variables
required to get started with Mumps, and opens a bash shell.

### Vagrant

A Vagrant box based on CentOS 7 with GT.M installed can be downloaded from
the public Vagrant cloud. The name of the box is `mreitsma/fis-gtm`.

In order to get started with GT.M, source the gtmprofile file which can
be found in the installation directory of GT.M: `/opt/fis-gtm/`.

### Installing GT.M

In order to install GT.M on any other system, check the latest version on
[sourceforge](https://sourceforge.net/projects/fis-gtm/). The GT.M download
comes with a gtminstall script, which can be used to guide a GT.M installation.

## Hello World

Mumps is a procedural language, and has an easy to use command line interpreter.
To start the command line interpreter, direct mode, run `mumps -direct`, or
`mumps -dir` for short. This will show the GT.m prompt:

```text
[gtm@f4aee20e9eab ~]$ mumps -direct

GTM>
```

To write output to the console, use the `WRITE` command:

```text
GTM> WRITE "Hello World",!
Hello World

GTM>
```

Two special characters used when writing to the screen are:

1. The exclamation mark `!` invokes a new line.
1. The pound symbol `#` clears the entire screen.

To get out of direct mode, use the `HALT` command.

```text
GTM>HALT
[gtm@f4aee20e9eab ~]$
```
