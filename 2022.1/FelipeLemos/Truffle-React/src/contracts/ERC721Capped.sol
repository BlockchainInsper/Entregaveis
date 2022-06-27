// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "../../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract ERC721Capped is ERC721, Ownable {
    uint _maxSupply;
    uint _totalSupply; 
    uint _mintPrice; 
    bool _openSale;

    constructor(string memory name, string memory symbol, uint64 cap) ERC721(name, symbol){
        _maxSupply = cap; 
        _totalSupply = 0; 
        _openSale = false; 
        _mintPrice = 0;
    }

    function getTotalSupply() public view returns (uint){
        return _totalSupply;
    }

    function getBalance() public view returns (uint){
        return address(this).balance; 
    }

    function _createNFT() internal {
        require(_totalSupply < _maxSupply, "Number of tokens has reached its maximum"); 
        _mint(msg.sender, _totalSupply);
        _totalSupply++;
    }

    function ownerMint() external onlyOwner  {
        _createNFT();
    }

    function publicMint() external payable {
        require((msg.value >= _mintPrice) && _openSale); 
        _createNFT(); 
    }

    function setMintPrice(uint mintPrice) public onlyOwner {
        _mintPrice = mintPrice;
    }

    function openSales(uint mintPrice) public onlyOwner {
        _openSale = true;
        setMintPrice(mintPrice); 
    }

    function closeSales() external onlyOwner {
        _openSale = false;
    }

    function withdraw() public payable onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}

// construtor()	Chamada no deploy, recebe o nome, simbolo e máxima quantidade de tokens
// getTotalSupply()	devolve a quantidade de tokens já feita
// getBalance()	devolve a quantidade de ether depositada no contrato
// _createNFT()	interna, checa se o número atual de tokens não atingiu o limite máximo e cria um novo token
// ownerMint()	Função que apenas pode ser chamada pelo dono, chama _createNFT()
// publicMint()	Função que pode ser chamada por todos, checa se o valor mandado ao contrato é maior que o preço para mintar um NFT, e se a venda esta aberta, chama _createNFT()
// setMintPrice()	Troca o preço do token a ser criado, apenas chamada pelo dono
// openSales()	Possibilita a venda de tokens (mint), chama setMintPrice() com o novo preço, apenas chamada pelo dono
// closeSales()	Impossibilita a venda de tokens (mint), apenas chamada pelo dono
// withdraw()	transfere todo ether no contrato pro dono, só pode ser chamada pelo dono