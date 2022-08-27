# Cofre

A ideia deste entregável é introduzir os conceitos de audit/segurança de smart-contracts através de um exercício prático. Neste desafio, vocês aprenderão a ler o storage de contrato, para desbloquear um cofre com uma senha armazenada de maneira “privada”. Assim, conforme visto na aula, você deverá usar seus conhecimentos técnicos em Solidity e Web3 para desbloquear o contrato.

Cada membro receberá um endereço de um smart-contract rodando em uma rede de teste com o código abaixo. O entregável será considerado feito caso a varíavel `locked` do seu contrato esteja setada para `false`.

Informações técnicas:

- **Você poderá usar a linguagem e biblioteca que desejar**
- Recomendo, pela simplicidade, Python ou Javasript
- Dicas:
  - Biblioteca Web3.js (Javascript)
  - Biblioteca Web3.py (Python)
- Para chamar a função do contrato, você pode utilizar tanto o Truffle, quanto o [Remix](https://remix-project.org/)
- **Você não precisa enviar o código utilizado para chamar a função do contrato, apenas o código para encontrar a variável privada**

Código
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Cofre {
  bool public locked;
  bytes32 private password;

  constructor(bytes32 _password) {
    locked = true;
    password = _password;
  }

  function unlock(bytes32 _password) public {
    if (password == _password) {
      locked = false;
    }
  }
}
```

Endereços (rede Rinkeby)
- Bruno Saboya: 0x512e1a4c24677fe69b8B007763a5A64a2291f499
- Felipe Lemos: 0xB40640cDe2f741b2b61c2Bff67b715f81b8c00B6
- João Chade: 0x6FEDfcc7D324ed5df30836A09158Ee66cCD11774
- João Magalhães: 0x84d473327110e3F37e3fF68FC61f00c081b4D8Ca
- João Pazotti: 0x6e7466260211f5499b0DBa1B4d7B89dd16661E02
- Luiz Otávio: 0x7F19722531c435B6aFB53CBBa2e846a498061c5D
- Pedro Stanzani: 0x0b88A2e1A5D90DF8737Db20A31ffdac30466511f
- Pedro Von: 0x8600925B2A3BF9F4F305B5322F435D8D2E3eD7AD
