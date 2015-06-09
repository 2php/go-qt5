module("messagebox")

name = "MessageBox"
base = "Dialog"

funcs = [[
+ Init()

@ SetText(text string)
@ Text()(text string)
@ SetInformativeText(text string)
@ InformativeText()(text string)
@ SetDetailedText(text string)
@ DetailedText()(text string)
@ SetStandardButtons(buttons StandardButtons)
@ StandardButtons()(buttons StandardButtons)

]]

qtdrv = {
inc = "<QMessageBox>",
name = "QMessageBox *",

Init = [[
drvNewObj(a0,new QMessageBox);
]],

SetText = "setText",
Text = "text",
SetInformativeText = "setInformativeText",
InformativeText = "informativeText",
SetDetailedText = "setDetailedText",
DetailedText = "detailedText",
SetStandardButtons = "setStandardButtons",
StandardButtons = "standardButtons",

}