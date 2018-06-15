# GT.M Language Extensions

## Operating system interfaces

List of commands that offer an interface to the OS:

1. `ZSYstem`: Offers acces to shell
1. `$ZMessage()`: Translate error code to message
1. `$ZCMdline`: String value with the excess of the command line that invoked GT.M
1. `$Job`: Process ID
1. `$ZPARSE()`: Parse filename
1. `$ZSEARCH()`: Search for files
1. `$ZSYstem`: Exit code of the last `ZSYstem` call
1. `$ZTRNLNM`: Translate environment variable
1. `$ZDIRectory`: Contains current work directory

Examples:

```bash
$ mumps -dir this is some argument

GTM>W $ZCMDLINE
this is some argument

GTM>ZSYSTEM "ls -ltra /home/gtm"
total 24
-rw-r--r-- 1 gtm  gtm   231 Sep  6  2017 .bashrc
-rw-r--r-- 1 gtm  gtm   193 Sep  6  2017 .bash_profile
-rw-r--r-- 1 gtm  gtm    18 Sep  6  2017 .bash_logout
drwxr-xr-x 1 root root 4096 May 26 21:56 ..
drwxr-xr-x 4 gtm  gtm  4096 May 31 06:46 .fis-gtm
drwx------ 1 gtm  gtm  4096 May 31 06:46 .

GTM>WRITE "The mumps process ID: "_$JOB
The mumps process ID: 83

GTM>ZSYSTEM "ps -ef | grep mumps"
gtm         83    66  0 01:57 pts/0    00:00:00 mumps -dir this is some argument
gtm         87    83  0 06:23 pts/0    00:00:00 /bin/sh -c ps -ef | grep mumps
gtm         89    87  0 06:23 pts/0    00:00:00 grep mumps

GTM>W $ZTRNLNM("HOME")
/home/gtm
```
