module("doublespinbox")

name = "DoubleSpinBox"
base = "baseSpinBox"

funcs = [[
+ Init()

@ CleanText()(text string)
@ SetDecimals(value int)
@ Decimals()(value int)
@ SetMaximum(value float64)
@ Maximum()(value float64)
@ SetMinimum(value float64)
@ Minimum()(value float64)
@ SetPrefix(prefix string)
@ Prefix()(prefix string)
@ SetSingleStep(step float64)
@ SingleStep()(step float64)
@ SetSuffix(suffix string)
@ Suffix()(suffix string)
@ Value()(value float64)
@ SetValue(value float64)

SetRange(max float64, min float64)

* OnValueChanged(fn func())

]]

qtdrv = {
inc = "<QDoubleSpinBox>",
name = "QDoubleSpinBox *",

Init = [[
drvNewObj(a0,new QDoubleSpinBox);
]],

CleanText = "cleanText",
SetDecimals = "setDecimals",
Decimals = "decimals",
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

OnValueChanged = [[
QObject::connect(self,SIGNAL(valueChanged(double)),drvNewSignal(self,a1,a2),SLOT(call(double)));
]],

}