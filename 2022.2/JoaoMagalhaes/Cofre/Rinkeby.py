from web3 import Web3

url = "https://rpc.ankr.com/eth_rinkeby"

contract_address = '0x84d473327110e3F37e3fF68FC61f00c081b4D8Ca'

web3 = Web3(Web3.HTTPProvider(url))

# contract_instance = w3.eth.contract(address = contract_address)

storage = web3.eth.getStorageAt(contract_address, 0)

print (storage)