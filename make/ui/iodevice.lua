module("iodevice")

name = "IODevice"
base = "object"

funcs = [[

AtEnd()(b bool)
BytesAvailable()(i int)
BytesToWrite()(i int)
CanReadLine()(b bool)
CloseDevice()
ErrorString()(error string)
IsOpen()(b bool)
IsReadable()(b bool)
IsSequential()(b bool)
IsTextModeEnabled()(b bool)
IsWritable()(b bool)
Open(mode IODeviceOpenMode)(b bool)
OpenMode()(mode IODeviceOpenMode)
Pos()(i int)
Read(i int)(b []byte)
ReadAll()(b []byte)
ReadLine()(b []byte)
Reset()(b bool)
Seek(i int)(b bool)
WaitForBytesWritten(i int)(b bool)
WaitForReadyRead(i int)(b bool)
Write(b []byte)(i int)

* OnAboutToClose(fn func())
* OnBytesWritten(fn func(int))
* OnReadChannelFinished(fn func())
* OnReadyRead(fn func())

]]

qtdrv = {
inc = "<QIODevice>",
name = "QIODevice *",

AtEnd = "atEnd",
BytesAvailable = "bytesAvailable",
BytesToWrite = "bytesToWrite",
CanReadLine = "canReadLine",
CloseDevice = "close",
ErrorString = "errorString",
IsOpen = "isOpen",
IsReadable = "isReadable",
IsSequential = "isSequential",
IsTextModeEnabled = "isTextModeEnabled",
IsWritable = "isWritable",
Open = "open",
OpenMode = "openMode",
Pos = "pos",
Read = "read",
ReadAll = "readAll",
ReadLine = "readLine",
Reset = "reset",
Seek = "seek",
WaitForBytesWritten = "waitForBytesWritten",
WaitForBytesReadyRead = "waitForReadyRead",
Write = "write",

OnAboutToClose = [[
QObject::connect(self,SIGNAL(aboutToClose()),drvNewSignal(self,a1,a2),SLOT(call()));
]],
OnBytesWritten = [[
QObject::connect(self,SIGNAL(bytesWritten(int)),drvNewSignal(self,a1,a2),SLOT(call(int)));
]],
OnReadChannelFinished = [[
QObject::connect(self,SIGNAL(readChannelFinished()),drvNewSignal(self,a1,a2),SLOT(call()));
]],
OnReadyRead = [[
QObject::connect(self,SIGNAL(readyRead()),drvNewSignal(self,a1,a2),SLOT(call()));
]]

}