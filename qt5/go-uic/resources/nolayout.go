// Form generated through the github.com/salviati/go-qt5/qt5/uic compiler for qt ui files to golang.
// Uses the go-qt5 package as its qt5 bindings. 
// Changes to this file will be overwritten if the compiler is ran again.

package ui

import "github.com/mpiannucci/go-qt5/qt5"

type Form struct {
PushButton *qt5.Button
CheckBox *qt5.CheckBox
}

func (w *Form) SetupUI(parent *qt5.Widget) {
parent.SetGeometry(qt5.Rect{0, 0, 400, 300})
parent.SetWindowTitle("Form")
w.PushButton.SetGeometry(qt5.Rect{50, 240, 113, 32})
w.PushButton.SetText("PushButton")
w.CheckBox.SetGeometry(qt5.Rect{200, 160, 86, 20})
w.CheckBox.SetText("CheckBox")
}
