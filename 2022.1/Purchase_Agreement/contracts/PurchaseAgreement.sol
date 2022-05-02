// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract PurchaseAgreement {
    
    uint value;
    address payable public seller;
    address payable public buyer;

    
    enum State { Created, Locked, Release, Inactive }
    State public state;

   //este construtor determina que aquele que chamar o contrato sera o vendedor e que o custo do item sera metade do valor enviado, a outra parte servira como garantia
    constructor() payable {
        seller = payable(msg.sender);
        value = msg.value / 2;
    }

    //abaixo estao os erros para cada instante especifico
    
    /// A função nao pode ser chamada no estado atual
    error InvalidState();
    ///Only the buyer can call this function
    error OnlyBuyer();
    ///Only the seller can call this function
    error OnlySeller();

    //este modificador so permite que a função seja executada se esta estiver no estado correto
    modifier inState(State _state) {
        if(state != _state) {
            revert InvalidState();
        }
        _;
    }

    // modificador que garante que so o comprador pode executar as ações 
    modifier onlyBuyer() {
        if(msg.sender != buyer) {
            revert OnlyBuyer();
        }
        _;
    }

    //modificador que garante que somente o vendedor pode executar as ações 
    modifier onlySeller() {
        if(msg.sender != seller) {
            revert OnlySeller();
        }
        _;
    }

    //esta função só pode ser executada por alguem de fora do contrat(no caso o comprador) e serve para armazenar o valor mais o extra de garantia
    function confirmPurchase() external inState(State.Created) payable {
        require(msg.value == (2 * value), "Please send in 2x the purchease amount");
        buyer = payable(msg.sender);
        state = State.Locked;
    }

    //esta função serve para que quando o comprador receba seu item comprado, ele possa retirar o valor extra que foi como garantia
    function confirmReceived() external onlyBuyer inState(State.Locked) {
        state = State.Release;
        buyer.transfer(value);
    }

    //esta função serve para que apos o comprador receber seu item, o vendedor possa retirar o valor de garantia mais o custo do item
    function paySeller() external onlySeller() inState(State.Release){
        state = State.Inactive;
        seller.transfer(3 * value);
    }

    //esta função serve para que caso o comprador desista de comprar o item, o vendedor possa rertirar seu dinehiro
    function abort() external onlySeller inState(State.Created) {
        state = State.Inactive;
        seller.transfer(address(this).balance); 
        }
}