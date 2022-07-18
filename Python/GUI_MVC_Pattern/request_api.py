import requests
import json
import tkinter as tk

response = requests.get("https://api.exchangerate.host/2020-04-04")
res_json = response.json()
#res_dict = json.loads(res_json)

#try:
#    print(response.json())
#except:
#    pass
#
try:
    for attr,value in res_json['rates'].items():
        print(f'Currency:{attr} - Value={value}')
except:
    pass 



