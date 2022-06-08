// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ERC721Capped is ERC721, Ownable {

    uint64 _cap;

    string private _name;
    string private _symbol;

    uint mintPrice;
    uint64 issued;
    bool canMint;

    constructor(string memory name, string memory symbol, uint64 cap) ERC721(name, symbol) {
        _name = name;
        _symbol = symbol;
        _cap = cap;

        canMint = false;
        mintPrice = 0;
        issued = 0;
    }

    function getTotalSupply() public view returns (uint64) {
        return issued;
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function _createNFT(address to) internal {
        require(issued < _cap);
        issued++;
        _mint(to, issued);
    }

    function ownerMint() public onlyOwner {
        _createNFT(address(uint160(owner())));  // NFT pro owner
        // _createNFT(address(this));  // NFT pro contrato
    }

    function publicMint() public payable {
        require(msg.value >= mintPrice);
        require(canMint);
        _createNFT(msg.sender);
    }

    function setMintPrice(uint _price) public onlyOwner {
        mintPrice = _price;
    }
 
    function openSales(uint newPrice) public onlyOwner {
        setMintPrice(newPrice);
        canMint = true;
    }

    function closeSales() public onlyOwner {
        canMint = false;
    }

    function withdraw() external onlyOwner {
        address payable _owner = payable(address(uint160(owner())));
        _owner.transfer(address(this).balance);
    }

}