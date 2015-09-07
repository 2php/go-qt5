module("filedevice")

name = "FileDevice"
base = "IODevice"

funcs = [[

FileName()(name string)
Flush()(b bool)
Handle()(i int)
UnsetError()
Permissions()(f FileDevicePermissions)
SetPermissions(f FileDevicePermissions)(b bool)

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