#IMPORTS
from calls import *
import time
import hashlib
import requests
import json
import datetime
import calendar



#TIME
dt = datetime.datetime.utcnow()
dt = calendar.timegm(dt.utctimetuple())
time = str(dt)


#MENSAGEM
mensagem = "Teste2"


#DIFICULDADE
dificuldade = get_difficulty()
#dificuldade = 5
print ("DIFICULDADE:  ",dificuldade)


#VARIAVEIS
processando = True
nounce = 0
 


#WHILE
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


#POST
print("MENSAGEM A SER ENVIADA:  ",string)


post_block(string)

print ("HASH DA STRING:   ", hash_util)















#timestamp|nounce|mensagem

