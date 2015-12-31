module("button")

name = "Button"
base = "baseButton"

funcs = [[
+ Init()
+ InitWithText(text string)
@ SetFlat(b bool)
@ IsFlat()(b bool)
@ SetDefault(b bool)
@ IsDefault()(b bool)
@ SetMenu(menu *Menu)
@ Menu()(menu *Menu)

]]


qtdrv = {
inc = "<QPushButton>",
name = "QPushButton *",

Init = [[
drvNewObj(a0,new QPushButton);
]],

InitWithText = [[
drvNewObj(a0,new QPushButton(drvGetString(a1)));
]],

SetFlat ="setFlat",
IsFlat = "isFlat",
SetDefault = "setDefault",
IsDefault = "isDefault",
SetMenu = "setMenu",
Menu = "menu",

}
