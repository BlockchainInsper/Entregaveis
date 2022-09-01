# importing the requests library
from urllib import request
import requests
from hashlib import sha256
import merkle as Merkle
import time
  
  
# sending get request and saving the response as response object
resinfo=requests.get("https://blockchainsper.herokuapp.com/info").json()
res=requests.get("https://blockchainsper.herokuapp.com/").json()
#seleciona ultimo bloco
lastblock=res["chain"][res["length"]-1]
time=time.time()
#salva o conteudo
difficulty=lastblock["difficulty"]
previous_hash=lastblock["previous_hash"]
height=lastblock["height"]
merkle_root=lastblock["merkle_root"]
timestamp=lastblock["timestamp"]


def lasthash():
    nonce=0
    hash=1
    hashfinal="1"*difficulty
    while hashfinal[0:difficulty]!=("0"*difficulty):
        string=f"{height}{previous_hash}{merkle_root}{timestamp}{difficulty}{nonce}"
        hash=sha256(string.encode()).hexdigest()
        hashfinal=sha256(hash.encode()).hexdigest()
        nonce+=1
    
    return hashfinal,nonce
#define as variaveis do proximo bloco
tx=(["Pedro Dannecker","Blockchain Insper"])  
merkleroot=Merkle.calculate_merkle_root(tx)  
lasthash,nonce=lasthash()
bloco={
    "difficulty":3,
    "height":height+1,
    "merkle_root":merkleroot,
    "nonce":nonce,
    "previous_hash":lasthash,
    "timestamp":time,
    "tx":tx

}
#faz o post na chain
requests.post("https://blockchainsper.herokuapp.com/mine",json=bloco)



  