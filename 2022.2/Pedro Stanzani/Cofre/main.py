import os
import json
from web3 import Web3

ADDRESS = '0x0b88A2e1A5D90DF8737Db20A31ffdac30466511f'

def load_web3():
    API_KEY = os.environ['API_KEY']

    endpoint = f'https://rinkeby.infura.io/v3/{API_KEY}'
    provider = Web3.HTTPProvider(endpoint)
    return Web3(provider)

def find_password(w3):
    return w3.eth.get_storage_at(ADDRESS, 1).hex()

def load_contract(w3):
    with open('abi.json', 'r') as file:
        jx = file.read()
        abi = json.loads(jx)

    return w3.eth.contract(address=ADDRESS, abi=abi)

def is_locked(w3):
    c = load_contract(w3)
    return c.functions.locked().call()

if __name__ == '__main__':
    w3 = load_web3()
    password = find_password(w3)
    print(password)
