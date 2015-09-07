module("file")

name = "File"
base = "FileDevice"

funcs = [[
+ InitWithFilename(s string)

Copy(s string)(b bool)
Exists()(b bool)
Link(s string)(b bool)
Remove()(b bool)
Rename(s string)(b bool)
SetFileName(s string)
SymLinkTarget()(s string)

]]

qtdrv = {
inc = "<QFile>",
name = "QFile *",

InitWithFilename = [[
drvNewObj(a0, new QFile(drvGetString(a1)));
]],

Copy = "copy",
Exists = "exists",
Link = "link",
Remove = "remove",
Rename = "rename",
SetFileName = "setFileName",
SymLinkTarget = "symLinkTarget",

}