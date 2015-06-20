module("tablewidgetitem")

name = "TableWidgetItem"
base = "object"

funcs = [[
+ Init()
+ InitWithText(text string)
- Close()

SetBackground(b Brush)
Background()(b Brush)
SetCheckState(c CheckState)
CheckState()(c CheckState)
Column()(i int)
SetFlags(f ItemFlags)
Flags()(f ItemFlags)
SetFont(f Font)
Font()(f Font)
SetForeground(b Brush)
Foreground()(b Brush)
SetIcon(i Icon)
Icon()(i Icon)
SetSelected(b bool)
IsSelected()(b bool)
Row()(i int)
SetSizeHint(s Size)
SizeHint()(s Size)
SetStatusTip(s string)
StatusTip()(s string)
SetText(s string)
Text()(s string)
SetTextAlignment(i int)
TextAlignment()(i int)
SetToolTip(s string)
ToolTip()(s string)
SetWhatsThis(s string)
WhatsThis()(s string)

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

SetBackground = "setBackground",
Background = "background",
SetCheckState = "setCheckState",
CheckState = "checkState",
Column = "column",
SetFlags = "setFlags",
Flags = "flags",
SetFont = "setFont",
Font = "font",
SetForeground = "setForeground",
Foreground = "foreground",
SetIcon = "setIcon",
Icon = "icon",
SetSelected = "setSelected",
IsSelected = "isSelected",
Row = "row",
SetSizeHint = "setSizeHint",
SizeHint = "sizeHint",
SetStatusTip = "setStatusTip",
StatusTip = "statusTip",
SetText = "setText",
Text = "text",
SetTextAlignment = "setTextAlignment",
TextAlignment = "textAlignment",
SetToolTip = "setToolTip",
ToolTip = "toolTip",
SetWhatsThis = "setWhatsThis",
WhatsThis = "whatsThis",

}