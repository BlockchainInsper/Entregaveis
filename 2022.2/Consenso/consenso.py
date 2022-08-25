import requests
from hashlib import sha256
from merkle import calculate_merkle_root
import time

res=requests.get("https://blockchainsper.herokuapp.com/info").json()

dif=res['difficulty']

height=res['height']

previous_hash=res['last_hash']

valid=res['valid']

timer=time.time()

limit_nonce=1e6

message=["João Pazotti","Tech Member"]

def block(dif,height,previous_hash,timer,merkle_root):

    zeroes="0"*dif

    nonce=0

    global limit_nonce

    while nonce!=limit_nonce:

        header=f"{height}{previous_hash}{merkle_root}{timer}{dif}{nonce}"

        hash=sha256(header.encode()).hexdigest()

        block_hash=sha256(hash.encode()).hexdigest()

        if block_hash.startswith(zeroes):
            return nonce

        nonce+=1

merkle_root=calculate_merkle_root(message)

nonce=block(dif,height,previous_hash,timer,merkle_root)

new_block={"difficulty":dif,"height":height,"merkle_root":merkle_root,"nonce":nonce,
"previous_hash":previous_hash,"timestamp":timer,"tx":message}

post=requests.post("https://blockchainsper.herokuapp.com/mine",json=new_block)

print(post.text)

    


