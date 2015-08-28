module("mediaplaylist")

name = "MediaPlaylist"
base = "object"

funcs = [[
+ Init()
- Close()
@ CurrentIndex()(i int)
@ SetCurrentIndex(position int)
@ PlaybackMode()(mode MediaPlaylistPlaybackMode)
@ SetPlaybackMode(mode MediaPlaylistPlaybackMode)
Clear()(b bool)
Error()(error MediaPlaylistError)
ErrorString()(s string)
IsEmpty()(b bool)
IsReadOnly()(b bool)
MediaCount()(i int)
NextIndex(steps int)(index int)
PreviousIndex(steps int)(index int)
RemoveMedia(pos int)(b bool)
Next()
Previous()
Shuffle()

* OnCurrentIndexChanged(fn func(int))
* OnLoadFailed(fn func())
* OnLoaded(fn func())
* OnMediaAboutToBeInserted(fn func(int,int))
* OnMediaAboutToBeRemoved(fn func(int,int))
* OnMediaChanged(fn func(int,int))
* OnMediaInserted(fn func(int,int))
* OnMediaRemoved(fn func(int,int))
]]

qtdrv = {
inc = "<QMediaPlaylist>",
name = "QMediaPlaylist*",

Init = [[
drvNewObj(a0,new QMediaPlaylist());
]],

Close = [[
drvDelObj(a0,self);
]],

CurrentIndex = "currentIndex",
SetCurrentIndex = "setCurrentIndex",
PlaybackMode = "playbackMode",
SetPlaybackMode = "setPlaybackMode",
Clear = "clear",
Error = "error",
ErrorString = "errorString",
IsEmpty = "isEmpty",
IsReadOnly = "isReadOnly",
MediaCount = "mediaCount",
NextIndex = "nextIndex",
PreviousIndex = "previousIndex",
RemoveMedia = "removeMedia",
Next = "next",
Previous = "previous",
Shuffle = "shuffle",

OnCurrentIndexChanged = [[
QObject::connect(self,SIGNAL(currentIndexChanged(int)),drvNewSignal(self,a1,a2),SLOT(call(int)));
]],
OnLoadFailed = [[
QObject::connect(self,SIGNAL(loadFailed()),drvNewSignal(self,a1,a2),SLOT(call()));
]],
OnLoaded = [[
QObject::connect(self,SIGNAL(loaded()),drvNewSignal(self,a1,a2),SLOT(call()));
]],
OnMediaAboutToBeInserted = [[
QObject::connect(self,SIGNAL(mediaAboutToBeInserted(int, int)),drvNewSignal(self,a1,a2),SLOT(call(int, int)));
]],
OnMediaAboutToBeRemoved = [[
QObject::connect(self,SIGNAL(mediaAboutToBeRemoved(int, int)),drvNewSignal(self,a1,a2),SLOT(call(int, int)));
]],
OnMediaChanged = [[
QObject::connect(self,SIGNAL(mediaChanged(int, int)),drvNewSignal(self,a1,a2),SLOT(call(int, int)));
]],
OnMediaInserted = [[
QObject::connect(self,SIGNAL(mediaInserted(int, int)),drvNewSignal(self,a1,a2),SLOT(call(int, int)));
]],
OnMediaRemoved = [[
QObject::connect(self,SIGNAL(mediaRemoved(int, int)),drvNewSignal(self,a1,a2),SLOT(call(int, int)));
]],


}