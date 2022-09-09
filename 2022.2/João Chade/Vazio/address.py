from web3 import Web3

w3 = Web3(Web3.HTTPProvider(
    'https://rinkeby.infura.io/v3/2f2978fbc4244143b9a72318c4a8a985'))

address = '0xa7C7195D1B00aCC6Beb5f749Ab420Eb3883477Fe'


balance = w3.eth.get_balance('0xa7C7195D1B00aCC6Beb5f749Ab420Eb3883477Fe')

res = "{:.4f}".format(balance)

print(res)
