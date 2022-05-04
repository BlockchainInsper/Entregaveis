// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract compraSegura{

    address private _comprador;
    address private _vendedor;
    uint256 _valor;

    event Abort(address, uint256);

    enum State {Created, Locked, Release, Inactive}
    State public state;

    constructor (address buyer) payable {
        _comprador = buyer;
        _vendedor = msg.sender;

        _valor = msg.value/2;
        state = State.Created;
    }

    function abort() public {
        require(msg.sender == _vendedor);
        require(state == State.Created);

        state =  State.Inactive;
        
    }

    function confirmPurchase() public {
        require(state == State.Created);

        state = State.Locked;
    }

    function confirmReceived() public {
        require(msg.sender == _comprador);
        require(state == State.Locked);
        state = State.Release;
    }

    function refundSeller() public {
        require(msg.sender == _vendedor);
        require(state == State.Release);

        state = State.Inactive;
        
    }

}