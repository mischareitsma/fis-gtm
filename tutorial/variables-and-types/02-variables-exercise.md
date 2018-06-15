# Variables

This exercise will show the difference between local and global variables.

## Local variables

Local variables are local to a mumps process. To show this, do the following:

1. Open a mumps direct mode sessions: `mumps -dir`.
1. Set a variable using the `Set` command: `SET X=123`.
1. Write the variable to show that the variable exists, use the `Write` command:
   `WRITE X`
1. Go out of the session with the `Halt` command: `HALT`.
1. Open a new mumps direct mode session and try to write the value of `X` again.

## Global variables

Global variables are written to disk. All global variables start with `^`. To
show the difference with the local variables, do the following:

1. Open a mumps direct mode sessions: `mumps -dir`.
1. Set a global variable using the `Set` command: `SET ^X=123`.
1. Write the variable to show that the variable exists, use the `Write` command:
   `WRITE ^X`
1. Go out of the session with the `Halt` command: `HALT`.
1. Open a new mumps direct mode session and try to write the value of `^X`
   again.

## Number precision

Numbers are precise up to 18 digits. To show the behaviour of big numbers or
numbers with a lot of significant digits after the comma, do the following:

1. Write a long digit to the screen: `W 123456789012345678901234567890`
1. Write a digit with a lot of significant digits after the comma to the screen:
   `W 1234.56789012345678901234567890`
