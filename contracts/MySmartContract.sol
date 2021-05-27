pragma solidity ^0.5.1;

contract MySmartContract{
    // string public Stringvalue = "myValue";
    // bool public myBool = true;
    // int public myInt = 3;
    // uint public myUint = 1;
    
    // enum State{Waiting,Ready,Active}
    // State public state;
    
    // constructor() public{
    //     state = State.Waiting;
    // }
    
    // function activate() public{
    //     state = State.Active;
    // }
    
    // function isActive() public view returns(bool){
    //     return state == State.Active;
    // }
    
    
    
    
    // Person[] public people;
    uint256 public peopleCount;
    mapping(uint => Person) public people;
    address owner;
    
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    struct Person{
        uint _id;
        string _firstname;
        string _lastname;
    }
    
    constructor() public{
        owner = msg.sender;
        
    }
    
    function addPerson(string memory _firstname,string memory _lastname) public onlyOwner{
        incrementCount();
        people[peopleCount] = Person(peopleCount,_firstname,_lastname);
        
        // people.push(Person(_firstname,_lastname));
        
        
    }
    
    function incrementCount() internal{
        peopleCount += 1;
    }
  
}



