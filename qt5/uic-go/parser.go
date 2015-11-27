package main

import (
	"errors"
	"fmt"
	"strconv"
	"strings"
)

type Parser struct {
	DesignFile     *UiFile
	widgetChildren string
}

func (p *Parser) ReadUiFile(filename string) {
	uiFile, _ := extractUiFileData(filename)
	p.DesignFile = uiFile
}

func (p *Parser) CompileUiGoObject() (string, error) {
	if p.DesignFile == nil {
		return "", errors.New("You must read in a .ui file first!")
	}

	// Define constants for writing the file
	const header = `// Form generated through the github.com/salviati/go-qt5/qt5/uic compiler for qt ui files to golang.
// Uses the go-qt5 package as its qt5 bindings. 
// Changes to this file will be overwritten if the compiler is ran again.

package ui

import "github.com/mpiannucci/go-qt5/qt5"

`
	// Reset the widget children string
	p.widgetChildren = ""

	// Loop through and find all of the children layouts and widgets
	p.readWidgetNames(p.DesignFile.Widget)
	p.widgetChildren += "}\n\n"

	// Create the ui setup function
	p.widgetChildren += "func (w *" + p.DesignFile.Class + ") SetupUI(parent "
	p.widgetChildren += p.getGoClassName(p.DesignFile.Widget.Class) + ") {\n"

	// TODO: Loop through the items in the file and get their props and such
	p.readBaseWidgetSetup(p.DesignFile.Widget)
	p.widgetChildren += "}\n"

	return header + p.widgetChildren, nil
}

func (p *Parser) readWidgetNames(widget UiWidget) {
	if len(widget.Name) == 0 {
		return
	}

	if p.widgetChildren == "" {
		p.widgetChildren += "type " + upperFirst(widget.Name) + " struct {\n"
	} else {
		p.widgetChildren += upperFirst(widget.Name) + " " + p.getGoClassName(widget.Class) + "\n"
	}

	if len(widget.Layout.Name) > 0 {
		p.readLayoutNames(widget.Layout)
	} else if widget.Widgets != nil {
		for _, item := range widget.Widgets {
			p.readWidgetNames(item)
		}
	}
}

func (p *Parser) readLayoutNames(layout UiLayout) {
	if len(layout.Name) == 0 {
		return
	}

	p.widgetChildren += upperFirst(layout.Name) + " " + p.getGoClassName(layout.Class) + "\n"
	if layout.Items != nil {
		for _, item := range layout.Items {
			p.readWidgetNames(item.Widget)
			p.readLayoutNames(item.Layout)
		}
	}
}

func (p *Parser) readBaseWidgetSetup(widget UiWidget) {
	for _, property := range widget.Properties {
		p.widgetChildren += "parent." + p.getGoFunctionForProperty(property) + "\n"
	}

	if len(widget.Layout.Name) > 0 {
		p.readLayoutProperties(widget.Layout)
		p.widgetChildren += "parent.SetLayout(w." + upperFirst(widget.Layout.Name) + ")\n"
	}

	if widget.Widgets != nil {
		for _, item := range widget.Widgets {
			p.readWidgetProperties(item)
		}
	}
}

func (p *Parser) readWidgetProperties(widget UiWidget) {
	if len(widget.Name) == 0 {
		return
	}

	for _, property := range widget.Properties {
		p.widgetChildren += "w." + upperFirst(widget.Name) + "." + p.getGoFunctionForProperty(property) + "\n"
	}

	if len(widget.Layout.Name) > 0 {
		p.readLayoutProperties(widget.Layout)
		p.widgetChildren += "w." + upperFirst(widget.Name) + ".SetLayout(w." + upperFirst(widget.Layout.Name) + ")\n"
	} else if widget.Widgets != nil {
		for _, item := range widget.Widgets {
			p.readWidgetProperties(item)
		}
	}
}

