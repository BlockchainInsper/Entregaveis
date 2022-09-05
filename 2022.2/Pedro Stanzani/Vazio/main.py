# Script para conferir o balance do contrato
import os
from web3 import Web3

ADDRESS = '0x74Ce72d83C071b48084Aa7814577cD29b1985d59'

def load_web3():
    API_KEY = os.environ['API_KEY']

    endpoint = f'https://rinkeby.infura.io/v3/{API_KEY}'
    provider = Web3.HTTPProvider(endpoint)
    return Web3(provider)

if __name__ == '__main__':
    w3 = load_web3()
    balance = w3.eth.get_balance(ADDRESS)
    print(balance)
