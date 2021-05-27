pragma solidity ^0.6.0;

contract Counter{
    uint count=0;
    
    function getCount() public view returns(uint) {
        return count;
    }
    
    function incermentCount() public {
        count += 1;
    }
}

