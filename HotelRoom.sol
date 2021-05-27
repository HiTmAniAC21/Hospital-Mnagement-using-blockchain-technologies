pragma solidity ^0.6.0;

contract HotelRoom{
    
    enum Statuses { Vaccant , Occupied }
    Statuses currentStatus;
    
    event Occupy(address _Occupant,uint _value);
    
    address payable public owner;
    constructor() public{
        owner = msg.sender;
        currentStatus = Statuses.Vaccant;
    }
    
    modifier onlyWhileVaccant{
            require(currentStatus == Statuses.Vaccant,"Currently Occupied");
            _;
    }
    
    modifier pmnt(uint _amount){
            require(msg.value>= 2 ether,"Transaction incompltet");
            _;
            
    }
    
    
    receive() external payable onlyWhileVaccant pmnt(2 ether){
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
    }
}