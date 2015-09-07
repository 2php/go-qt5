package main

import (
	"fmt"
	"github.com/mpiannucci/go-qt5/qt5"
)

var exit = make(chan bool)

func main() {
	qt5.Main(func() {
		go ui_main()
		qt5.Run()
		exit <- true
	})
}

func ui_main() {
	w := loadUIFile("layouts/testwidget.ui")

	w.SetWindowTitle(qt5.Version())
	w.SetSizev(300, 200)
	defer w.Close()
	w.Show()
	<-exit
}

func loadUIFile(designFile string) *qt5.Widget {
	file := qt5.NewFileWithFilename(designFile)
	file.Open(qt5.OpenModeReadOnly)
	uiLoader := qt5.NewUILoader()
	layouts := uiLoader.AvailableLayouts()
	fmt.Println("\nTesting Go array")
	for index := range layouts {
		fmt.Println(layouts[index])
	}
	fmt.Println("\n")
	return uiLoader.Load(file)
}
