// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Destruct {
    function destruct() public payable {
        address payable addr = payable(address(0x39d6896375E92216ab47B9c3c7Ee9EF47d4de6f5));
        selfdestruct(addr);
    }
}

// a interação com a função destruct foi feita via Remix IDE, logo não há codigo para isso
