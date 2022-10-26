# Reentrancy

A ideia deste entregável é introduzir os conceitos audit/segurança de smart-contracts através de um exercício prático.

O objetivo aqui é que você roube todos os fundos do contrato.

Coisas que podem te ajudar:

- Contratos não confiáveis ​​podem executar código onde você menos espera.
- Métodos de fallback/receive
- Dentro do contrato já tem 100 wei 

Informações Técnicas:

- **Você deve enviar o todo e qualquer código utilizado para fazer o entregável**

Código do Contrato

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 

contract Reentrance {

  mapping(address => uint) public balances;

  constructor () payable {}

  function donate(address _to) public payable {
    balances[_to] += msg.value;
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      require(result, "Failed to send eth");
      unchecked {
        balances[msg.sender] -= _amount;
      }
    }
  }
}
```

Endereços (rede Goerli)

- Bruno Saboya: 0x8e992dCA5f4695216AaBa7A5A49E612487f69e98
- Felipe Lemos: 0xC0b2DB37D20181913c673d54cB20F00966d858CA
- João Chade: 0x7efFf2fb972EB77f61922af70820053566F483C5
- João Magalhães: 0x317c33877DFF9d20adce40575681147981BE0181
- Luiz Otávio: 0xAB8E5130Ce415ce5d679D299170dbAc64CaBaE13
- Pedro Stanzani: 0x008ED34e31c1bb3bA3E8AbE8A154c20fdf0BAb4b
- Pedro Von: 0x2B420085C4671023817Fb96E839A3c6b28C0ea39
