from web3 import Web3 

address = '0xB40640cDe2f741b2b61c2Bff67b715f81b8c00B6'

key = '46c13d509fb742a9a8368b2fec6ad4fd'

network = f'https://rinkeby.infura.io/v3/{key}'

w3 = Web3(Web3.HTTPProvider(network))

storage = w3.eth.get_storage_at(address, 1).hex()

print(storage)