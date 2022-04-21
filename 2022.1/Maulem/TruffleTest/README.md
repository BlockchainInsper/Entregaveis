# Truffle-React-Template

### Repositório para inicializar um projeto com truffle e react

Baixe o repositorio e rode 
````
npm install
````
Para instalar todos os pacotes.

Rode
````
truffle migrate
````
Para dar deploy dos contratos

Caso ja tenha instalado todas as dependências (veja lista no final), rode:
````
npm start
````
Para rodar o projeto

## Funcões auxiliares
O projeto conta um funções auxiliares na pasta `src/helpers`, para facilitar a conexão com a rede blockchain.
* `loadWeb3` - Realiza a conexão com um node do metamask na rede selecionada
* `loadAccount` - Recebe uma instância do tipo Web3, e retorna a conta selecionada no metamask
* `loadTutorial` - Exemplo de como carregar um contrato para poder utilizar suas funções, recebe uma instância do tipo Web3 e o Id da rede que o contrato está

## Dependencias
* [Node.js](https://nodejs.org/en/)
* [Ganache](https://trufflesuite.com/ganache/)
* [Truffle](https://trufflesuite.com/truffle/)

[Repo Setup](https://github.com/ChainSafe/web3.js#troubleshooting-and-known-issues)
