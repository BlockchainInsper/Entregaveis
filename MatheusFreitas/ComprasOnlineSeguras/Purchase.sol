pragma solidity >=0.4.15 <0.8.0;


abstract contract FiatContract {
  function ETH(uint _id) public virtual returns (uint256);
  function USD(uint _id) public virtual returns (uint256);
  function EUR(uint _id) public virtual returns (uint256);
  function GBP(uint _id) public virtual returns (uint256);
  function updatedAt(uint _id) virtual public returns (uint);
}

contract Purchase {
    
    FiatContract public price;

     // returns $200.00 USD in ETH wei.
    function TwoHundredETHUSD() public returns (uint256) {
        // returns $0.01 ETH wei
        uint256 ethCent = price.USD(0);
        // $0.01 * 10^7 = $200.00
        return ethCent * 10**7;
    }

    uint value;
    address buyer;
    address seller;

    enum State{ Created, Locked, Released, Inactive }
    State estado;

    function getState() public view returns(State) {
        return estado;
    }

    function setCreated() public {
        estado = State.Created;
    }

    function setLocked() public {
        estado = State.Locked;
    }

    function setReleased() public {
        estado = State.Released;
    }

    function setInactive() public {
        estado = State.Inactive;
    }

    modifier isCreated() {
        require(getState() == State.Created);
        _;
    }

    modifier isLocked() {
        require(getState() == State.Locked);
        _;
    }

    modifier isReleased() {
        require(getState() == State.Released);
        _;
    }

    modifier isInactive() {
        require(getState() == State.Inactive);
        _;
    }

    modifier onlySeller() {
        require(msg.sender == seller);
        _;
    }

    modifier onlyBuyer() {
        require(msg.sender == buyer);
        _;
    }

    event Aborted();
    event PurchaseConfirmed();
    event ItemReceived();
    event SellerRefunded();

    constructor() {
        setCreated();
        value = TwoHundredETHUSD();
    }

    function abort() public onlySeller isCreated {

        address payable _seller = address(uint160(seller));
        _seller.transfer(address(this).balance);

        setInactive();
        emit Aborted();

    }

    function confirmPurchase() public payable isCreated {

        require(msg.value == value);

        setLocked();
        emit PurchaseConfirmed();  

    }

    function confirmReceived() public onlyBuyer isLocked {

        address payable _buyer = address(uint160(buyer));
        _buyer.transfer(address(this).balance/4);

        setReleased();
        emit ItemReceived();

    }

    function refundSeller() public onlySeller isReleased {

        address payable _seller = address(uint160(seller));
        _seller.transfer(address(this).balance*3/4);

        setInactive();
        emit SellerRefunded();

    }

}