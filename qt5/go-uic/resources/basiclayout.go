// Form generated through the github.com/salviati/go-qt5/qt5/uic compiler for qt ui files to golang.
// Uses the go-qt5 package as its qt5 bindings. 
// Changes to this file will be overwritten if the compiler is ran again.

package main

import "github.com/mpiannucci/go-qt5/qt5"

type Form struct {
VerticalLayout *qt5.VBoxLayout
TitleLabel *qt5.Label
ButtonExample *qt5.Button
CheckBoxButton *qt5.CheckBox
NumberEdit *qt5.DoubleSpinBox
IntSpinBox *qt5.SpinBox
}

func (w *Form) SetupUI(parent qt5.IWidget) {
parent.SetGeometry(qt5.Rect{0, 0, 624, 514})
parent.SetSizePolicy(qt5.NewSizePolicyWithPolicy(qt5.Expanding, qt5.Expanding, qt5.ControlTypeDefaultType))
parent.SetMinimumSize(qt5.Size{10, 10})
parent.SetWindowTitle("Form")
w.VerticalLayout = qt5.NewVBoxLayout()
w.VerticalLayout.SetMarginsv(15, 15, 15, 15)
w.TitleLabel = qt5.NewLabel()
w.TitleLabel.SetText("This is our test widget")
w.VerticalLayout.AddWidget(w.TitleLabel)
w.ButtonExample = qt5.NewButton()
w.ButtonExample.SetText("Push Me!")
w.VerticalLayout.AddWidget(w.ButtonExample)
w.CheckBoxButton = qt5.NewCheckBox()
w.CheckBoxButton.SetText("Is this working?")
w.CheckBoxButton.SetChecked(true)
w.VerticalLayout.AddWidget(w.CheckBoxButton)
w.NumberEdit = qt5.NewDoubleSpinBox()
w.NumberEdit.SetValue(15.000000)
w.VerticalLayout.AddWidget(w.NumberEdit)
w.IntSpinBox = qt5.NewSpinBox()
w.IntSpinBox.SetValue(2)
w.VerticalLayout.AddWidget(w.IntSpinBox)
parent.SetLayout(w.VerticalLayout)
}
