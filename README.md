# Entregáveis

Repositório de entregáveis dos membros do núcleo de Tecnologia da Blockchain Insper

## Criptografia I

O primeiro entregável será a geração de um par de chaves a partir do algoritmo ECDSA para assinaturas. No teste que deverá ser feito, você precisara assinar uma mensagem a partir das chaves. Dessa forma, além da geração de chaves, será necessário utilizá-las para a assinatura digital de uma mensagem (uma string qualquer definida pelo usuário).

Informações técnicas:

- **Você poderá usar a linguagem e biblioteca que desejar**
- Recomendamos, pela simplicidade, Python ou Javasript
- Dicas:
  - Biblioteca Crypto (Javascript)
  - Bibliotecas Python Dome e Starkbank (Python)

**Opcional:**

- [Material Complementar](https://github.com/BlockchainInsper/Entregaveis/blob/master/MateriaisComplementares/Criptografia1.md)
- [Entregável RSA](https://github.com/BlockchainInsper/Entregaveis/blob/master/MateriaisComplementares/Criptografia2.md)
  - **Todos os exercícios estão acompanhados de respostas, portanto sua tarefa é criar um programa que chegue a esses resultados da maneira que achar mais conveniente**

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

- [Material Complementar](https://github.com/BlockchainInsper/Entregaveis/blob/master/MateriaisComplementares/Consenso1.md)

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
