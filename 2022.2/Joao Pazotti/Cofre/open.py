from web3 import Web3, HTTPProvider

end="0x6e7466260211f5499b0DBa1B4d7B89dd16661E02"

rede="https://rinkeby.infura.io/v3/5d099bf9f1a14ae39b7d2fd3c6313ee2"

connection=Web3(HTTPProvider(rede))

storage=connection.eth.get_storage_at(end,1).hex()

print(storage)