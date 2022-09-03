from web3 import Web3
web_3=Web3(Web3.HTTPProvider("https://eth-rinkeby.alchemyapi.io/v2/qeTgjjiV4xOXpt2LPUG_MBs4rKDHUDdN")) #conecta com a rede rinkeby
endereco='0x8600925B2A3BF9F4F305B5322F435D8D2E3eD7AD'# endereço do contrato
private_key=web_3.eth.get_storage_at(endereco,1).hex()
print(private_key)


