# Simple Mumps Commands

This chapter will give an overview of the following simple mumps commands:

1. `WRITE`
1. `SET`
1. `KILL`
1. `NEW`
1. `DO`
1. `FOR`
1. `IF`
1. `ELSE`
1. `GOTO`

## The `WRITE` Command

The `WRITE` command is already covered in previous chapters for writing to
the console. However, the `WRITE` command actually writes to the current
IO device, which is represented by the GT.M intrinsic variable `$IO`.

At start up of direct mode or any mumps process, this is set to the console:

```text
GTM>W $IO
/dev/pts/0
```

However, this IO device could also be a file, pipe, socket or null device.

## The `SET` Command

The `SET` command is already covered in previous chapters by setting local and
global variables. Additionally, the behaviour of GT.M can be adjusted by
setting intrinsic GT.M variables.

## The `KILL` Command

The `KILL` command can be used to delete local and global variables. The `KILL`
command can be used in three ways:

1. `KILL someVariable`, `KILL ^AGLOBALVAR`: A `KILL` with a local or global
   variable name as argument will delete the specified variable.
1. `KILL`: An argumentless `KILL` command will delete all local variables
1. `KILL (someLocalVar,someOtherLocalVar)`: A `KILL` with a list of variables
   between parantheses will delete all local variables expcept those specified
   in the list between parantheses.

## The `NEW` Command

In order to understand the effect and purpose of the `NEW` command, consider
the following example:

```text
    A=123
    B=456
    C=0
    DO ADD
    WRITE "C = "_C,!
    QUIT
ADD
    SET C=A+B
```

When running this routine, it will write `C = 579` to the console, and not
raise an error. In Mumps, variables do not have a particular scope by default.
The global variables are written to disk, and are accessible for every Mumps
process, and local variables are stored in memory, and are only available in
one process. However, in that single process, the variable is available
in every label if not specified differently. Therefore, in the example above,
the variables `A`, `B` and `C` are defined in `ADD`.

Now, to show the effect of `NEW`, consider the following example:

```text
    NEW A,B,C
    SET A=123
    SET B=456
    SET C=0
    DO ADD
    WRITE "C in main = "_C,!
    QUIT
ADD
    NEW C
    SET C=A+B
    WRITE "C in ADD = "_C,!
```

## The `DO` Command

There are two ways in which the `DO` command is used. One of these ways is
already covered in the chapter about executing Mumps routines. When
executing a intrinsic label or routine, the `DO` command is used:

```text
DO [label]^routine
```

The second use of `DO` is to introduce code blocks in Mumps routines. These
code blocks can be just that, a block, or the body of an `if` statement, or a
`for` loop:

```text
SOMELABEL
  WRITE "HELLO WOLRD",!
  NEW someVariable
  DO
  . WRITE "THIS IS IN A BLOCK",!
  . SET someVariable = 123
  WRITE "someVariable = "_someVariable,!
  QUIT

SOMEOTHERLABEL
  WRITE "Going to count to 10:",!
  NEW i
  FOR i = 1:1:10 DO
  . WRITE i,!
  QUIT
```
