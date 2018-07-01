# Arithmetics and String Operations

Mumps comes with the normal artihmetic expressions:

Operator | Description      | Example         | Result
-------- | ---------------- | --------------- | ------
`+`      | Addition         | `WRITE 123+456` | 579
`-`      | Subtraction      | `WRITE 456-123` | 333
`*`      | Multiplication   | `WRITE 123*3`   | 369
`/`      | Division         | `WRITE 25/2`    | 12.5
`\`      | Integer devision | `WRITE 25\2`    | 12
`**`     | Exponent         | `WRITE 2**10`   | 1024

## Unary Operators

There are three unary operators that work on numbers:

Operator | Description       | Example         | Result
-------- | ----------------- | --------------- | ------
`'`      | Negation          | `WRITE '123`    | 0
`+`      | Convert to number | `WRITE +(-123)` | -123
`-`      | Change sign       | `WRITE -(-123)` | 123

Two of these three unary operators are not meant to be used on numbers:

1. The `'` operator is used for boolean expressions. In mumps, all numbers
   unequal to zero are treated as `True`, and zero and the empty string are
   treaded as `False`. Strings are first converted to a number before the
   result is evaluated.
1. The `+` operator is used to convert strings to numbers, and will be
   explained in the next section.

## String Operators

The two operators that works specifically on strings are the unary `+` operator
and the binary `_` operator.

The `+` operator converts a string into a number. This conversion starts
extracting characters that are number (or a leading minus sign), and removes
the rest of the string as soon as it finds a non-number character.

Decimals can also be extracted like this, but the second decimal point is
considered not a part of a number.

Leading zeros are removed when using the `+` operator:

```text
GTM>WRITE +"000123"
123
GTM>WRITE +"-123123"
-123123
GTM>WRITE +"-000123"
-123
GTM>WRITE +"12.12ACB"
12.12
GTM>WRITE +"12.1.2ACB"
12.1
```

The `_` operator is used for concatenating strings.

```text
GTM>WRITE "HELLO"_" "_"WORLD"
HELLO WORLD
GTM>SET A="HELLO"

GTM>SET B="WORLD"

GTM>WRITE A_" "_B
HELLO WORLD
```

## Operator Precedence

The operations in mumps are executed from left to right, and therefore, there
is not operator precedence.

For example, the expected result of the equation `2 + 5 * 6` is `32`. In mumps
the answer is:

```text
GTM>WRITE 2+5*6
42
```

Brackets can be used to ensure that the multiplication is executed first:

```text
GTM>WRITE 2+(5*6)
32
```

The rule for operator precedence also holds for the unary operators. The
of the following boolean expression might be confusing:

```text
GTM>WRITE '5=3
0
GTM>WRITE 5'=3
1
GTM>WRITE '(5=3)
1
```

The first expression might be unexpected, however, first the negation works on
the number 5, which returns 0, and after that, 0 is compared to 3, which
returns false (0). Whereas one might read the expression as 5 not equals
3, which should result in a true (1) Either moving the negation to the equal
sign, or using brackets will result in the expected behaviour.
