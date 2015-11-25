package main

import (
	"fmt"
	"testing"
)

func TestBasicUiFileExtraction(t *testing.T) {
	filename := "resources/basiclayout.ui"

	uiData, err := extractUiFileData(filename)

	// Make sure the file was parse successfully
	if err != nil {
		fmt.Println("Error Parsing the file")
		t.FailNow()
	}

	// Check the data
	if uiData.Version != "4.0" {
		t.FailNow()
	}
}
