from calls import *
import time
import hashlib

import requests
import json

url = "http://entregapow.blockchainsper.com:8880/blocks/mine"

headers = {
'Content-Type': 'application/json'
 }

time = time.time()
time_string = str(time)
mensagem = "Primeiro bloco mineirado da Carol"

#dificuldade = get_difficulty()

dificuldade = 2
print (dificuldade)

processando = True

nounce = 0

while processando :
    nounce_string = str(nounce)
    string = time_string + "|" + nounce_string + "|" + mensagem
    s_hash = hashlib.sha256(b"string").hexdigest()

    if s_hash[:dificuldade] == "0"*dificuldade:
        print ("nounce ta safe")
        hash_util = s_hash
        processando = False
    else:
        
        nounce += 1


print (hash_util)

#requests.request("POST", url, headers=headers, data = string)








#timestamp|nounce|mensagem

print (get_difficulty())