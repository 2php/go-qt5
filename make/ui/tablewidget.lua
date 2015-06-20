module("tablewidget")

name = "TableWidget"
base = "Widget"

funcs = [[
+ Init()

@ SetColumnCount(cols int)
@ ColumnCount()(cols int)
@ SetRowCount(rows int)
@ RowCount()(rows int)

SetCellWidget(row int, col int, w IWidget)
CellWidget(row int, col int)(w IWidget)
Column(item *TableWidgetItem)(col int)
CurrentColumn()(col int)
SetCurrentCell(row int, col int)
SetCurrentItem(item *TableWidgetItem)
CurrentItem() (item *TableWidgetItem)
CurrentRow()(row int)
EditItem(item *TableWidgetItem)
SetHorizontalHeaderItem(col int, item *TableWidgetItem)
HorizontalHeaderItem(col int)(item *TableWidgetItem)
SetItem(row int, col int, item *TableWidgetItem)
Item(row int, col int) (item *TableWidgetItem)
RemoveCellWidget(row int, col int)
Row(item *TableWidgetItem)(row int)
TakeItem(row int, col int)(item *TableWidgetItem)
TakeHorizontalHeaderItem(col int)(item *TableWidgetItem)
TakeVerticalHeaderItem(row int)(item *TableWidgetItem)
SetVerticalHeaderItem(row int, item *TableWidgetItem)
VerticalHeaderItem(row int)(item *TableWidgetItem)
InsertColumn(col int)
RemoveColumn(col int)
InsertRow(row int)
RemoveRow(row int)
Clear()

* OnCellActivated(fn func(int,int))
* OnCellChanged(fn func(int,int))
* OnCellClicked(fn func(int,int))
* OnCellDoubleClicked(fn func(int,int))
* OnCellEntered(fn func(int,int))
* OnCellPressed(fn func(int,int))
* OnCurrentItemChanged(fn func(*TableWidgetItem,*TableWidgetItem))
* OnItemActivated(fn func(*TableWidgetItem))
* OnItemChanged(fn func(*TableWidgetItem))
* OnItemClicked(fn func(*TableWidgetItem))
* OnItemDoubleClicked(fn func(*TableWidgetItem))
* OnItemEntered(fn func(*TableWidgetItem))
* OnItemPressed(fn func(*TableWidgetItem))
* OnItemSelectionChanged(fn func())
]]

qtdrv = {
inc = "<QTableWidget>",
name = "QTableWidget *",

Init = [[
drvNewObj(a0,new QTableWidget);
]],

SetColumnCount = "setColumnCount",
ColumnCount = "columnCount",
SetRowCount = "setRowCount",
RowCount = "rowCount",
SetCellWidget = "setCellWidget",
CellWidget = "cellWidget",
Column = "column",
CurrentColumn = "currentColumn",
SetCurrentCell = "setCurrentCell",
SetCurrentItem = "setCurrentItem",
CurrentItem = "currentItem",
CurrentRow = "currentRow",
EditItem = "editItem",
SetHorizontalHeaderItem = "setHorizontalHeaderItem", 
HorizontalHeaderItem = "horizontalHeaderItem",
SetItem = "setItem",
Item = "item",
SetItemPrototype = "setItemPrototype", 
ItemPrototype = "itemPrototype",
RemoveCellWidget = "removeCellWidget",
Row = "row",
TakeItem = "takeItem",
TakeHorizontalHeaderItem = "takeHorizontalHeaderItem",
TakeVerticalHeaderItem = "takeVerticalHeaderItem",
SetVerticalHeaderItem = "setVerticalHeaderItem",
VerticalHeaderItem = "verticalHeaderItem",
InsertColumn = "insertColumn",
RemoveColumn = "removeColumn",
InsertRow = "insertRow",
RemoveRow = "removeRow",
Clear = "clear",

OnCellActivated = [[
QObject::connect(self,SIGNAL(cellActivated(int,int)),drvNewSignal(self,a1,a2),SLOT(call(int,int)));
]],
OnCellChanged = [[
QObject::connect(self,SIGNAL(cellChanged(int,int)),drvNewSignal(self,a1,a2),SLOT(call(int,int)));
]],
OnCellClicked = [[
QObject::connect(self,SIGNAL(cellClicked(int,int)),drvNewSignal(self,a1,a2),SLOT(call(int,int)));
]],
OnCellDoubleClicked = [[
QObject::connect(self,SIGNAL(cellDoubleClicked(int,int)),drvNewSignal(self,a1,a2),SLOT(call(int,int)));
]],
OnCellEntered = [[
QObject::connect(self,SIGNAL(cellEntered(int,int)),drvNewSignal(self,a1,a2),SLOT(call(int,int)));
]],
OnCellPressed = [[
QObject::connect(self,SIGNAL(cellPressed(int,int)),drvNewSignal(self,a1,a2),SLOT(call(int,int)));
]],
OnCurrentItemChanged = [[
QObject::connect(self,SIGNAL(currentItemChanged(QTableWidgetItem*,QTableWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QTableWidgetItem*,QTableWidgetItem*)));
]],
OnItemActivated = [[
QObject::connect(self,SIGNAL(itemActivated(QTableWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QTableWidgetItem*)));
]],
OnItemChanged = [[
QObject::connect(self,SIGNAL(itemChanged(QTableWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QTableWidgetItem*)));
]],
OnItemClicked = [[
QObject::connect(self,SIGNAL(itemClicked(QTableWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QTableWidgetItem*)));
]],
OnItemDoubleClicked = [[
QObject::connect(self,SIGNAL(itemDoubleClicked(QTableWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QTableWidgetItem*)));
]],
OnItemEntered = [[
QObject::connect(self,SIGNAL(itemEntered(QTableWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QTableWidgetItem*)));
]],
OnItemPressed = [[
QObject::connect(self,SIGNAL(itemPressed(QTableWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QTableWidgetItem*)));
]],
OnItemSelectionChanged = [[
QObject::connect(self,SIGNAL(itemSelectionChanged(QTableWidgetItem*)),drvNewSignal(self,a1,a2),SLOT(call(QTableWidgetItem*)));
]],
}