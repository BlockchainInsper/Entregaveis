// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vazio {

    function destroy(address payable addrs) public payable {
        address payable addr = payable(address(addrs));
        selfdestruct(addr);
    }

    fallback() payable external {}
    receive() payable external {}
}
// 0x34E522e29aEeB5a897d1A74765dc7291fA7b9e62