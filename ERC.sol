pragma solidity ^0.4.24;

contract ERC
{   
    function () public payable;
    function totalSupply() public constant returns(uint);
    function balanceOf(address person) public constant returns (uint);
    function transfer(address, uint ) public returns (bool);
    function transferFrom(address, address, uint ) public returns (bool);
    function approve(address, uint) public returns (bool);
    
    event Transfer(address, address, uint256);
    event Approval(address, address, uint256);
    
}

contract ERC20 is ERC
{
    string public constant name = "Monty Token";
    string public constant symbol = "MTT";
    uint public constant maxcoins = 2000000000;
    address owner;
    uint starttime;
    uint constant timelimit=3 minutes;
    uint supply;
    mapping(address=>uint) balancemap;
    mapping(address=>mapping(address=>uint)) aprrovedmoney;
    
    constructor() public {
        owner = msg.sender;   
        starttime = now;
        supply=0;
    }
    
    modifier checkOwner() {
        require(owner==msg.sender,"Only owner allowed");
     _;
    }
    
    modifier checkTime() {
        require(now<=starttime+timelimit,"ICO Finised");
    _;    
    }
    
    function totalSupply() checkOwner public view returns(uint) {
        return supply;
    }
    
    function balanceOf(address person) checkOwner public view returns(uint) {
        return balancemap[person];
    }
    
    function () public payable {
        address(this).send(msg.value);
        balancemap[msg.sender]= msg.value;
        supply+=msg.value;
    }        
    
    function transfer(address to,uint value) checkTime public returns(bool) {
        if(balancemap[msg.sender]>= value) {
            balancemap[msg.sender]-=value;
            balancemap[to]+=value;
            emit Transfer(msg.sender,to,value);
            return true;
        }
        else {
            return false;
        }
    }
    
    function transferFrom(address from,address to,uint value) checkTime public returns(bool) {
        if(aprrovedmoney[from][to]>=value) {
            aprrovedmoney[from][to]-=value;
            balancemap[from]-=value;
            balancemap[to]+=value;
            emit Transfer(from,to,value);
            return true;
        }
        else {
            return false;
        }    
        
    }
    
    function approve(address person,uint value) checkTime public returns(bool) {
        if(balancemap[msg.sender]>value) {
            aprrovedmoney[msg.sender][person]=value;
            emit Approval(msg.sender,person,value);
            return true;
        }
        else {
            return false;
        }
    }
    
}
