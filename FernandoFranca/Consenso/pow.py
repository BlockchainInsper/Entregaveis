# -*- coding: utf-8 -*-
"""
Created on Wed Sep 16

@author: Fernando
"""

import requests
import json
from time import time
from Crypto.Hash import SHA256

def get_difficulty():
    """Function that gets the difficulty of mining the block

    Returns:
        Int: Number of zeros
    """
    url = "http://entregapow.blockchainsper.com:8880/blocks/difficulty"
    response = requests.request("GET", url)
    response = json.loads(response.text)
    return response["data"]["zeros"]

def create_block(message, number_of_zeros):
    """Function that creates the block

    Args:
        message (string): data
        number_of_zeros (int): difficulty

    Returns:
        String: Hash
        String: Block
    """
    nounce = 0
    clock = time()
    block = f"{clock}|{nounce}|{message}"
    h = SHA256.new(block.encode())
    difficulty = "0"*number_of_zeros
    
    while not h.hexdigest().startswith(difficulty):
        nounce += 1
        block = f"{clock}|{nounce}|{message}"
        h = SHA256.new(block.encode())
        if nounce % 10000 == 0:
            print(f"Nounce: {nounce}")

    return h.hexdigest(), block

def post_block(block):
    """Function that posts the block to blockchain
    """
    url = "http://entregapow.blockchainsper.com:8880/blocks/mine"

    payload = "{\n    \"block\": \"" + block+ "\"\n}"
    headers = {
    'Content-Type': 'application/json'
    }
    return requests.request("POST", url, headers=headers, data = payload)


if __name__ == "__main__":
    message = "ILoveBI" # Message inside the block
    number_of_zeros = get_difficulty() # Get the difficulty
    print(number_of_zeros) # Print number of zeros
    
    h, block = create_block(message, number_of_zeros) # Generating the block
    
    print(h) # Print hashed block
    print(block) # Print string block

    post = True # Post boolean

    if post:
        post_block(block) # Post block to blockchain