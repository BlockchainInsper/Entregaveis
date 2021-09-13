from hashlib import sha256
import requests
import time
from merkle import calculate_merkle_root

max_nonce = 10000000

def getInfo(url):
    r = requests.get(url)
    return r.json()

def postInfo(url, data=None):
    r = requests.post(url, json=data)
    print(r)

def mine(height, previous_hash, merkle_root, timestamp, prefix_zeros):
    global max_nonce
    prefix_str = '0'*prefix_zeros

    for nonce in range(max_nonce):
        text = str(height) + previous_hash + merkle_root + str(timestamp) + str(prefix_zeros) + str(nonce)
        hash = sha256(text.encode()).hexdigest()
        hash2 = sha256(hash.encode()).hexdigest()

        if hash2.startswith(prefix_str):
            print(f'Nonce: {nonce}')
            print(f'Hash: {hash2}')

            return nonce

def main():
    blockchain_blocks = getInfo('https://blockchainsper.herokuapp.com/')
    blockchain_info = getInfo('https://blockchainsper.herokuapp.com/info')

    height = int(blockchain_info['height'])
    previous_hash = str(blockchain_info['last_hash'])
    timestamp = time.time()
    difficulty = int(blockchain_info['difficulty'])

    tx = ["doge supremacy", "to the moon"]
    merkle_root = str(calculate_merkle_root(tx))

    nonce = mine(height, previous_hash, merkle_root, timestamp, difficulty)

    header = {
        "height": height,
        "previous_hash": previous_hash,
        "merkle_root": merkle_root,
        "timestamp": timestamp,
        "difficulty": difficulty,
        "nonce": nonce,
        "tx": tx
    }

    postInfo('https://blockchainsper.herokuapp.com/mine', header)

main()