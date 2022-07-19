import sys
from xml.etree.ElementTree import tostring
from PyQt5 import QtGui
from PyQt5.QtCore import QDateTime,QDate
from PyQt5.QtWidgets import QMainWindow,QTableWidget,QTableWidgetItem,QHBoxLayout,QVBoxLayout,QWidget, QLabel,QGridLayout,QGroupBox,QDateEdit,QPushButton,QSizePolicy
from datetime import datetime

class View(QMainWindow):

    def __init__(self,controller):
        super(View,self).__init__()
        self._controller = controller
        self.initUi()
       
    def initUi(self):
        self.setWindowTitle("Currency App")
        self.setFixedSize(1200,900)
    
        # Group boxes to display the data obtained from the API
        gboxExRates = QGroupBox("Currency exchange rates")
        gboxExRatesimeSeries = QGroupBox("Time-series rates display")
        gboxFluctuation = QGroupBox("Fluctuation time-series")
        gboxHistorical = QGroupBox("Historical rates")

        gboxExRates.setFont(QtGui.QFont("Calibri",14))
        gboxExRatesimeSeries.setFont(QtGui.QFont("Calibri",14))
        gboxFluctuation.setFont(QtGui.QFont("Calibri",14))
        gboxHistorical.setFont(QtGui.QFont("Calibri",14)) 
        
        # Setting up table with exchange rates
        exchangeRate = self._controller.getData('latest')
        table = TableView(exchangeRate)
        vbox = QVBoxLayout()
        vbox.addSpacing(10)
        vbox.addWidget(table)
        gboxExRates.setLayout(vbox)
        gboxExRates.setFixedSize(300,500)

        # Setting up date picker menu
        pickerfont = QtGui.QFont('Calibri',14)
        
        self.fromDatePicker = QDateEdit(self)
        self.fromDatePicker.setFixedHeight(40)
        self.fromDatePicker.setFixedWidth(500)
        self.fromDatePicker.setFont(pickerfont)
        self.fromDatePicker.setDate(QDate(2020,10,10))
        self.toDatePicker = QDateEdit(self)
        self.toDatePicker.setFixedHeight(40)
        self.toDatePicker.setFixedWidth(500)
        self.toDatePicker.setFont(pickerfont)
        self.toDatePicker.setDate(QDate(2020,10,10))
        
        fromLabel = QLabel()
        fromLabel.setText('From:')
        fromLabel.setFont(pickerfont)
        
        toLabel = QLabel()
        toLabel.setText('To:')
        toLabel.setFont(pickerfont)

        self.setDateButton = QPushButton('Set Date',self)
        self.setDateButton.clicked.connect(self.setDatePushed)
        #self.setDateButton.clicked.connect(self._controller.setDate(self.setDatePushed()))
        self.setDateButton.setFont(pickerfont)
        self.setDateButton.setFixedHeight(40)
        self.setDateButton.setFixedWidth(100)

        self.setDateMsge = QLabel()
        pickerfont.setBold(True)
        self.setDateMsge.setFont(pickerfont)
        self.setDateMsge.setFixedHeight(70)
        self.setDateMsge.setFixedWidth(200)
        self.setDateMsge.setWordWrap(True)
        self.setDateMsge.setText('Maximum time interval allowed: 365 days!')
        self.setDateMsge.setStyleSheet("color:rgb(255,49,49)")
        dmsgeSizePol = QSizePolicy()
        dmsgeSizePol.setRetainSizeWhenHidden(True)
        self.setDateMsge.setSizePolicy(dmsgeSizePol)
        self.setDateMsge.setVisible(False)

        hboxTime = QHBoxLayout()
        hboxTime.addStretch()
        hboxTime.addWidget(fromLabel)
        hboxTime.addWidget(self.fromDatePicker)
        hboxTime.addWidget(toLabel)
        hboxTime.addWidget(self.toDatePicker)
        hboxTime.addSpacing(30)
        hboxTime.addWidget(self.setDateButton)
        hboxTime.addSpacing(30)
        hboxTime.addWidget(self.setDateMsge)
        hboxTime.addStretch()

        DatePickerWidget = QWidget()
        DatePickerWidget.setLayout(hboxTime)
        vboxTimeSeries = QVBoxLayout()
        vboxTimeSeries.addWidget(DatePickerWidget)
        vboxTimeSeries.addStretch()
        gboxExRatesimeSeries.setFixedHeight(500)
        gboxExRatesimeSeries.setLayout(vboxTimeSeries) 

        # The grid is where the data from the API will be displayed
        grid = QGridLayout()
        grid.addWidget(gboxExRates,0,0)
        grid.addWidget(gboxExRatesimeSeries,0,1)
        grid.addWidget(gboxFluctuation,1,0)
        grid.addWidget(gboxHistorical,1,1)
        gridWidget = QWidget()
        gridWidget.setLayout(grid)

        # Header files(hboxMain) -> time,date,location
        # vboxMain -> grid+header
        vboxMain = QVBoxLayout()
        hboxMain = QHBoxLayout()
        
        # Clock label setting
        clockWidget = self._controller.getClockObj()
        font = QtGui.QFont('Calibri',18,QtGui.QFont.Bold)
        clockWidget.setFont(font)

        # Header Hbox
        hboxMain.addStretch()
        hboxMain.addWidget(clockWidget)
        hBoxWidget = QWidget()
        hBoxWidget.setLayout(hboxMain)
        
        # Highest hierarchy box -> mainWindow view
        vboxMain.addWidget(hBoxWidget)
        vboxMain.addWidget(gridWidget)

        # Setting up the view as the central widget of main window 
        centralWidg = QWidget()
        centralWidg.setLayout(vboxMain)
        self.setCentralWidget(centralWidg)
        
        self.show()

    def setDatePushed(self):
        toDate = self.toDatePicker.date().toPyDate()
        fromDate = self.fromDatePicker.date().toPyDate()
        daysDifference = (toDate - fromDate).days
        if daysDifference > 365 or daysDifference <-365:
            self.setDateMsge.setVisible(True)
        else: 
            self.setDateMsge.setVisible(False)
            fromDate = self.fromDatePicker.date
            toDate = self.toDatePicker.date
            dates = [fromDate,toDate]
            self._controller.setDate(dates)
    
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

class TimeSeriesPlot():
    def __init__(self):
        pass