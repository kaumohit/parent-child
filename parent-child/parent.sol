pragma solidity ^0.4.24;

import  "https://github.com/kaumohit/parent-child/parent-child/Child.sol ";

contract Parent{
  address owner;

  function Parent(){
    owner = msg.sender;
  }

  function createChild() {
    Child child = new Child();
  }
}