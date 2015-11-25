package main

import (
	"testing"
)

func TestBasicUiFileParse(t *testing.T) {
	filename := "resources/basiclayout.ui"

	// Create the parser
	parser := NewParserFromUiFile(filename)

	// Read the data and hope for no errors!
	err := parser.CompileUiGoObject()
	if err != nil {
		t.Fail()
	}
}
