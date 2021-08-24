from hashlib import blake2b, sha256
import requests
import json
import time

# Função que aplica o Hash no bloco.
def testNonce(timestamp, message, nounce, last_hash):
  message = str(timestamp) + '|' + str(message) + '|' +  str(nounce) + '|' +  str(last_hash)
  #hash = blake2b(message.encode(), digest_size=32)
  hash = sha256(message.encode())
  return hash.hexdigest()

# Pegando a dificuldade da rede.
difficulty_req = requests.get('https://blockchainsper.herokuapp.com/blocks/difficulty')
difficulty_data = json.loads(difficulty_req.text)
difficulty = difficulty_data['difficulty']

# Pegando o hash do bloco anterior.
hash_req = requests.get('https://blockchainsper.herokuapp.com/blocks/last_hash')
hash_data = json.loads(hash_req.text)
last_hash = hash_data['last_hash']

# Pegando o Timestamp em formato Unix.
timestamp = time.time()


message = "Matheus transferiu 45 BTC para Fernando"
nounce = 0
block_hash = ''

while block_hash[:difficulty] != '0'*difficulty:
    nounce += 1
    block_hash = testNonce(timestamp, message, nounce, last_hash)

print(nounce)
print(block_hash)

block = {
            "block": "{0}|{1}|{2}|{3}".format(timestamp, message, nounce, last_hash)
        } 

print(block)

post_req = requests.post('https://blockchainsper.herokuapp.com/blocks/mine', json = block)
post_data = json.loads(post_req.text)
print(post_req.text)

valid_req = requests.get('https://blockchainsper.herokuapp.com/blocks/valid')
valid_data = json.loads(valid_req.text)
print(valid_data)


