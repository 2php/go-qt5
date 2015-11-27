module("basebutton")

name = "baseButton"
base = "Widget"

funcs = [[
@ SetText(text string)
@ Text() (text string)
@ SetIcon(icon *Icon)
@ Icon() (icon *Icon)
@ SetIconSize(sz Size)
@ IconSize() (sz Size)
@ SetCheckable(b bool)
@ IsCheckable() (b bool)
@ SetChecked(b bool)
@ IsChecked() (b bool)
@ SetDown(b bool)
@ IsDown() (b bool)
@ SetAutoExclusive(b bool)
@ AutoExclusive() (b bool)
@ SetAutoRepeat(b bool)
@ AutoRepeat() (b bool)
@ SetAutoRepeatDelay(i int)
@ AutoRepeatDelay() (i int)
@ SetAutoRepeatInterval(i int)
@ AutoRepeatInterval() (i int)
@ AnimateClick(i int)
@ Click()
@ Toggle()

* OnClicked(fn func())
* OnClickedGetChecked(fn func(bool))
* OnPressed(fn func())
* OnReleased(fn func())
* OnToggled(fn func(bool))
]]

qtdrv = {
inc = "<QAbstractButton>",
name = "QAbstractButton *",

SetText = "setText",
Text = "text",
SetIcon = "setIcon",
Icon = "icon",
SetIconSize = "setIconSize",
IconSize = "iconSize",
SetCheckable = "setCheckable",
IsCheckable = "isCheckable",
SetChecked = "setChecked",
IsChecked = "isChecked",
SetDown = "setDown",
IsDown = "isDown",
SetAutoExclusive = "setAutoExclusive",
AutoExclusive = "autoExclusive",
SetAutoRepeat = "setAutoRepeat",
AutoRepeat = "autoRepeat",
SetAutoRepeatDelay = "setAutoRepeatDelay",
AutoRepeatDelay = "autoRepeatDelay",
SetAutoRepeatInterval = "setAutoRepeatInterval",
AutoRepeatInterval = "autoRepeatInterval",
AnimateClick = "animateClick",
Click = "click",
Toggle = "toggle",

OnClicked = [[
QObject::connect(self,SIGNAL(clicked()),drvNewSignal(self,a1,a2),SLOT(call()));
]],
OnClickedGetChecked = [[
QObject::connect(self,SIGNAL(clicked(bool)),drvNewSignal(self,a1,a2),SLOT(call(bool)));
]],
OnPressed = [[
QObject::connect(self,SIGNAL(pressed()),drvNewSignal(self,a1,a2),SLOT(call()));
]],
OnReleased = [[
QObject::connect(self,SIGNAL(released()),drvNewSignal(self,a1,a2),SLOT(call()));
]],
OnToggled = [[
QObject::connect(self,SIGNAL(toggled(bool)),drvNewSignal(self,a1,a2),SLOT(call(bool)));
]],
}
