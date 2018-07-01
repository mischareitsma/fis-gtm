# Mumps Files Versus Direct Mode

There are two ways of executing mumps code:

1. Executing commands in a command line interface (direct mode)
1. Executing files with mumps code

## mumps -direct; the command line interface

Mumps has a direct mode, a command line interface, that can be started by
executing `mumps -direct`, or `mumps -dir` for short. This start a mumps
process and opens ups a `GTM>` prompt.

When in direct mode, any mumps command can be executed:

```text
$ mumps -dir

GTM>WRITE "Hello World",!
Hello World

GTM>SET X=1,Y=2 SET Z=3

GTM>WRITE X+Y+Z,!
6

GTM>HALT
```

## Mumps files

Mumps can be executed from files with mumps code, also called **routines**, and
have the extension `.m`. The files have to be located in one of the GT.M
routines folders, which are stored in the `${gtmroutines}` environment variable:

```text
[gtm@9cdec379133f ~]$ echo ${gtmroutines}
/home/gtm/.fis-gtm/V6.3-004_x86_64/o*(/home/gtm/.fis-gtm/V6.3-004_x86_64/r /home/gtm/.fis-gtm/r) /opt/fis-gtm/plugin/o(/opt/fis-gtm/plugin/r) /opt/fis-gtm
```

The compiled object code from the mumps files are stored in the directories
that end with `/o` in this example. The directories where the mumps files
are stored end with `/r`:

```text
[gtm@9cdec379133f ~]$ ls .fis-gtm/r/
test.m
[gtm@9cdec379133f ~]$ ls .fis-gtm/V6.3-004_x86_64/o/
test.o  utf8/
```

### Executing routines

The general syntax of executing a mumps routine that is located in one of the
routine folders is:

```
mumps -r <nameOfTheRoutine>
```

Take the following example:

```text
[gtm@f4aee20e9eab .fis-gtm]$ cat /home/gtm/.fis-gtm/V6.3-004_x86_64/r/test.m 
	SET A=1,B=2,C=3
	WRITE "Going to calculate the sum of 1, 2 and 3",!
	DO SUM(A,B,C)
	QUIT
SUM(I,J,K)
	WRITE I+J+K,!
	QUIT

[gtm@f4aee20e9eab .fis-gtm]$ mumps -r test 
Going to calculate the sum of 1, 2 and 3
6
```

As can be seen, the routine `test` is executed from the top of the file.

