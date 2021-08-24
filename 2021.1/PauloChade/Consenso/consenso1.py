from datetime import timezone, datetime
from hashlib import sha256
import requests

dt = datetime.now()
timestamp = dt.replace(tzinfo=timezone.utc).timestamp()

get_dificuldade = requests.get("https://blockchainsper.herokuapp.com/blocks/difficulty").json()
get_blocks = requests.get("https://blockchainsper.herokuapp.com/blocks").json()
get_lastHash = requests.get("https://blockchainsper.herokuapp.com/blocks/last_hash").json()

dificuldade = get_dificuldade["difficulty"]
lastHash = get_lastHash["last_hash"]

message = "blockchain_insper"

def generate_hash(nounce, mensagem, lastHash, timestamp):
    block_header = str(timestamp) + '|' + str(mensagem) + '|' + str(nounce) + '|' + str(lastHash)
    block_hash = sha256(block_header.encode())
    return block_hash.hexdigest(), block_header

def approve_hash(mensagem, dificuldade, lastHash, timestamp):
    nounce = 0
    Hash = generate_hash(nounce, mensagem, lastHash, timestamp)[0]
    while Hash[:dificuldade] != "0" * dificuldade:
        nounce +=1
        Hash, header = generate_hash(nounce, mensagem, lastHash, timestamp)
    return Hash , nounce, header

Block = approve_hash(message, dificuldade, lastHash, timestamp)

bloco = {"block": Block[2]}

print(bloco)

r = requests.post('https://blockchainsper.herokuapp.com/blocks/mine', json = bloco)

print(r.text)

print(requests.get("https://blockchainsper.herokuapp.com/blocks/valid").json())
