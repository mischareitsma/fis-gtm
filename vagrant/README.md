# FIS GT.M Vagrant Box

This project contains all the files used for creating the `mreitsma/fis-gtm`
Vagrant box.

## Building the fis-gtm base box

- Building should be done with Packer
- Disk space should be big enough (base box + 10 GB), and in VBox dynamically
  allocated
- Memory: As 512MB might be enough
- Disable USB controllers and other hardware that is not required.
