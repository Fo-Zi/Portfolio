import sys
from PyQt5 import QtCore, QtGui, QtWidgets
import requests
import json

class Model:
    def __init__(self):
        self._URL = 'https://api.exchangerate.host/'
        self._APIcalls = ('latest','convert','historical','time-series','fluctuation')

    def parseData(self):
        request = requests.get(self._URL+'latest')
        jsonData = request.json()
        return jsonData['rates']
    
