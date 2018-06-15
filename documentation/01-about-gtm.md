# About GT.M

Some introductory notes about GT.M.

## Managing data

Mumps handles data in one of two ways:

1. **Local variable**: A local variable is an in memory variable that exists
   as long as the GT.M process is alive.
1. **Global variable**: Data that persists beyond the life time of the process.
   Global variables are written to disk, and can be read from disk in another
   GT.M process. The database and database file structure can be maintained
   by the Global Directory Editor (GDE). Global variables are variables that
   start with a carrot `^`.

## Source code and direct mode

There are two ways to execute Mumps code, by executing a source file with
Mumps code, or executing lines of Mumps code in direct mode.

To start direct mode, run `mumps -direct` or `mumps --dir` for short. This will
show the GT.M prompt, and allows for executing mumps commands:

```mumps
GTM>SET ^A=1

GTM>SET ^B=2

GTM>WRITE ^A+^B+123
126
```

A second way of executing Mumps code is storing the commands in a source file:

```bash
$ cat /home/gtm/.fis-gtm/r/somefile.m
	WRITE "START SUMMING"
	DO SUMLIST("1,2,123")
	WRITE "DONE SUMMING"
	QUIT
ADD(A,B)
	QUIT A+B
SUMLIST(LISTNUM)
	NEW N SET N=0
	FOR iter=1:1:$LENGTH(LISTNUM,",") D
	. SET N=$$ADD(N,$PIECE(LISTNUM,",",iter))
	WRITE "Sum of "_LISTNUM_" is "_N,!
	QUIT
$ mumps -r somefile
START SUMMING
Sum of 1,2,123 is 126
DONE SUMMING
```
