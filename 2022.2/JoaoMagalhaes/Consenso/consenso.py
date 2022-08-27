import Merkle as mk
import requests
import time

data = requests.get('https://blockchainsper.herokuapp.com/info').json()

height = data['height']

valid = data['valid']

diff = data['difficulty']

last_hash = data['last_hash']

t = time.time()

msg = ["Joao Magalhaes", "Blockchain"]

merkle_root = mk.calculate_merkle_root(msg)

def gera_nonce(height, last_hash, merkle_root, t, diff):
    hash_start = "0"*diff
    nonce = 0 
    max_nonce = 1e4
    
    while nonce != max_nonce: 

        string = f"{height}{last_hash}{merkle_root}{t}{diff}{nonce}"
        hash_sha256 = mk.double_sha256(string)

        if hash_sha256.startswith(hash_start):
            return nonce  

        nonce += 1

nonce = gera_nonce(height, last_hash, merkle_root, t, diff)

block={

    "height": height,
    "difficulty": diff,
    "previous_hash": last_hash,
    "merkle_root": merkle_root,
    "timestamp": t,
    "nonce": nonce,
    "tx": msg

}

post_block = requests.post("https://blockchainsper.herokuapp.com/mine",json=block)
feedback = post_block.text
print(feedback)