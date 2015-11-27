package main

import (
	"fmt"
	"testing"
)

func TestBasicUiFileParse(t *testing.T) {
	filename := "resources/basiclayout.ui"

	// Create the parser
	parser := NewParserFromUiFile(filename)

	// Read the data and hope for no errors!
	goFile, err := parser.CompileUiGoObject()
	if err != nil {
		t.Fail()
	}

	fmt.Println(goFile)
}
