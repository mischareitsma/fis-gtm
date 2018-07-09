# Executing Mumps Routines

In previous chapters the command line interface to GT.M, mumps direct mode,
was used to execute some simple mumps commands. In this chapter, a second
method of executing mumps commands will be introduced

## The `gtmroutines` Environment Variable

Mumps commands can be written to a text file, called a routine. This routine
can be executed multiple times, call other routines, and return values.

To create a routine, write mumps commands to a flat file, with the `.m`
extension.

In order to run a mumps routine, the command is `mumps -run <routine-name>`,
or in shorter notation `mumps -r <routine-name>`. The routine name matches
the file name, e.g. `mumps -r mytest` will run `mytest.m`.

GT.M uses the `gtmroutines` environment variable to know which routine to
execute. The `gtmroutines` variable is a list of directory locations where GT.M
should look for the routine.

```text
[gtm@ef0cc0e9ae83 /]$ echo ${gtmroutines}
/home/gtm/.fis-gtm/V6.3-004_x86_64/o*(/home/gtm/.fis-gtm/V6.3-004_x86_64/r /home/gtm/.fis-gtm/r) /opt/fis-gtm/plugin/o(/opt/fis-gtm/plugin/r) /opt/fis-gtm
```

This variable is used by GT.M to search for routines in the following order:

1. `/home/gtm/.fis-gtm/V6.3-004_x84_64/r`
1. `/home/gtm/.fis-gtm/r`
1. `/opt/fis-gtm/plugin/r`

The directory in front of the list of the routine directories, is the directory
where the object files (compiled mumps files) are stored.

## Mumps Routines

When executing a mumps routine, executing starts with the first line of the
`.m` file.

### Labels

In a routine, every line with mumps commands should start with white space. In
case the line does not begin with white space, the first word of the line will
be taken as a label, and is callable from direct mode and from within any mumps
routine.

Take the following example:

```text
    SET A=123
    SET B=456
    ADD(A,B)
    QUIT
ADD(X,Y)
    WRITE X+Y,!
    QUIT
```

The first two lines of the routine define two local variables `A` and `B`, and
assigns a value to these two local variables. The third line calls a label
within the routine. The fourth line executes the `QUIT` command. The `QUIT`
command takes an optional argument, which will be discussed later in this
chapter.

The fifth line does not start with white space, and defines the label `ADD`.
This label takes two parameters, called formal parameters, `X` and `Y`. The
arguments, or actual parameters to the call of `ADD` are `A` and `B`, or
rather their values, `123` and `456`.

On line six, the result of the sum of the two parameters is written to the
console, and the last line is a `QUIT` for the `ADD` label.

### Comments

Lines that start with a semi-colon, or all characters after a semi-colon in
a line with mumps commands is considered a comment, and will not be executed.

Using the previous example:

```text
    SET A=123
    SET B=456
    ; Calling the ADD label with A and B
    ADD(A,B)
    QUIT
ADD(X,Y) ; Adding two numbers
    WRITE X+Y,! ; Write the sum of the input to the console
    QUIT
```

The third line is a comment line. Additionally, the remainder of lines six and seven are
comments, and are not executed.

### QUIT versus QUIT

A label or a routine can either return some value, or return nothing at all.
Labels and routines that return a value are called extrinsic labels. When
calling these labels, the return value cannot be ignored.

Labels that do not return any value are called intrinsic labels or routines.

There is a difference in the syntax when calling an extrinsic label or routine.
The following example shows the difference if in our previous example `ADD`
would not write the sum to the console, but return the sum to the caller:

```text
    SET A=123
    SET B=456
    WRITE $$ADD(A,B),!
    SET C=$$ADD(A,B)
    WRITE "C="_C,!
ADD(A,B)
    QUIT A+B
```

As shown in the example, a extrinsic label or routine requires a `$$` prefix to
the call.

### Falling Through Labels

An intinsic label is not required to have a `QUIT`. A mumps routine will
execute line by line, untill it reaches the end of the file, or a it
encounters a `QUIT`. As an example, see the following elaborate way of
writing `HELLO WORLD` to the console:

```text
    DO WRITEHELLO
    QUIT
WRITEHELLO
    WRITE "HELLO"
WRITESPACE
    WRITE " "
WRITEWORLD
    WRITE "WORLD"
    QUIT
WRITESOMETHING
    WRITE "THIS IS SOMETHING, SHOULD NOT BE WRITTEN TO CONSOLE",!
    QUIT
```

The routine will start by calling the `WRITEHELLO` label. In this label, the
world `HELLO` is written to the console. The next line start the `WRITESPACE`
label, and no `QUIT` is at the end of the `WRITEHELLO` label. Therefore, the
routine will start executing the `WRITESPACE` label, and write a space to the
console. The same logic holds for the `WRITEWORLD` label. However, after
writing `WORLD` to the screen, the routine encounters a `QUIT`, and it will
quit, and continue the executing after the call to `WRITEHELLO`. The next line
is again a `QUIT`, and this will stop the execution of the routine.

Because of the `QUIT` in `WRITEWORLD`, the line
`THIS IS SOMETHING, SHOULD NOT BE WRITTEN TO CONSOLE` will not be written to
the console.

Also, if one would call the `WRITESPACE` label, the resulting line that is
written to the console is ` WORLD`.
