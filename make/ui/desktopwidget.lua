module("desktopwidget")

name = "DesktopWidget"
base = "Widget"

funcs = [[
+ Init()

@ PrimaryScreen() (value int)

AvailableGeometry(widget IWidget) (rc Rect)
IsVirtualDesktop() (b bool)
Screen(i int) (widget IWidget)
ScreenCount() (count int)
ScreenGeometry(widget IWidget) (rc Rect)

* OnPrimaryScreenChanged(fn func())
* OnResized(fn func(int))
* OnScreeenCountChanged(fn func(int))
* OnWorkAreaResized(fn func(int))
]]


qtdrv = {
inc = "<QDesktopWidget>",
name = "QDesktopWidget *",

Init = [[
drvNewObj(a0,new QDesktopWidget);
]],

PrimaryScreen = "primaryScreen",
AvailableGeometry= [[
self->availableGeometry((QWidget*)drvGetNative(a1));
]],
IsVirtualDesktop = "isVirtualDesktop",
Screen = "screen",
ScreenCount = "screenCount",
ScreenGeometry = [[
self->screenGeometry((QWidget*)drvGetNative(a1));
]],
--ScreenNumber = [[
--self->screenNumber((QPoint*)drvGetNative(a1));
--]],

OnPrimaryScreenChanged = [[
QObject::connect(self,SIGNAL(primaryScreenChanged()),drvNewSignal(self,a1,a2),SLOT(call()));
]],

OnResized = [[
QObject::connect(self,SIGNAL(resized(int)),drvNewSignal(self,a1,a2),SLOT(call(int)));
]],

OnScreeenCountChanged = [[
QObject::connect(self,SIGNAL(screeenCountChanged(int)),drvNewSignal(self,a1,a2),SLOT(call(int)));
]],

OnWorkAreaResized = [[
QObject::connect(self,SIGNAL(workAreaResized(int)),drvNewSignal(self,a1,a2),SLOT(call(int)));
]],

}


