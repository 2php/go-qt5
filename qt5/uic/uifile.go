package main

import (
	"encoding/xml"
	"io/ioutil"
	"os"
)

type UiProperty struct {
	XMLName    xml.Name `xml:"property"`
	Name       string   `xml:"name,attr"`
	StringData string   `xml:"string"`
	DoubleData float64  `xml:"double"`
	IntData    int      `xml:"number"`
}

type UiWidget struct {
	XMLName    xml.Name     `xml:"widget"`
	Name       string       `xml:"name,attr"`
	Class      string       `xml:"class,attr"`
	Layout     UiLayout     `xml:"layout"`
	Properties []UiProperty `xml:"property"`
}

type UiLayout struct {
	XMLName    xml.Name     `xml:"layout"`
	Name       string       `xml:"name,attr"`
	Class      string       `xml:"class,attr"`
	Items      []UiItem     `xml:"item"`
	Properties []UiProperty `xml:"property"`
}

type UiItem struct {
	XMLName xml.Name `xml:"item"`
	Widget  UiWidget `xml:"widget"`
	Layout  UiLayout `xml:"layout"`
}

type UiResources struct {
	XMLName xml.Name `xml:"resources"`

	// TODO: Actual things that are resources
}

type UiConnections struct {
	XMLName xml.Name `xml:"connections"`

	// TODO: Actual things that are connections
}

type UiFile struct {
	XMLName     xml.Name        `xml:"ui"`
	Version     string          `xml:"version,attr"`
	Class       string          `xml:"class"`
	Widget      UiWidget        `xml:"widget"`
	Resources   []UiResources   `xml:"resources"`
	Connections []UiConnections `xml:"connections"`
}

func extractUiFileData(filename string) (*UiFile, error) {
	xmlFile, err := os.Open(filename)
	if err != nil {
		return nil, err
	}
	defer xmlFile.Close()

	XMLdata, _ := ioutil.ReadAll(xmlFile)

	var uiData *UiFile
	xml.Unmarshal(XMLdata, &uiData)
	return uiData, nil
}

func writeUiFileData(filename string, uiData *UiFile) error {

	// TODO: Not important

	return nil
}
