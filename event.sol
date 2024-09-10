// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract EventOrganisation{
       struct Event{
          address organiser;
          string name;
          uint date;
          uint price;
          uint ticketCount;
          uint ticketRemain;
       } 

 mapping (uint=>Event) public  events;
 mapping(address=>mapping(uint=>uint)) public tickets;
 uint public nextid;

 function createEvent(string memory name,uint date,uint price,uint ticketCount) external {
    require(block.timestamp<date,"you can only create future date events");
    require(ticketCount>0,"ticketcount must be greater than zero");

    events[nextid]=Event(msg.sender,name,date,price,ticketCount,ticketCount);
    nextid++;
 }


}