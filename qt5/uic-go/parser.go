package main

import (
	"errors"
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
	p.widgetChildren += "}\n"

	// TODO: Create the ui setup function

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

func (p *Parser) getGoClassName(qtClassName string) string {
	if len(qtClassName) < 1 {
		return ""
	}
	return "*qt5." + upperFirst(qtClassName[1:len(qtClassName)])
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
