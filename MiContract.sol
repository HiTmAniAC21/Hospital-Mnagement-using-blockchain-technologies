pragma solidity  ^0.6.0;

contract MiContract{
    
    uint public myUint = 1;
    int public myInt = 1;
    uint256 public muUint = 9000;
    string public MyString = "LOL";
    address public myAddress = 0xCfFF1361E32e45FDB20a2fCcb85D55699B99dB4D;
    
    struct MyStruct{
        uint id;
        string name;
    }
    
    MyStruct public muStruct = MyStruct(1,"HEllo");
    
    function getValue() public pure returns(uint){
        uint value = 1;
        return value;
    }
    
}