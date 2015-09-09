module("combobox")

name = "ComboBox"
base = "Widget"

funcs = [[
+ Init()

@ Count() (count int)
@ SetCurrentIndex(index int)
@ CurrentIndex() (index int)
@ CurrentText() (text string)
@ SetEditable(b bool)
@ IsEditable() (b bool)
@ SetMaxCount(count int)
@ MaxCount() (count int)
@ SetMaxVisibleItems(max int)
@ MaxVisibleItems() (max int)
@ SetMinimumContentsLength(characters int)
@ MinimunContentsLenght() (characters int)
AddItem(text string)
AddItems(titles []string)
InsertItem(index int, text string)
InsertItems(index int, titles []string)
RemoveItem(index int)
ItemText(index int) (text string)
SetItemText(index int, text string)
ItemIcon(index int)(icon Icon)
SetItemIcon(index int, icon Icon)
SetIconSize(size Size)
SetDuplicatesEnabled(b bool),

* OnCurrentIndexChanged(fn func(int))
]]


qtdrv = {
inc = "<QComboBox>",
name = "QComboBox *",

Init = [[
drvNewObj(a0,new QComboBox);
]],
Count = "count",
SetCurrentIndex = "setCurrentIndex",
CurrentIndex = "currentIndex",
CurrentText = "currentText",
SetEditable = "setEditable",
IsEditable = "isEditable",
SetMaxCount = "setMaxCount",
MaxCount = "maxCount",
SetMaxVisibleItems = "setMaxVisibleItems",
MaxVisibleItems = "maxVisibleItems",
SetMinimumContentsLength = "setMinimumContentsLength",
MinimunContentsLenght = "minimumContentsLength",
AddItem = "addItem",
AddItems = "addItems",
InsertItem = "insertItem",
InsertItems = "insertItems",
RemoveItem = "removeItem",
ItemText = "itemText",
SetItemText = "setItemText",
ItemIcon = "itemIcon",
SetItemIcon = "setItemIcon",
SetIconSize = "setIconSize",
SetDuplicatesEnabled = "setDuplicatesEnabled",


OnCurrentIndexChanged = [[
QObject::connect(self,SIGNAL(currentIndexChanged(int)),drvNewSignal(self,a1,a2),SLOT(call(int)));
]]

}
