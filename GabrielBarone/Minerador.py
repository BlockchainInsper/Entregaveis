# -*- coding: utf-8 -*-
"""
Spyder Editor

Autor: Gabriel Barone

"""

import hashlib 
import requests
import json
import time

def get_difficulty():
    url = "http://entregapow.blockchainsper.com:8880/blocks/difficulty"

    payload = {}
    headers = {}

    response = requests.request("GET", url, headers=headers, data = payload)
    response = json.loads(response.text)
    return response["data"]["zeros"]

def post_block(BLOCO):
    url = "http://entregapow.blockchainsper.com:8880/blocks/mine"

    payload = "{\n    \"block\": \"" + BLOCO + "\"\n}"
    headers = {
    'Content-Type': 'application/json'
    }
    return requests.request("POST", url, headers=headers, data = payload)

dificuldade = get_difficulty()
hasheador = hashlib.sha256()
mensagem = "Teste 2 Barone"
print("A dificuldade atual é: " + dificuldade)
pronto = "não"
nounce = 0

while pronto == "não":
    
    horario = time.time()
    nounce = nounce + 1
    strhorario = str(horario)
    strnounce = str(nounce)
    bloco = str(strhorario + "|" + strnounce + "|" + mensagem)
    hasheador.update(bloco.encode('UTF-8'))
    digerido = str(hasheador.hexdigest())
    i = 0
    if dificuldade == 0:
        break
    else:
        while i < dificuldade:
            if digerido[i] != "0":
                break
            else:
                if i == dificuldade - 1: 
                    pronto = "sim" 
                    break 
                else:
                    i = i + 1
                    
post_block(bloco)

print("O hash do seu bloco é: " + hasheador.hexdigest())
print("O seu bloco é: " + bloco)