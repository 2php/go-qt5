module("spinbox")

name = "SpinBox"
base = "baseSpinBox"

funcs = [[
+ Init()

@ CleanText()(text string)
@ SetDisplayIntegerBase(base int)
@ DisplayIntegerBase()(base int)
@ SetMaximum(value int)
@ Maximum()(value int)
@ SetMinimum(value int)
@ Minimum()(value int)
@ SetPrefix(prefix string)
@ Prefix()(prefix string)
@ SetSingleStep(step int)
@ SingleStep()(step int)
@ SetSuffix(suffix string)
@ Suffix()(suffix string)
@ Value()(value int)
@ SetValue(value int)

SetRange(max int, min int)

]]

qtdrv = {
inc = "<QSpinBox>",
name = "QSpinBox *",

Init = [[
drvNewObj(a0,new QSpinBox);
]],

CleanText = "cleanText",
SetDisplayIntegerBase = "setDisplayIntegerBase",
DisplayIntegerBase = "displayIntegerBase",
SetMaximum = "setMaximum",
Maximum = "maximum",
SetMinimum = "setMinimum",
Minimum = "minimum",
SetPrefix = "setPrefix",
Prefix = "prefix",
SetSingleStep = "setSingleStep",
SingleStep = "singleStep",
SetSuffix = "setSuffix",
Suffix = "suffix",
Value = "value",
SetValue = "setValue",
SetRange = "setRange",

}