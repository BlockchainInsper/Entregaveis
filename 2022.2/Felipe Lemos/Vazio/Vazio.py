from web3 import Web3 

address = '0x6B6972d0237efD29b351f118f367bA944d736E04'

network = "https://rinkeby.infura.io/v3/8cfa71130ae2414cace5dceb9739176a" 

w3 = Web3(Web3.HTTPProvider(network))

balance = w3.fromWei(w3.eth.getBalance(address), 'ether')

print(f'Balance : {balance} ETH')

