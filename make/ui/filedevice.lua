module("filedevice")

name = "FileDevice"
base = "FileDevice"

funcs = [[

FileName()(name string)
Flush()(b bool)
Handle()(i int)
UnsetError()
Permissions()(p FileDevicePermissions)
SetPermissions(p FileDevicePermissions)(b bool)

]]

qtdrv = {
inc = "<QFileDevice>",
name = "QFileDevice *",

FileName = "fileName",
Flush = "flush",
Handle = "handle",
UnsetError = "unsetError",
Permissions = "permissions",
SetPermissions = "setPermissions",

}