module("lcdnumber")

name = "LCDNumber"
base = "Frame"

funcs = [[
+ Init()
+ InitWithDigits(digits int)
@ DigitCount() (digit int)
@ SetDigitCount(digit int)
@ SegmentStyle() (style int)
@ SetSegmentStyle(style int)
@ Value() (d float64)
@ IntValue() (value int)
@ SmallDecimalPoint() (b bool)
@ SetMode(m int)
@ Mode() (m int)
DisplayWithString(s string)
DisplayWithInt(n int)
DisplayWithFloat64(f float64)
SetHexMode()
SetDecMode()
SetOctMode()
SetBinMode()
SetSmallDecimalPoint(b bool)
* OnOverflow(fn func())
]]

qtdrv = {
inc = "<QLCDNumber>",
name = "QLCDNumber *",

Init = [[
drvNewObj(a0,new QLCDNumber);
]],

InitWithDigits = [[
drvNewObj(a0,new QLCDNumber(drvGetInt(a1)));
]],

DigitCount = "digitCount",
SetDigitCount = "setDigitCount",
SetSegmentStyle = [[
self->setSegmentStyle((QLCDNumber::SegmentStyle)drvGetInt(a1));
]],
SegmentStyle = [[
drvSetInt(a1, self->segmentStyle());
]],
Value = [[
drvSetFloat64(a1, self->value());
]],
IntValue = [[
drvSetInt(a1, self->intValue());
]],
SmallDecimalPoint = [[
drvSetBool(a1, self->smallDecimalPoint());
]],
SetMode = [[
self->setMode((QLCDNumber::Mode)drvGetInt(a1));
]],
Mode = [[
drvSetInt(a1, self->mode());
]],

DisplayWithString = [[
self->display(drvGetString(a1));
]],
DisplayWithInt = [[
self->display(drvGetInt(a1));
]],
DisplayWithFloat64 = [[
self->display(drvGetFloat64(a1));
]],

SetHexMode = "setHexMode",
SetDecMode = "setDecMode",
SetOctMode = "setOctMode",
SetBinMode = "setBinMode",
SetSmallDecimalPoint = [[
self->setSmallDecimalPoint(drvGetBool(a1));
]],

OnOverflow = [[
QObject::connect(self,SIGNAL(overflow()),drvNewSignal(self,a1,a2),SLOT(call()));
]],
}
