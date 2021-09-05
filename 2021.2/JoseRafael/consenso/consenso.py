import time
from Crypto import Hash
import requests
from hashlib import sha256
from merkle import calculate_merkle_root

timestamp = time.time()

info = requests.get("https://blockchainsper.herokuapp.com/info").json()

difficulty = info["difficulty"]
height = info["height"]
last_hash = info["last_hash"]
valid = info["valid"]


def new_hash(difficulty, height, last_hash, timestamp, nounce, message):
    merkle_root = calculate_merkle_root(message)
    header = "{}{}{}{}{}{}".format(height, last_hash, merkle_root, timestamp, difficulty, nounce)
    intermediary_hash = sha256(header.encode())
    real_hash = sha256(intermediary_hash.hexdigest().encode())
    return real_hash.hexdigest(), merkle_root

def new_block(difficulty, height, last_hash, timestamp, message):
    nounce = 0 
    hash_new = ""

    while hash_new[:difficulty] != "0" * difficulty:
        nounce += 1
        hash_new, merkle_root = new_hash(difficulty, height, last_hash, timestamp, nounce, message)

    new_block = {"difficulty":difficulty,"height":height,"merkle_root":merkle_root,"nonce": nounce,"previous_hash":last_hash,"timestamp":timestamp,"tx":message}
    return new_block

message = ["Blockchain Insper", "Tech 2021.2"]

block = new_block(difficulty, height, last_hash, timestamp, message)

new_post = requests.post("https://blockchainsper.herokuapp.com/mine", json= block)

print(new_post.text)
