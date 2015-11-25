package main

import (
	"flag"
	"fmt"
	"io/ioutil"
)

func main() {
	// Set up the command line options
	outfile := flag.String("outfile", "", "Write the golang output to a file")
	flag.Parse()

	// Parse the input files
	if flag.NArg() == 0 {
		fmt.Println("No .ui file specified")
		return
	}
	infile := flag.Args()[0]
	parser := NewParserFromUiFile(infile)
	compiledOutput, _ := parser.CompileUiGoObject()

	// Write to a file if specified
	if len(*outfile) > 0 {
		// Print to a file
		byteData := []byte(compiledOutput)
		writeErr := ioutil.WriteFile(*outfile, byteData, 0644)
		if writeErr != nil {
			fmt.Printf("Error Writing ui to file: %s\n", writeErr.Error())
		} else {
			fmt.Printf("Succesfully wrote go ui object to %s\n", *outfile)
		}
		return
	}

	// Otherwise print to stdin
	fmt.Print(compiledOutput)
}
