module("listwidget")

name = "ListWidget"
base = "Widget"

funcs = [[
+ Init()
@ Count() (count int)
@ SetCurrentItem(item *ListWidgetItem)
@ CurrentItem() (item *ListWidgetItem)
@ SetCurrentRow(row int)
@ CurrentRow() (row int)
@ IsSortingEnabled()(b bool)
@ SetSortingEnabled(b bool)
AddItem(item *ListWidgetItem)
AddItems(labels []string)
InsertItem(index int,item *ListWidgetItem)
InsertItems(index int,items []string)
EditItem(item *ListWidgetItem)
TakeItem(row int) (item *ListWidgetItem)
Item(row int) (item *ListWidgetItem)
ItemAt(x int, y int)(item *ListWidgetItem)
SetItemWidget(item *ListWidgetItem, widget IWidget)
ItemWidget(item *ListWidgetItem)(widget IWidget)
RemoveItemWidget(item *ListWidgetItem)
Row(item *ListWidgetItem)(row int)
Clear()
* OnCurrentItemChanged(fn func(*ListWidgetItem,*ListWidgetItem))
* OnCurrentRowChanged(fn func(int))
* OnItemActivated(fn func(*ListWidgetItem))
* OnItemChanged(fn func(*ListWidgetItem))
* OnItemClicked(fn func(*ListWidgetItem))
* OnItemDoubleClicked(fn func(*ListWidgetItem))
* OnItemEntered(fn func(*ListWidgetItem))
* OnItemPressed(fn func(*ListWidgetItem))
* OnItemSelectionChanged(fn func())
]]

expands = [[
func (p *ListWidget) AddItemByLabel(label string) {
    newItem := NewListWidgetItemWithText(label)
    p.AddItem(newItem)
}

func (p *ListWidget) InsertItemByLabel(index int, label string) {
    newItem := NewListWidgetItemWithText(label)
    p.InsertItem(index, newItem)
}
]]

qtdrv = {
inc = "<QListWidget>",
name = "QListWidget *",

Init = [[
drvNewObj(a0,new QListWidget);
]],

Count = "count",
SetCurrentItem = "setCurrentItem",
CurrentItem = "currentItem",
SetCurrentRow = "setCurrentRow",
CurrentRow = "currentRow",
IsSortingEnabled = "isSortingEnabled",
SetSortingEnabled = "setSortingEnabled",
AddItem = "addItem",
AddItems = "addItems",
InsertItem = "insertItem",
InsertItems = "insertItems",
EditItem = "editItem",
TakeItem = "takeItem",
Item = "item",
ItemAt = "itemAt",
SetItemWidget = "setItemWidget",
ItemWidget = "itemWidget",
RemoveItemWidget = "removeItemWidget",
Row = "row",
Clear = "clear",

OnCurrentItemChanged = [[
QObject::connect(self,SIGNAL(currentItemChanged(QListWidgetItem*,QListWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QListWidgetItem*,QListWidgetItem*)));
]],
OnCurrentRowChanged = [[
QObject::connect(self,SIGNAL(currentRowChanged(int)),drvNewSignal(self,a1,a2),SLOT(call(int)));
]],
OnItemActivated = [[
QObject::connect(self,SIGNAL(itemActivated(QListWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QListWidgetItem*)));
]],
OnItemChanged = [[
QObject::connect(self,SIGNAL(itemChanged(QListWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QListWidgetItem*)));
]],
OnItemClicked = [[
QObject::connect(self,SIGNAL(itemClicked(QListWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QListWidgetItem*)));
]],
OnItemDoubleClicked = [[
QObject::connect(self,SIGNAL(itemDoubleClicked(QListWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QListWidgetItem*)));
]],
OnItemEntered = [[
QObject::connect(self,SIGNAL(itemEntered(QListWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QListWidgetItem*)));
]],
OnItemPressed = [[
QObject::connect(self,SIGNAL(itemPressed(QListWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QListWidgetItem*)));
]],
OnItemSelectionChanged = [[
QObject::connect(self,SIGNAL(itemSelectionChanged(QListWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QListWidgetItem*)));
]],
}
