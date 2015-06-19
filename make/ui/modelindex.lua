module("modelindex")

name = "ModelIndex"
base = "object"

funcs = [[
+ Init()

Column()(col int)
Flags()(fls ItemFlags)
IsValid()(b bool)
Row()(row int)
StringData()(data string)
IntegerData()(i int)
FloatData()(f float64)

]]

qtdrv = {

name = "ShellModelIndex *",

Init = [[
drvNewObj(a0, new ShellModelIndex);
]],

Column = "column",
Flags = "flags",
IsValid = "isValid",
Row = "row",
StringData = "stringData",
IntegerData = "integerData",
FloatData = "floatData",

}