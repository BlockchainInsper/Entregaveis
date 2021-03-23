pragma solidity >=0.5.11 <0.7.0;

contract Purchase{
    
    //Variaveis
    address payable owner;
    uint public valorProduto;
    enum State { Created, Locked, Released, Inactive}
    State public state;
    address payable buyer;
    
    //Events
    event Aborted(address _owner);
    event PurchaseConfirmed(address _buyer, address _owner, uint _totalValue);
    event itemReceived(address _buyer);
    event sellerRefounded(address _seller);
    
    //valor de cada endereco
    mapping (address => uint) balanceOf;
    
    constructor() public {
        owner = msg.sender;
        state = State.Created;
    }
    
    // garante que o dono modifica as coisas
     modifier isOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }
    
    // valor é o dobro do produto
     modifier dobroValorProduto() {
        require(msg.value == valorProduto * 2);
        _;
    }
    
    function Abort() public isOwner{
        require(state == State.Created);
        
        // mudar o estado
        state = State.Inactive;
        
        // devolvendo dinheiro ao vendedor
        owner.transfer(balanceOf[owner]);
        emit Aborted(owner);
    }
    
    // Deve ser chamada antes de confirmPurchase
    // Decide qual o valor do produto
    function setValue(uint _value) public isOwner {
        require(state == State.Created);
        valorProduto = _value;
    }
    
    function ownerMoneyToContract() public payable isOwner dobroValorProduto {
        require (state == State.Created);
        balanceOf[owner] += msg.value;
    }
    
    function confirmPurchase() public payable dobroValorProduto {
        require(state == State.Created && msg.sender != owner);
        
        // guardar quantia depositada
        buyer = msg.sender;
        balanceOf[buyer] += msg.value;
        
        // mudar o estado
        state = State.Locked;
        
        // emite o evento de compra
        emit PurchaseConfirmed(buyer, owner, msg.value);
    }
    
    function confirmReceived() public payable {
        require(msg.sender == buyer && state == State.Locked);
        // muda o estado
        state = State.Released;
        
        // tranfere 1/4 do total de volta ao consumidor
        buyer.transfer(balanceOf[buyer]/2);
        balanceOf[buyer] -= balanceOf[buyer]/2;
        
        emit itemReceived(buyer);
    }
    
    function refundSeller() public payable isOwner {
        require(state == State.Released);
        
        //transfere o restante para o vendedor
        owner.transfer(balanceOf[buyer] + balanceOf[owner]);
        state = State.Inactive;
        
        emit sellerRefounded(owner);
    }
    
    
}


