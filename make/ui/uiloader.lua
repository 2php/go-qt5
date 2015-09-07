module("uiloader")

name = "UILoader"
base = "object"

funcs = [[
+ Init()
- Close()
AddPluginPath(path string)
PluginPaths()(paths []string)
ClearPluginPaths()
AvailableLayouts()(layouts []string)
AvailableWidgets()(widgets []string)
CreateAction()(a *Action)
CreateLayout(className string)(layout ILayout)
CreateWidget(className string)(widget IWidget)
ErrorString()(error string)
IsLanguageChangeEnabled()(b bool)
SetLanguageChangeEnabled(b bool)
Load(i *IODevice)(widget IWidget)

]]

qtdrv = {
inc = "<QUiLoader>",
name = "QUiLoader *",

Init = [[
drvNewObj(a0,new QUiLoader());
]],
Close = [[
drvDelObj(a0,self);
]],

AddPluginPath = "addPluginPath",
PluginPaths = "pluginPaths",
ClearPluginPaths = "clearPluginPaths",
AvailableLayouts = "availableLayouts",
AvailableWidgets = "availableWidgets",
CreateAction = "createAction",
CreateWidget = "createWidget",
ErrorString = "errorString",
IsLanguageChangeEnabled = "isLanguageChangeEnabled",
SetLanguageChangeEnabled = "setLanguageChangeEnabled",
Load = "load",

}