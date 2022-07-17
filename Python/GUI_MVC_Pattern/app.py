from PyQt5.QtWidgets import QApplication
import sys

from model import Model
from view import View
from controller import Controller

class App(QApplication):
    def __init__(self,argv):
        super().__init__(argv)

        self._model = Model()

        self._controller = Controller(self._model)

        self._view = View(self._controller)

    
if __name__  == '__main__':
    app = App(sys.argv)
    sys.exit(app.exec_())
