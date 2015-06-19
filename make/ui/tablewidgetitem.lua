module("tablewidgetitem")

name = "TableWidgetItem"
base = "object"

funcs = [[
+ Init()
+ InitWithText(text string)
- Close()

]]

qtdrv = {

name = "ShellTableWidgetItem *",

Init = [[
drvNewObj(a0,new ShellTableWidgetItem);
]],
InitWithText = [[
drvNewObj(a0, new ShellTableWidgetItem(drvGetString(a1)));
]],
Close = [[
drvDelObj(a0,self);
]],

}