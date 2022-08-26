from email import message
from typing import List
from wsgiref import validate
from Crypto.Hash import SHA256
import requests
import time
from hashlib import sha256

# timestamp em Unix
ts = time.time()

# requests
rq = requests.get('https://blockchainsper.herokuapp.com/info').json()

dificuldade = rq["difficulty"]

print(dificuldade)

get_height = rq['height']
previous_hash = rq['last_hash']
message = ['joao chade', 'teste 1']

# merkle root


def double_sha256(tx: str) -> str:
    return SHA256.new(SHA256.new(tx.encode()).hexdigest().encode()).hexdigest()


def find_merkle_root(leaf_hash: List[str]) -> str:
    hash = []
    hash2 = []

    if len(leaf_hash) % 2 != 0:
        leaf_hash.extend(leaf_hash[-1:])

    for leaf in sorted(leaf_hash):
        hash.append(leaf)
        if len(hash) % 2 == 0:
            hash2.append(double_sha256(hash[0] + hash[1]))
            hash = []

    if len(hash2) == 1:
        return hash2[0]

    return find_merkle_root(hash2)


def calculate_merkle_root(tx: List[str]):
    leaf_hash = []

    for transaction in tx:
        leaf_hash.append(double_sha256(transaction))

    return find_merkle_root(leaf_hash)


merkle_root = calculate_merkle_root(message)


def get_sha256(text):
    return sha256(text.encode('ascii')).hexdigest()


def mine(height, difficulty, last_hash, merkle_root, ts):
    nonce = 0
    while True:
        texto = str(height) + last_hash + merkle_root + \
            str(ts) + str(difficulty) + str(nonce)
        Hash = get_sha256(texto)
        hash2 = get_sha256(Hash)
        if hash2.startswith('0' * difficulty):
            print(hash2)
            return nonce
        nonce += 1


nonce = mine(get_height, dificuldade, previous_hash, merkle_root, ts)

novo_bloco = {"difficulty": dificuldade, "height": get_height, "merkle_root": merkle_root, "nonce": nonce,
              "previous_hash": previous_hash, "timestamp": ts, "tx": message}

#new_block = f"{get_height}{previous_hash}{merkle_root}{ts}{dificuldade}{nonce}"

print(novo_bloco)

post = requests.post(
    "https://blockchainsper.herokuapp.com/mine", json=novo_bloco)

print(post.text)
