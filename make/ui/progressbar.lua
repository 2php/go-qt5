module("progressbar")

name = "ProgressBar"
base = "Widget"

funcs = [[
+ Init()

@ Alignment() (align int)
@ SetOrientation (value Orientation)
@ Orientation() (value Orientation)
@ Format() (s string)
@ Text() (s string)
@ InvertedAppearance() (b bool)
@ Maximum() (value int)
@ Minimum() (value int)
@ SetValue(value int)
@ Value() (value int)

SetTextVisible(b bool)
IsTextVisible() (b bool)
SetFormat(s string)
ResetFormat()
SetAlignment(align int)
SetInvertedAppearance(b bool)
SetRange(min int, max int)
Range() (min int, max int)

* OnValueChanged(fn func(int))
]]

qtdrv = {
inc = "<QProgressBar>",
name = "QProgressBar*",

Init = [[
drvNewObj(a0, new QProgressBar());
]],

Alignment = "alignment",
SetOrientation = [[
switch (drvGetInt(a1)) {
	case Qt::Horizontal: {
		self->setOrientation(Qt::Horizontal);
		break;		
	}
	case Qt::Vertical: {
		self->setOrientation(Qt::Vertical);
		break;
	}
}
]],
Orientation = [[
switch((int)self->orientation()) {
	case Qt::Horizontal: {
		drvSetInt(a1,Qt::Horizontal);
		break;
	}
	case Qt::Vertical: {
		drvSetInt(a1,Qt::Vertical);
		break;
	}
}
]],
Format = "format",
Text = "text",
InvertedAppearance = "invertedAppearance",
Maximum = "maximum",
Minmum = "minmum",
Value = "value",
SetValue = "setValue",

IsTextVisible = "isTextVisible",
ResetFormat = "resetFormat",
SetAlignment = [[
self->setAlignment((Qt::Alignment)drvGetInt(a1));
]],
SetFormat = [[
self->setFormat(drvGetString(a1));
]],
SetInvertedAppearance = "setInvertedAppearance",
--SetTextDirection = [[
--self->setTextDirection((QProgressBar::Direction)drvGetInt(a1));
--]],
--TextDirection = [[
--drvSetInt(a1,self->textDirection());
--]],

SetTextVisible = [[
self->setTextVisible(drvGetBool(a1));
]],
SetRange = "setRange",
Range = [[
drvSetInt(a1,self->minimum());
drvSetInt(a2,self->maximum());
]],

SetValue = "setValue",
Value = [[
drvSetInt(a1, self->value());
]],

OnValueChanged = [[
QObject::connect(self,SIGNAL(valueChanged(int)),drvNewSignal(self,a1),SLOT(call(int)));
]],

}
