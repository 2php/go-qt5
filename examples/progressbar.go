package main

import (
    "github.com/salviati/go-qt5/qt5"
)

func main() {
    qt5.Main(func() {
        p := qt5.NewProgressBar()
        p.SetWindowTitle("ProgressBar")
        //p.SetOrientation(qt5.Vertical)
        p.SetRange(0, 100)
        p.SetValue(50)
        p.SetFormat("%v/%m")
        p.SetGeometryv(30, 40, 200, 25)
        //p.SetTextVisible(false)
        //p.SetSizev(300, 200)
        defer p.Close()
        p.Show()
        qt5.Run()
    })
}
