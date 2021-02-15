import requests
import json
import asyncio
import time
import hashlib

def get_difficulty():
    url = "http://entregapow.blockchainsper.com:8880/blocks/difficulty"

    payload = {}
    headers = {}

    response = requests.request("GET", url, headers=headers, data = payload)
    response = json.loads(response.text)
    return response["data"]["zeros"]

def post_block(block):
    url = "http://entregapow.blockchainsper.com:8880/blocks/mine"

    payload = "{\n    \"block\": \"" + block + "\"\n}"
    headers = {
    'Content-Type': 'application/json'
    }
    return requests.request("POST", url, headers=headers, data = payload)

Block = {}
m = "mensagem"
dif = get_difficulty() 
print("Difficulty: ",dif)

start_time = time.time()
n = 0
while  True:
    t = time.time()
    block = str(t) + "|" + str(n) + "|" + m
    h = hashlib.sha256(block.encode()).hexdigest()
    if h[:dif] == "0" * dif:
        break
    n += 1
print("Time to mine: " + str(time.time() - start_time) + " seconds")
print("Block: " + str(block))
print("Hash: ", h)

post_block(block)