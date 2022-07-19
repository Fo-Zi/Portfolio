class Controller:
    def __init__(self,model):
        self._model = model 
        self.setup()

    def setup(self):
        pass

    def getData(self,type):
        if type=='latest':
            return self._model.parseLatest()
        elif type=='timeSeries':
            return self._model.parseTimeseries()

    def getClockObj(self):
        return self._model.clock
    
    def setDate(self,dates):
        pass
        #self._model.parseTimeSeries(dates)