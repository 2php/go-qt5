module("messagebox")

name = "MessageBox"
base = "Dialog"

funcs = [[
+ Init()

@ SetText(text string)
@ Text()(text string)
@ SetDetailedText(text string)
@ DetailedText()(text string)

]]

qtdrv = {
inc = "<QMessageBox>",
name = "QMessageBox *",

Init = [[
drvNewObj(a0,new QMessageBox);
]],

SetText = "setText",
Text = "text",
SetDetailedText = "setDetailedText",
DetailedText = "detailedText",

}