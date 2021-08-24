# Entregáveis 2021.1

Propostas de Entregáveis usadas na turma de 2021.1 

## Criptografia I

O primeiro entregável será a geração de um par de chaves a partir do algoritmo ECDSA para assinaturas. No teste que deverá ser feito, você precisara assinar uma mensagem a partir das chaves. Dessa forma, além da geração de chaves, será necessário utilizá-las para a assinatura digital de uma mensagem (uma string qualquer definida pelo usuário).

Informações técnicas:

- **Você poderá usar a linguagem e biblioteca que desejar**
- Recomendamos, pela simplicidade, Python ou Javasript
- Dicas:
  - Biblioteca Crypto (Javascript)
  - Bibliotecas Python Dome e Starkbank (Python)

**Opcional:**

- [Material Complementar](https://github.com/BlockchainInsper/Entregaveis/blob/master/MateriaisComplementares/Criptografia.md)
- [Entregável RSA](https://github.com/BlockchainInsper/Entregaveis/blob/master/MateriaisComplementares/RSA.md)
  - **Todos os exercícios estão acompanhados de respostas, portanto sua tarefa é criar um programa que chegue a esses resultados da maneira que achar mais conveniente**

---

## Consenso I

A ideia do segundo entregável é aprender o conceito básico do algoritmo de consenso Proof of Work, utilizado no processo de mineração de várias criptomoedas, como o Bitcoin. Assim, conforme visto na aula, você precisara descobrir um "nounce" que, somado às informações contidas no bloco, gere um hash válido para a dificuldade definida pela rede.

O bloco deste exercício contém três informações:

- Timestamp (data e horário)
- Nounce
- Message (pode ser qualquer dado).
- Previous Hash (hash do bloco anterior)

A estrutura segue o seguinte exemplo de string: “timestamp|message|nounce|previous_hash".

Obs:
**Tenha em mente que a dificuldade pode variar.** Uma dificuldade 3, necessita que vocês gerem um hash com três zeros no começo, por exemplo: 000hhfgd4

Informações técnicas:

- **Você poderá usar a linguagem e biblioteca que desejar**
- Recomendamos, pela simplicidade, Python ou Javasript
- Dicas:
  - Biblioteca Crypto e Axios (Javascript)
  - Bibliotecas Python Dome, Starkbank e requests (Python)
- **Requests**

  - **(GET)** https://blockchainsper.herokuapp.com/blocks -> Devolve os blocos presentes na rede
  - **(GET)** https://blockchainsper.herokuapp.com/blocks/difficulty -> Devolve a dificuldade atual da rede
  - **(GET)** https://blockchainsper.herokuapp.com/blocks/last_hash -> Devolve o hash do último bloco
  - **(POST)** https://blockchainsper.herokuapp.com/blocks/mine -> Faz um post de um bloco e o envia para a validação

  ```
    {
      “block”:“timestamp|message|nounce|last_hash”
    }

    Obs: Timestamp deve estar em UNIX!
  ```

  - **(GET)** https://blockchainsper.herokuapp.com/blocks/valid -> Retorna uma string dizendo se a blockchain é válida ou não

**Opcional:**

- [Material Complementar](https://github.com/BlockchainInsper/Entregaveis/blob/master/MateriaisComplementares/Consenso.md)

---

## Compras Online Seguras

Atualmente, a compra de mercadorias online requer várias partes que precisam confiar umas nas outras. A configuração mais simples envolve um vendedor e um comprador. O comprador quer receber um item do vendedor e o vendedor deseja receber dinheiro (ou equivalente) em troca. A parte problemática é o envio: não há como saber com certeza se o item chegou ao comprador. Existem várias maneiras de resolver esse problema, mas todas falham de uma ou outra maneira. 

**Seu objetivo é construir uma solução em Blockchain para este problema**

A solução será baseada no seguinte pressuposto: ambas as partes devem colocar duas vezes o valor do item no contrato como garantia. Assim que isso acontecer, o dinheiro ficará trancado dentro de um smart contract até que o comprador confirme que recebeu o item. Depois disso, o comprador recebe de volta o valor (metade do seu depósito) e o vendedor recebe o triplo do valor (o seu depósito mais o valor). A ideia por trás disso é que ambas as partes têm um incentivo para resolver a situação, caso contrário, seu dinheiro ficará bloqueado para sempre no contrato. 

![](https://github.com/BlockchainInsper/Entregaveis/blob/proposta-compra-venda/MateriaisComplementares/diagramaExemplo.png)

É claro que isto não resolve 100% o problema, mas dá uma visão geral de como você pode usar um contrato inteligente para solucionar um problema do cotidiano de uma empresa.

Informações técnicas:

- O smart contract deve ser feito na linguagem Solidity
- **Você pode desenvolver o contrato do modo que desejar, no entanto foi criado um modelo para ajudá-lo a desenvolver uma solução**
- Use eventos como forma de avisar as partes sobre o que está acontecendo no smart contract

**Opcional:**
- [Dicionário Solidity](https://solidity-by-example.org/)
- [MaterialComplementar](https://github.com/BlockchainInsper/Entregaveis/blob/proposta-compra-venda/MateriaisComplementares/Solidity.md)

### Modelo

Contrato                   |  State                    |  Events 
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/BlockchainInsper/Entregaveis/blob/proposta-compra-venda/MateriaisComplementares/contract.png)   | ![](https://github.com/BlockchainInsper/Entregaveis/blob/proposta-compra-venda/MateriaisComplementares/state.png) | ![](https://github.com/BlockchainInsper/Entregaveis/blob/proposta-compra-venda/MateriaisComplementares/events.png)

| States   |      Explicação      |
|----------|:--------------------:|
| Created |  Estado padrão de criação do contrato, deve permanecer nele até o pagamento do produto pelo comprador ou o cancelamento da compra pelo vendedor|
| Locked |    Estado de pagamento do produto, deve permanecer nele até a confirmação de chegada do produto pelo comprador   |
| Released |    Estado de recebimento do produto, neste estado o produto foi entregue ao comprador   |
| Inactive | Estado de inatividade, ou seja, o produto já foi entregue e todas as partes foram pagas ou a compra foi cancelada pelo vendedor antes do pagamento do comprador |

| Functions   |      Explicação      |
|----------|:--------------------:|
| abort() | Função de cancelamento da compra. Só pode ser executada pelo vendedor e o contrato deve estar no estado *Created*. Ao final, modificar o estado para *Inactive* e devolver o valor do contrato ao vendedor|
| confirmPurchase() | Função de pagamento recebido. É pública, deve receber o valor do comprador e o contrato deve estar no estado *Created*. Ao final, modificar o estado para *Locked*|
| confirmReceived() | Função de confirmação de recebimento do produto. Só pode ser executada pelo comprador e o contrato deve estar no estado *Locked*. Ao final, modificar o estado para *Released* e pagar 1/4 do valor total de volta ao comprador|
| refundSeller() | Função de restituição do valor ao vendedor. Só pode ser executada pelo vendedor e o contrato deve estar no estado *Release*. Ao final, modificar o estado para *Inactive* e pagar 3/4 do valor total de volta ao vendedor|


---


## Como fazer as entregas?

1. Faça um fork deste repositório
2. Clone o respositório que você fez o fork no seu computador
3. Faça o entregável e salve-o com a seguinte estrutura de pastas

```.
├── SeuNome
│   ├── Nome do Entregável
│   │   ├── arquivos
├── MateriaisComplementares
└── README.md
```

4. Faça o commit para o repositório que fez o fork
5. Crie um pull-request para o repositório principal

6. Ficou com alguma dúvida? [Este link pode te ajudar](https://www.freecodecamp.org/news/how-to-make-your-first-pull-request-on-github-3/)
