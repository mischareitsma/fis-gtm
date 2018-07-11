# Executing Mumps Routines

In previous chapters the command line interface to GT.M, mumps direct mode,
was used to execute some simple mumps commands. In this chapter, a second
method of executing mumps commands will be introduced

## The `gtmroutines` Environment Variable

Mumps commands can be written to a text file, called a routine. This routine
can be executed multiple times, call other routines, and return values.

To create a routine, write mumps commands to a flat file, with the `.m`
extension.

When executing the routine for the first time, GT.M will compile the mumps
routine into an object file. At subsequent executions of the same routine,
GT.M will use the object file, and not the source file.

The command `mumps -run <routine-name>`, or in short notation
`mumps -r <routine-name>` executes a mumps routine. The routine name matches
the file name, e.g. `mumps -r mytest` will run the mumps code in `mytest.m`.

GT.M uses the `gtmroutines` environment variable to search for routines or
objects to execute. The `gtmroutines` variable is a list of directory locations
where GT.M should look for the source routines or the compiled object files.

```text
[gtm@ef0cc0e9ae83 /]$ echo ${gtmroutines}
/home/gtm/.fis-gtm/V6.3-004_x86_64/o*(/home/gtm/.fis-gtm/V6.3-004_x86_64/r /home/gtm/.fis-gtm/r) /opt/fis-gtm/plugin/o(/opt/fis-gtm/plugin/r) /opt/fis-gtm
```

The conent of the `gtmroutines` variable is stored in the intrisic GT.M
variable `$ZROUTINES`.

This variable has a space-seperated list of directories, where there are
two possible ways of defining the location where GT.M looks:

1. Different routine and object directories: To store object files in a
   different location than the mumps routines, the syntax is
   `/dir/to/object/files(/list/of/dirs /to/mumps/routines)`. In this example,
   the director `/dir/to/object/files` stores the object files of routines that
   are located in either `/list/of/dirs` or `/to/mumps/routines`.
1. Object and routine files in the same location: `/dir/with/both/files`. In
   this example, the object file of the routine `/dir/with/both/files/test.m`
   can be found at `/dir/with/both/files/test.o`.

The order matters for `$ZROUTINES`. When executing a routine with the
`mumps -run` command, for example `test`, the following order is used by GT.M:

1. Check for `test.o` in directories that start with 
   `/home/gtm/.fis-gtm/V6.3-004_x86_64/o` (note the wild card `*` in
   `gtmroutines`)
   1. Check for `test.m` in `/home/gtm/.fis-gtm/V6.3-004_x84_64/r`
   1. Check for `test.m` in `/home/gtm/.fis-gtm/r`
1. Check for `test.o` in `/opt/fis-gtm/plugin/o`
   1. Check for `test.m` in `/opt/fis-gtm/plugin/r`
1. Check for `test.o` in `/opt/fis-gtm`
1. Check for `test.m` in `/opt/fis-gtm`

The `/opt/fis-gtm` directory is the GT.M installation directory, and contains
a lot of GT.M utilities, the so-called `%` routines.

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

When calling this routine, the execution order is:

1. The routine will start by calling the `WRITEHELLO` label.
1. In the `HELLOWORLD` label, the world `HELLO` is written to the console.
1. The next line start the `WRITESPACE` label, and no `QUIT` is at the end of
   the `WRITEHELLO` label. Therefore, the routine will start executing the
   `WRITESPACE` label.
1. In the `WRITESPACE` label a space is written to the console.
1. No `QUIT` at the end of `WRITESPACE` results in executing the `WRITEWORLD`
   label.
1. In the `WRITEWORLD` label, the word `WORLD` is written to the console. After
   writing `WORLD` to the screen, the routine encounters a `QUIT`, and it will
   quit, and continue the executing after the call to `WRITEHELLO`.
1. The last line of the top level of the routine is a `QUIT`, and will stop the
   execution of the routine.

Because of the `QUIT` in `WRITEWORLD`, the line
`THIS IS SOMETHING, SHOULD NOT BE WRITTEN TO CONSOLE` will not be written to
the console.

Also, if one would call the `WRITESPACE` label, the resulting line that is
written to the console is ` WORLD`.

## Object Files

When taking a closer look at the `gtmroutines` variable,