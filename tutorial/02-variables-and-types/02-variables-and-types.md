# Variables and Types in Mumps

This chapter sumarizes the different kind of variables and variable types in
mumps.

## Local and Global Variables

In mumps, there are two different kind of variables:

1. Local variables: Variables that are local to the mumps process, and will be
   lost when the mumps process stops.
1. Global variables: Variables that are written to disk, and exist beyond the
   mumps process. These variables are accessible in all mumps processes. All
   global variables start with a `^`.

Note that the terms local and global variables in mumps have a different
meaning than in other languages. For other languages, local variables are
local to the scope in which they are declared, and global variables have a
global scope.

To give a variable a value, the `SET` command is used:

```text
GTM>SET A=123

GTM>W A,!
123

GTM>S ^A=321

GTM>W ^A,!
321
```

To see the difference between the local variable `A` and the global variable
`^A`, go out of mumps direct mode, start a new mumps direct process, and write
the value of both to the console:

```text
GTM>W A
%GTM-E-UNDEF, Undefined local variable: A

GTM>W ^A
321
```

## Strings and Numbers

Mumps only knows two kind of variables, strings and numbers, where numbers
can be either floating point or integer.

The Mumps numbers have a precision up to 18 digits, regardless of the sign.
After 18 digits, the least significant numbers will be zero:

```text
GTM>WRITE 123123123123123123123123123123,!
123123123123123123000000000000

GTM>WRITE 12.31231231231234444444444,!
12.3123123123123444
```

Strings do have different behaviour, and will not take into consideration the
precision:

```
GTM>WRITE "123123123123123123123123123123",!
123123123123123123123123123123

GTM>WRITE "12.31231231231234444444444",!
12.31231231231234444444444
```

## Trees

Variables in mumps can be tree based variables, where one variable can have
multiple nodes. The variable itself can also contain data.

The keys of the nodes are called subscripts.

To write a full variable, including all subnodes, to the console, use the
`ZWRITE` command.

First, set the values of various nodes in the tree:

```text
GET>SET A=123

GET>SET A(1)=321

GET>SET A(1,1)=456

GET>SET A(1,2)=654

GET>SET A(2)=789

GET>SET A(2,1)=987

GET>SET A(2,2)=000

GET>SET A("ThisIsAString")="The value is also a string"
```

Now, to write the entire tree to the console, use `ZWRITE A`:

```text
GTM>ZWRITE A
A=123
A(1)=321
A(1,1)=456
A(1,2)=654
A(2)=789
A(2,1)=987
A(2,2)=0
A("ThisIsAString")="The value is also a string"
```

It is also possible to define the value for the first subscripts to filter
the nodes that are written to the console:

```text
GTM>ZWRITE A(2,*)
A(2)=789
A(2,1)=987
A(2,2)=0
```

Do note the `*`, and see the different behaviour whitout the `*`:

```text
GTM>ZWR A(2)
A(2)=789
```

The same can be done with global variables:

```text
GTM>SET ^A=123

GTM>SET ^A("one")=1

GTM>SET ^A("one","two")="1,2"

GTM>SET ^A(2)=2

GTM>ZWRITE ^A
^A=123
^A(2)=2
^A("one")=1
^A("one","two")="1,2"

GTM>ZWRITE ^A("one",*)
^A("one")=1
^A("one","two")="1,2"

GTM>ZWRITE ^A("one")
^A("one")=1
```