func (p *Parser) readLayoutProperties(layout UiLayout) {
	if len(layout.Name) == 0 {
		return
	}

	marginCache := ""
	for index, property := range layout.Properties {
		marginFlag := false
		if strings.Contains(property.Name, "Margin") {
			marginCache += p.getGoFunctionForProperty(property) + ","

			if index != len(layout.Properties)-1 {
				continue
			} else {
				marginFlag = true
			}
		}

		if len(marginCache) > 0 {
			fmt.Println("here")
			// TODO: Write the full margin function call
			marginVals := [4]int{-1, -1, -1, -1}
			margins := strings.Split(marginCache, ",")
			for _, margin := range margins {
				index := 0
				if strings.Contains(margin, "Left") {
					index = 0
				} else if strings.Contains(margin, "Top") {
					index = 1
				} else if strings.Contains(margin, "Right") {
					index = 2
				} else if strings.Contains(margin, "Bottom") {
					index = 3
				} else {
					continue
				}
				rawFirstSplit := strings.Split(margin, "(")
				rawSecondSplit := strings.Split(rawFirstSplit[1], ")")
				marginVals[index], _ = strconv.Atoi(rawSecondSplit[0])
			}
			functionName := fmt.Sprintf("SetMarginsv(%d, %d, %d, %d)", marginVals[0], marginVals[1], marginVals[2], marginVals[3])
			p.widgetChildren += "w." + upperFirst(layout.Name) + "." + functionName + "\n"
			marginCache = ""
		}

		if marginFlag {
			continue
		}

		p.widgetChildren += "w." + upperFirst(layout.Name) + "." + p.getGoFunctionForProperty(property) + "\n"
	}

	if layout.Items != nil {
		for _, item := range layout.Items {
			p.readWidgetProperties(item.Widget)
			p.widgetChildren += "w." + upperFirst(layout.Name) + ".AddWidget(w." + upperFirst(item.Widget.Name) + ")\n"
			p.readLayoutProperties(item.Layout)
		}
	}
}

func (p *Parser) getGoClassName(qtClassName string) string {
	if len(qtClassName) < 1 {
		return ""
	}

	// Special case handling cuz a some of the class names are not the same
	switch qtClassName {
	case "QPushButton":
		qtClassName = "Button"
	default:
		qtClassName = qtClassName[1:len(qtClassName)]
	}

	return "*qt5." + upperFirst(qtClassName)
}

func (p *Parser) getGoFunctionForProperty(property UiProperty) string {
	// TODO: Parse input and return the correct function stub to set up the property
	rawChildren := property.Children
	arg := ""
	if strings.Contains(rawChildren, "string") {
		arg = "\"" + property.StringData + "\""
	} else if strings.Contains(rawChildren, "double") {
		arg = fmt.Sprintf("%f", property.DoubleData)
	} else if strings.Contains(rawChildren, "number") {
		arg = fmt.Sprintf("%d", property.IntData)
	} else if strings.Contains(rawChildren, "bool") {
		if property.BoolData {
			arg = "true"
		} else {
			arg = "false"
		}
	} else if strings.Contains(rawChildren, "rect") {
		arg = fmt.Sprintf("qt5.Rect{%d, %d, %d, %d}", property.RectData.X, property.RectData.Y, property.RectData.Width, property.RectData.Height)
	} else if strings.Contains(rawChildren, "sizepolicy") {
		// TODO
	} else if strings.Contains(rawChildren, "size") {
		arg = fmt.Sprintf("qt5.Size{%d, %d}", property.SizeData.Width, property.SizeData.Height)
	}

	return "Set" + upperFirst(property.Name) + "(" + arg + ")"
}

func NewParser() *Parser {
	parser := &Parser{}
	return parser
}

func NewParserFromUiFile(filename string) *Parser {
	uiFile, _ := extractUiFileData(filename)
	parser := &Parser{uiFile, ""}
	return parser
}
