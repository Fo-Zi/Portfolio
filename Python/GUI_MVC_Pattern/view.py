from PyQt5 import QtCore,QtGui
from PyQt5.QtWidgets import QMainWindow,QTableWidget,QTableWidgetItem,QGridLayout

class View(QMainWindow):

    def __init__(self,controller):
        super(View,self).__init__()
        self._controller = controller
        self.initUi()
       
    def initUi(self):
        self.setObjectName("Currency App")
        self.resize(301,249)
        data = self._controller.getData()
        table = TableView(data)
        
        self.setCentralWidget(table)
        
        self.show()
        

class TableView(QTableWidget):
    def __init__(self,data):
        super().__init__()
        self._data = data 
        self.setRowCount(len(data)+1)
        self.setColumnCount(2)
        self.loadData()
        self.resizeColumnsToContents()
        self.resizeRowsToContents()

    def loadData(self):
        self.setItem(0,0,QTableWidgetItem('Currency'))
        self.setItem(0,1,QTableWidgetItem('Rate[EUR]'))
        for i,(key,value) in enumerate(self._data.items()):
            self.setItem(i+1,0, QTableWidgetItem(key))
            self.setItem(i+1,1, QTableWidgetItem(str(value)))

    def refreshData(self,data):
        self._data = data
        self.loadData()

