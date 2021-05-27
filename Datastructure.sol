pragma solidity ^0.6.0;

contract Datastucture{
    mapping(uint => string) public names;
    mapping(uint => book) public books;
    mapping(address => mapping(uint => book)) public myMapping;
    
    struct book{
        string title;
        string auuthor;
    }
    
    
    constructor() public{
        names[1] = "adams";
        names[2] = "Karl";
        names[3] = "ziggs";
    }
    
    
    function addbook(uint _id,string memory _title,string memory _author) public{
        books[_id] = book(_title,_author);
    }
    
    function addMyBook(uint _id,string memory _title,string memory _author) public{
       myMapping[msg.sender][_id] = book(_title,_author);
    }
}