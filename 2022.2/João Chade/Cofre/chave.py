from web3 import Web3

w3 = Web3(Web3.HTTPProvider(
    'https://rinkeby.infura.io/v3/2f2978fbc4244143b9a72318c4a8a985'))

address = '0x6FEDfcc7D324ed5df30836A09158Ee66cCD11774'

storage = w3.eth.get_storage_at(address, 1).hex()

print(storage)
