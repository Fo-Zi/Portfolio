import sys
from PyQt5 import QtCore, QtGui, QtWidgets
import requests
import json

class Model:
    def __init__(self):
        self._URL = {'exchangeR':'https://api.exchangerate.host/','gecko': 'https://api.coingecko.com/api/v3/'}
        self._APIcalls = []
        self.clock = Clock()

    def parseLatest(self):
        request = requests.get(self._URL['exchangeR']+'latest')
        jsonData = request.json()
        return jsonData['rates']

    def parseTimeSeries(self):
        request = requests.get(self._URL['exchangeR']+'latest')
        jsonData = request.json()
        return jsonData['rates']


class Clock(QtWidgets.QLabel):
    def __init__(self):
        super().__init__() 
        timer = QtCore.QTimer(self)
        timer.timeout.connect(self.updateTime)
        timer.start(1000)
    
    def updateTime(self):
        self.setText((QtCore.QTime.currentTime()).toString('hh:mm:ss'))


