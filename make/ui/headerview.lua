module("headerview")

name = "HeaderView"
base = "Widget"

funcs = [[
+Init(orient Orientation)

@ SetCascadingSectionResizes(b bool)
@ CascadingSectionResizes()(b bool)
@ SetDefaultAlignment(a Alignment)
@ DefaultAlignment()(a Alignment)
@ SetDefaultSectionSize(i int)
@ DefaultSectionSize()(i int)
@ SetHighlightSections(b bool)
@ HighlightSections()(b bool)
@ SetMaximumSectionSize(i int)
@ MaximumSectionSize()(i int)
@ SetMinimumSectionSize(i int)
@ MinimumSectionSize()(i int)
@ SetSortIndicatorShown(b bool)
@ IsSortIndicatorShown()(b bool)
@ SetStretchLastSection(b bool)
@ StretchLastSection()(b bool)

Count()(i int)
HiddenSectionCount()(i int)
ShowSection(i int)
HideSection(i int)
SetSectionHidden(i int, b bool)
IsSectionHidden(i int)(b bool)
Length()(i int)
LogicalIndex(i int)(j int)
MoveSection(i int, j int)
Offset()(i int)
Orientation()(o Orientation)
SetResizeContentsPrecision(i int)
ResizeContentsPrecision()(i int)
ResizeSection(i int, j int)
ResizeSections(h HeaderResizeMode)
SectionPosition(i int)(j int)
SetSectionResizeMode(h HeaderResizeMode)
SectionResizeMode(i int)(h HeaderResizeMode)
SectionSize(i int)(j int)
SectionSizeHint(i int)(j int)
SectionViewportPosition(i int)(j int)
SetSectionsClickable(b bool)
SectionsClickable()(b bool)
SectionsHidden()(b bool)
SetSectionsMovable(b bool)
SectionsMoved()(b bool)
StretchSectionCount()(i int)
SwapSections(i int, j int)
VisualIndex(i int)(j int)
VisualIndexAt(i int)(j int)

]]

qtdrv = {
inc = "<QHeaderView>",  
name = "QHeaderView *",

Init = [[
drvNewObj(a0,new QHeaderView(drvGetOrientation(a1)));
]],

SetCascadingSectionResizes = "setCascadingSectionResizes",
CascadingSectionResizes = "cascadingSectionResizes",
SetDefaultAlignment = "setDefaultAlignment",
DefaultAlignment = "defaultAlignment",
SetDefaultSectionSize = "setDefaultSectionSize",
DefaultSectionSize = "defaultSectionSize",
SetHighlightSections = "setHighlightSections",
HighlightSections = "highlightSections",
SetMaximumSectionSize = "setMaximumSectionSize",
MaximumSectionSize = "maximumSectionSize",
SetMinimumSectionSize = "setMinimumSectionSize",
MinimumSectionSize = "minimumSectionSize",
SetSortIndicatorShown = "setSortIndicatorShown",
IsSortIndicatorShown = "isSortIndicatorShown",
SetStretchLastSection = "setStretchLastSection",
StretchLastSection = "stretchLastSection",
Count = "count",
HiddenSectionCount = "hiddenSectionCount",
ShowSection = "showSection",
HideSection = "hideSection",
SetSectionHidden = "setSectionHidden",
IsSectionHidden = "isSectionHidden",
Length = "length",
LogicalIndex = "logicalIndex",
MoveSection = "moveSection",
Offset = "offset",
Orientation = "orientation",
SetResizeContentsPrecision = "setResizeContentsPrecision",
ResizeContentsPrecision = "resizeContentsPrecision",
ResizeSection = "resizeSection",
ResizeSections = "resizeSections",
SectionPosition = "sectionPosition",
SetSectionResizeMode = "setSectionResizeMode",
SectionResizeMode = "sectionResizeMode",
SectionSize = "sectionSize",
SectionSizeHint = "sectionSizeHint",
SectionViewportPosition = "sectionViewportPosition",
SetSectionsClickable = "setSectionsClickable",
SectionsClickable = "sectionsClickable",
SectionsHidden = "sectionsHidden",
SetSectionsMovable = "setSectionsMovable",
SectionsMoved = "sectionsMoved",
StretchSectionCount = "stretchSectionCount",
SwapSections = "swapSections",
VisualIndex = "visualIndex",
VisualIndexAt = "visualIndexAt",

}