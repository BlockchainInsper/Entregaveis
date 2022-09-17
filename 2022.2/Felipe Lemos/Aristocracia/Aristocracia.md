# Aristocracia

A ideia deste entregável é introduzir os conceitos audit/segurança de smart-contracts através de um exercício prático.

O contrato deste entregável representa uma ideia muito simples: quem enviar uma quantidade de ETH maior que o prêmio atual se torna o novo presidente da BI. Quando isso ocorre, o ex-presidente recebe o novo prêmio, fazendo um pouco de dinheiro no processo!

A ideia de aristocracia parece ser bem interessante (ainda mais estando no Insper rs). Mas, como você quer se tornar o ditador da BI, seu objetivo é quebrar o contrato.

Ao final da semana, tentarei reivindicar a presidência da BI. Caso eu não consiga, seu entregável será considerado feito. 

Informações Técnicas:
- **Você deve enviar o todo e qualquer código utilizado para fazer o entregável**

Código do Contrato
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BI {

  address payable public presidente;
  uint public premio;

  constructor() payable {
    presidente = payable(msg.sender);
    premio = msg.value;
  }

  receive() external payable {
    require(msg.value > premio);
    
    (bool sent, ) = presidente.call{value: msg.value}("");
    require(sent, "Failed to send Ether");

    presidente = payable(msg.sender);
    premio = msg.value;
  }
}
```

Endereços (rede Rinkeby)
- Bruno Saboya: 0xE6487D6b9aD94967a5469d1Ce54C7560d47FAa96 
- Felipe Lemos: 0x3E000327eCC7BF842f95281E3a4263b66dB834D5
- João Chade: 0xc55B5f5613143334f54d269F4279Dc2C74D4e7bE
- João Magalhães: 0x1640702CcFDfDB1eE0099a6Bad19EA3938d68069
- João Pazotti: 0xaAdaBA670D7df78891e0eAefB6331d769C8941f4
- Luiz Otávio: 0x4690b8593e62ef4f7c2E96158a1c05630e5Db147
- Pedro Stanzani: 0x70a25a82Fa6155CA3f12FCA834E74109B89ce043
- Pedro Von: 0x894fD20D8857509960d87480fDbce0515D5aF209
