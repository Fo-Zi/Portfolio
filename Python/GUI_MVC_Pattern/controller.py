class Controller:
    def __init__(self,model):
        self._model = model 
        self.setup()

    def setup(self):
        pass

    def getData(self):
        return self._model.parseData()
        
