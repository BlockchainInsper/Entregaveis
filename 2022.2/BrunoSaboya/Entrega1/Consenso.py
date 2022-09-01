import requests
import time
import merkle as mk 

block_information = requests.get('https://blockchainsper.herokuapp.com/info')
data = block_information.json()

is_valid = data['valid']
height = data['height']
previous_hash = data['last_hash']
merkle = mk.calculate_merkle_root(["Bruno", "Saboya"])
timestamp = time.time()
difficulty = data['difficulty']

def create_nonce(height, previous_hash, merkle, timestamp, difficulty):
    start = "0"*difficulty
    nonce = 0
    nonce_max = 1e4
    while nonce != nonce_max:
        string = f"{height}{previous_hash}{merkle}{timestamp}{difficulty}{nonce}"
        hash_SHA256 = mk.double_sha256(string)
        if hash_SHA256.startswith(start):
            return nonce
        nonce += 1

nonce = create_nonce(height, previous_hash, merkle, timestamp, difficulty)
actual_block = {"height": height, 
"previous_hash": previous_hash, 
"merkle_root": merkle, 
"timestamp": timestamp, 
"difficulty": difficulty, 
"nonce": nonce, 
"tx": ["Bruno", "Saboya"]}

block_to_post = requests.post("https://blockchainsper.herokuapp.com/mine", json = actual_block)
feedback = block_to_post.text

print(feedback)