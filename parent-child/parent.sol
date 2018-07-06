pragma solidity ^0.4.24;

import  "";

contract Parent{
  address owner;

  function Parent(){
    owner = msg.sender;
  }

  function createChild() {
    Child child = new Child()
  }
}