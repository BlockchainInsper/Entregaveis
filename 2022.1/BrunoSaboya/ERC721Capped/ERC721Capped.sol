// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract ERC721Capped is ERC721{

    uint _maxSupply;
    uint _mintPrice;
    bool _openMint; 
    uint _currentSupply;
    address owner;

    constructor(string memory name, string memory symbol, uint64 cap) ERC721(name, symbol) {
        _maxSupply = cap;
        _openMint = false;
        owner = msg.sender;
    }
    modifier onlyOwner {
      require(msg.sender == owner);
      _;
   }

    function getTotalSupply() public view returns(uint) {
        return _currentSupply;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;   
    }

    function _createNFT() internal  {
        require(_currentSupply < _maxSupply);
        _safeMint(msg.sender, _currentSupply);
        _currentSupply++;
    }

    function ownerMint() external onlyOwner {
        _createNFT();
    }
    
    function publicMint() external payable{
        require(msg.value >= _mintPrice && _openMint);
        _createNFT();
    }

    function setMintPrice(uint Price) public onlyOwner {
        _mintPrice = Price;
    }

    function openSales(uint Price) external onlyOwner {
        _openMint = true;
        setMintPrice(Price);
    }

    function closeSales() external onlyOwner {
        _openMint = false;
    }

    function withdraw() external payable onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}