# -*- coding: utf-8 -*-
"""
Created on Sat Sep 12

@author: Fernando
"""

from Crypto.Hash import SHA256
from Crypto.PublicKey import ECC
from Crypto.Signature import DSS

def generate_keys():
    """Function that generate private and public keys using ECDSA algorithm
    """
    key = ECC.generate(curve='P-256')
    f = open('privatekey.pem','wt')
    f.write(key.export_key(format='PEM'))
    f.close()
    
    f = open('publickey.pem','wt')
    f.write(key.public_key().export_key(format='PEM'))
    f.close()

def sign(message, private_key_directory):
    """Function that sign data with ECDSA algorithm

    Args:
        message (string): data
        private_key_directory (private_key): directory to PEM file

    Returns:
        Object: Signature
    """
    private_key = ECC.import_key(open(private_key_directory).read())
    h = SHA256.new(message.encode())
    signer = DSS.new(private_key, 'fips-186-3')
    signature = signer.sign(h)
    
    return signature

def verify(message, signature, public_key_directory):
    """Function that verify if data and signature are valid with ECDSA algorithm

    Args:
        message (string): data
        signature (object): signature generated
        public_key_directory (string): directory to PEM file

    Returns:
        boolean: True if message and signature are valid, otherwise False
    """
    public_key = ECC.import_key(open(public_key_directory).read())
    h = SHA256.new(message.encode())
    verifier = DSS.new(public_key, 'fips-186-3')
    
    try:
        verifier.verify(h, signature)
        valid = True
        
    except ValueError: 
        valid = False
        
    finally:
        return valid
    
    
if __name__ == "__main__":
    msg = "Fernando" # Message to sign
    generate_keys() # Generating keys
    
    signature = sign(msg, "privatekey.pem") #Signing the message
    
    print(verify(msg, signature, "publickey.pem")) # Verifying valid message
    print(verify(msg+"s", signature, "publickey.pem")) #Verifying invalid message
