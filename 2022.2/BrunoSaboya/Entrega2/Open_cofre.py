from web3 import Web3, HTTPProvider

end="0x512e1a4c24677fe69b8B007763a5A64a2291f499"

rede="https://rinkeby.infura.io/v3/5d099bf9f1a14ae39b7d2fd3c6313ee2"

connection=Web3(HTTPProvider(rede))

storage=connection.eth.getStorageAt(end, 0)

print(storage)