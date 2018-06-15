# Variables

## Local variables

```text
[gtm@/home/gtm]$ mumps -dir

GTM>S X=123

GTM>W X
123
GTM>h
[gtm@/home/gtm]$ mumps -dir

GTM>W X
%GTM-E-UNDEF, Undefined local variable: X
```

## Global variables

```text
[gtm@/home/gtm]$ mumps -dir

GTM>S ^X=123

GTM>W ^X
123
GTM>H
[gtm@/home/gtm]$ mumps -dir

GTM>W ^X
123
```

## Number precision

```text
GTM>W 123456789012345678901234567890
123456789012345678000000000000
GTM>W 1234.56789012345678901234567890
1234.56789012345678
```