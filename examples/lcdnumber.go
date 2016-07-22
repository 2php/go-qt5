package main

import (
    "github.com/salviati/go-qt5/qt5"
)

func main() {
    qt5.Main(func() {
        lcd := qt5.NewLCDNumber()
        lcd.SetWindowTitle("LCDNumber")
        lcd.SetSizev(200, 50)
        lcd.SetSegmentStyle(1)
        lcd.DisplayWithString("2016")
        defer lcd.Close()
        lcd.Show()
        qt5.Run()
    })
}
