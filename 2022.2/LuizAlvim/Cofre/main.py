from web3 import Web3, HTTPProvider

w3 = Web3(HTTPProvider("https://rpc.ankr.com/eth_rinkeby")) # connects to rinkeby testnet

storage = w3.eth.get_storage_at('0x7F19722531c435B6aFB53CBBa2e846a498061c5D', 1) # gets storage at index 1: password
print(storage.hex()) # decodes hex as str
