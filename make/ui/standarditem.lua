module("standarditem")

name = "StandardItem"
base = "object"

funcs = [[
+ Init()
+ InitWithText(text string)
+ InitWithTextAndIcon(icon Icon, text string)
+ InitWithRowsAndCols(rows int, cols int)

SetBackground(brush Brush)
Background()(brush Brush)
Column()(col int)
SetFont(font Font)
Font()(font Font)
SetForeground(brush Brush)
Foreground()(brush Brush)
SetIcon(icon Icon)
Icon()(icon Icon)
Index()(ind ModelIndex)
SetCheckState(state CheckState)
CheckState()(state CheckState)
SetCheckable(b bool)
IsCheckable()(b bool)
SetDragEnabled(b bool)
IsDragEnabled()(b bool)
SetDropEnabled(b bool)
IsDropEnabled()(b bool)
SetEditable(b bool)
IsEditable()(b bool)
SetEnabled(b bool)
IsEnabled()(b bool)
SetFlags(flags ItemFlags)
Flags()(flags ItemFlags)
SetSelectable(b bool)
IsSelectable()(b bool)
SetSizeHint(sz Size)
SizeHint()(sz Size)
SetStatusTip(tip string)
StatusTip()(tip string)
SetText(text string)
Text()(text string)

]]

qtdrv = {

name = "ShellStandardItem *",

Init = [[
drvNewObj(a0, new ShellStandardItem);
]],
InitWithText = [[
drvNewObj(a0, new ShellStandardItem(drvGetString(a1)));
]],
InitWithTextAndIcon = [[
drvNewObj(a0, new ShellStandardItem(drvGetIcon(a1), drvGetString(a2)));
]],
InitWithRowsAndCols = [[
drvNewObj(a0, new ShellStandardItem(drvGetInt(a1), drvGetInt(a2)));
]],

SetBackground = "setBackground",
Background = "background",
Column = "column",
SetForeground = "setForeground",
Foreground = "foreground",
SetIcon = "setIcon",
Icon = "icon",
SetCheckState = "setCheckState",
CheckState = "checkState",
SetCheckable = "setCheckable",
IsCheckable = "isCheckable",
SetDragEnabled = "setDragEnabled",
IsDragEnabled = "isDragEnabled",
SetDropEnabled = "setDropEnabled",
IsDropEnabled = "isDropEnabled",
SetEditable = "setEditable",
IsEditable = "isEditable",
SetEnabled = "setEnabled",
IsEnabled = "isEnabled",
SetFlags = "setFlags",
Flags = "flags",
SetFont = "setFont",
Font = "font",
SetSelectable = "setSelectable",
IsSelectable = "isSelectable",
SetSizeHint = "setSizeHint",
SizeHint = "sizeHint",
SetStatusTip = "setStatusTip",
StatusTip = "statusTip",
SetText = "setText",
Text = "text",

}