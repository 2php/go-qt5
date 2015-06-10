module("basespinbox")

name = "baseSpinBox"
base = "Widget"

funcs = [[
@ Text() (text string)
@ SetReadOnly(state bool)
@ IsReadOnly()(state bool)
@ SetWrapping(state bool)
@ Wrapping()(state bool)
]]

qtdrv = {
inc = "<QAbstractSpinBox>",
name = "QAbstractSpinBox *",

Text = "text",
SetReadOnly = "setReadOnly",
IsReadOnly = "isReadOnly",
SetWrapping = "setWrapping",
Wrapping = "wrapping",

}