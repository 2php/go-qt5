cd make/
lua make.lua
lua makelib.lua
cd ../goqtdrv5
qmake "CONFIG+=release"
make -j4
sudo make install
cd ../qt5
go install