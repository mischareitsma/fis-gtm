# Executing Mumps Routines Examples

To see the effect of having various mumps routines with the same name in
different routine directories, consider a simple routine that writes some
thing, including the routine directory, to the console.

The `gtmroutines` variable has the following content:

```text
[gtm@ef0cc0e9ae83 ~]$ echo ${gtmroutines}
/home/gtm/.fis-gtm/V6.3-004_x86_64/o*(/home/gtm/.fis-gtm/V6.3-004_x86_64/r /home/gtm/.fis-gtm/r) /opt/fis-gtm/plugin/o(/opt/fis-gtm/plugin/r) /opt/fis-gtm
```

When executing `test.m`, GT.M will look in this order:

1. `/home/gtm/.fis-gtm/V6.3-004_x84_64/r`
1. `/home/gtm/.fis-gtm/r`
1. `/opt/fis-gtm/plugin/r`

First define a routine in the common routine directory `/opt/fis-gtm/plugin/r`,
and see the result of running the routine:

```text
[gtm@749be1ed101b ~]$ cat /opt/fis-gtm/plugin/r/test.m
    WRITE "HELLO WORLD, WE ARE NOW IN /opt/fis-gtm/plugin/r",!
    QUIT

[gtm@749be1ed101b ~]$ mumps -r test
HELLO WORLD, WE ARE NOW IN /opt/fis-gtm/plugin/r
```

Now, introduce a similar routine in the `/home/gtm/.fis-gtm/r` directory, and
see the result of running the routine:

```text
[gtm@749be1ed101b ~]$ cat /home/gtm/.fis-gtm/r/test.m 
    WRITE "HELLO WORLD, WE ARE NOW IN /home/gtm/.fis-gtm/r",!
    QUIT

[gtm@749be1ed101b ~]$ mumps -r test
HELLO WORLD, WE ARE NOW IN /home/gtm/.fis-gtm/r
```

Lastly, introduce the same routine in the
`/home/gtm/.fis-gtm/V6.3-004_x86_64/r` directory, and run the routine to see
the third outcome:

```text
[gtm@749be1ed101b ~]$ cat /home/gtm/.fis-gtm/V6.3-004_x86_64/r/test.m 
    WRITE "HELLO WORLD, WE ARE NOW IN /home/gtm/.fis-gtm/V6.3-004_x86_64/r",!
    QUIT

[gtm@749be1ed101b ~]$ mumps -r test
HELLO WORLD, WE ARE NOW IN /home/gtm/.fis-gtm/V6.3-004_x86_64/r
```
