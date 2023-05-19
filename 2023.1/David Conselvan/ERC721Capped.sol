// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract ERC721Capped is ERC721, Ownable {
    uint64 totalCap;
   
    uint64 supply = 0;
    uint mintPrice;
    bool mintable = false;

    constructor(string memory _name, string memory _symbol, uint64 _cap) ERC721(_name, _symbol) {
        totalCap = _cap;
    }

    function getTotalSupply() public view returns (uint64) {
        return supply;
    }

    function getBalance() public view returns (uint256){
        return address(this).balance;
    }

    function _createNFT(address _to) internal {
        require(supply < totalCap);
        supply++;
        _mint(_to, supply);
    }

  
    function ownerMint() public onlyOwner{
        _createNFT(msg.sender);
    }

    function publicMint() public payable{
        require(msg.value >= mintPrice);
        require(mintable);
        _createNFT(msg.sender);
    }

    function setMintPrice(uint _newPrice) public onlyOwner {
        mintPrice = _newPrice;
    }

    function openSales(uint _newPrice) public onlyOwner {
        mintable = true;
        setMintPrice(_newPrice);
    }

    function closeSales() public onlyOwner {
        mintable = false;
        
    }

    function withdraw() external onlyOwner {
        address payable _owner = payable(address(owner()));
        _owner.transfer(address(this).balance);
    }
}
