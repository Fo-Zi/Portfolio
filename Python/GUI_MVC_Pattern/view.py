import sys
from xml.etree.ElementTree import tostring
from PyQt5 import QtCore,QtGui
from PyQt5.QtWidgets import QMainWindow,QTableWidget,QTableWidgetItem,QHBoxLayout,QVBoxLayout,QWidget, QLabel,QGridLayout,QGroupBox


class View(QMainWindow):

    def __init__(self,controller):
        super(View,self).__init__()
        self._controller = controller
        self.initUi()
       
    def initUi(self):
        self.setWindowTitle("Currency App")
        self.setFixedSize(1200,900)
        
        exchangeRate = self._controller.getData('latest')
        table = TableView(exchangeRate)
        
        gboxT = QGroupBox("Currency exchange rates")
        gbox2 = QGroupBox("Time-series rates display")
        gbox3 = QGroupBox("Fluctuation time-series")
        gbox4 = QGroupBox("Historical rates")

        gboxT.setFont(QtGui.QFont("Calibri",14))
        gbox2.setFont(QtGui.QFont("Calibri",14))
        gbox3.setFont(QtGui.QFont("Calibri",14))
        gbox4.setFont(QtGui.QFont("Calibri",14)) 
        
        # The grid is where the data from the API will be displayed
        vbox = QVBoxLayout()
        vbox.addSpacing(10)
        vbox.addWidget(table)
        gboxT.setLayout(vbox)
        gboxT.setFont(QtGui.QFont("Calibri",14))
        gboxT.setFixedSize(300,500)
        
        grid = QGridLayout()
        grid.addWidget(gboxT,0,0)
        grid.addWidget(gbox2,0,1)
        grid.addWidget(gbox3,1,0)
        grid.addWidget(gbox4,1,1)
        gridWidget = QWidget()
        gridWidget.setLayout(grid)

        # Just for display purposes, we have an upper box to display time and other data
        # and below that we have the grid
        vboxMain = QVBoxLayout()
        hboxMain = QHBoxLayout()
        
        clockWidget = self._controller.getClockObj()
        font = QtGui.QFont('Calibri',18,QtGui.QFont.Bold)
        clockWidget.setFont(font)

        hboxMain.addStretch()
        hboxMain.addWidget(clockWidget)
        hBoxWidget = QWidget()
        hBoxWidget.setLayout(hboxMain)
        
        vboxMain.addWidget(hBoxWidget)
        vboxMain.addWidget(gridWidget)

        # As we can't change the main window Layout, we can only set its central Widget: 
        centralWidg = QWidget()
        centralWidg.setLayout(vboxMain)
        self.setCentralWidget(centralWidg)
        
        self.show()
        

class TableView(QTableWidget):
    def __init__(self,data):
        super().__init__()
        self._data = data 
        self.setRowCount(len(data))
        self.setColumnCount(2)
        self.loadData()
        self.setFont(QtGui.QFont('Arial',14))
        self.resizeColumnsToContents()
        self.resizeRowsToContents() 

    def loadData(self):
        self.setHorizontalHeaderLabels(['Currency','Rate[EUR]'])
        for i,(key,value) in enumerate(self._data.items()):
            self.setItem(i,0, QTableWidgetItem(key))
            self.setItem(i,1, QTableWidgetItem(str(value)))

    def refreshData(self,data):
        self._data = data
        self.loadData()
