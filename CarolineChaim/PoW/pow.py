from calls import *
import time
import hashlib
import requests
import json
import datetime
import calendar





dt = datetime.datetime.utcnow()


dt = calendar.timegm(dt.utctimetuple())

time = str(dt)



mensagem = "Primeiro bloco mineirado da Carol"

dificuldade = get_difficulty()
#dificuldade = 5
print ("DIFICULDADE:  ",dificuldade)

processando = True

nounce = 0

while processando :
    nounce_string = str(nounce)
    
    string = time + "|" + nounce_string + "|" + mensagem
    
    byte_string = bytes(string, "utf8")
    s_hash = hashlib.sha256(byte_string).hexdigest()

    if s_hash[:dificuldade] == "0"*dificuldade:
        
        hash_util = s_hash
        processando = False
    else:
        
        
        nounce += 1


headers = {
'Content-Type': 'application/json'
}
print("MENSAGEM A SER ENVIADA:  ",string)
resposta = requests.post("http://entregapow.blockchainsper.com:8880/blocks/mine", data = {'block': string})
print ("HASH DA STRING:   ", hash_util)



if resposta.status_code == 400:
    print ("============")
    print("ERRO")
    print ("============")
else:
    print ("============")
    print("BLOCO MINERADO")
    print ("============")












#timestamp|nounce|mensagem

