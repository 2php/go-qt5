module("mediaobject")

name = "MediaObject"
base = "object"

funcs = [[

@ NotifyInterval()(interval int)
@ SetNotifyInterval(interval int)
Availability()(status MediaAvailabilityStatus)
IsAvailable()(b bool)
AvailableMetaData()(data []string)
IsMetaDataAvailable()(b bool)

* OnAvailabilityChanged(fn func(bool))
* OnMetaDataAvailabilityChanged(fn func(bool))
* OnMetaDataChanged(fn func())
* OnNotifyIntervalChanged(fn func(int))

]]

qtdrv = {
inc = "<QMediaObject>",
name = "QMediaObject*",

Availability = "availability",
IsAvailable = "isAvailable",
NotifyInterval = "notifyInterval",
SetNotifyInterval = "setNotifyInterval",
AvailableMetaData = "availableMetaData",
IsMetaDataAvailable = "isMetaDataAvailable",

OnAvailabilityChanged = [[
QObject::connect(self,SIGNAL(availabilityChanged(bool)),drvNewSignal(self,a1,a2),SLOT(call(bool)));
]],
OnMetaDataChanged = [[
QObject::connect(self,SIGNAL(metaDataChanged()),drvNewSignal(self,a1,a2),SLOT(call()));
]],
OnMetaDataAvailabilityChanged = [[
QObject::connect(self,SIGNAL(metaDataAvailableChanged(bool)),drvNewSignal(self,a1,a2),SLOT(call(bool)));
]],
OnNotifyIntervalChanged = [[
QObject::connect(self,SIGNAL(notifyIntervalChanged(int)),drvNewSignal(self,a1,a2),SLOT(call(int)));
]],

}