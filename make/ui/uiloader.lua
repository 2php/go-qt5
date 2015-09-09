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
ErrorString()(error string)
IsLanguageChangeEnabled()(b bool)
SetLanguageChangeEnabled(b bool)
Load(i *File)(widget *Widget)

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
ErrorString = "errorString",
IsLanguageChangeEnabled = "isLanguageChangeEnabled",
SetLanguageChangeEnabled = "setLanguageChangeEnabled",
Load = "load",

}