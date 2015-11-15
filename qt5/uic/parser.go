package main

type Parser struct {
	DesignFile *UiFile
}

func (p *Parser) readUiFile(filename string) {
	uiFile, _ := extractUiFileData(filename)
	p.DesignFile = uiFile
}

func NewParser() *Parser {
	parser := &Parser{}
	return parser
}

func NewParserFromUiFile(filename string) *Parser {
	uiFile, _ := extractUiFileData(filename)
	parser := &Parser{uiFile}
	return parser
}
