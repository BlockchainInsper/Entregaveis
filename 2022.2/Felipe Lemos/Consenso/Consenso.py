import requests
import time
import Merkle as mk 

# all_blocks_get = requests.get('https://blockchainsper.herokuapp.com/')
# all_blocks = all_blocks_get.json()
# print(all_blocks)

info_get = requests.get('https://blockchainsper.herokuapp.com/info') 
info_data = info_get.json()
# print(info_data)

valid = info_data['valid']

height = info_data['height']
previous_hash = info_data['last_hash']
merkle_root = mk.calculate_merkle_root(["Felipe", "Lemos"])
unix_timestamp = time.time()
difficulty = info_data['difficulty']

def generate_nonce(height, previous_hash, merkle_root, unix_timestamp, difficulty):
    hash_start = "0"*difficulty
    nonce = 0 
    max_nonce = 1e4
    
    while nonce != max_nonce: 

        string = f"{height}{previous_hash}{merkle_root}{unix_timestamp}{difficulty}{nonce}"
        hash_sha256 = mk.double_sha256(string)

        if hash_sha256.startswith(hash_start):
            return nonce  

        nonce += 1

nonce = generate_nonce(height, previous_hash, merkle_root, unix_timestamp, difficulty)

cur_block = {
        "height": height,
        "previous_hash": previous_hash,
        "merkle_root": merkle_root,
        "timestamp": unix_timestamp,
        "difficulty": difficulty,
        "nonce": nonce,
        "tx": ["Felipe", "Lemos"]
    }

post_block = requests.post("https://blockchainsper.herokuapp.com/mine",json=cur_block)
mining_feedback = post_block.text

print(mining_feedback)


