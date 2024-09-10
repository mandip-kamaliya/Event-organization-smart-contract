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
 function Buytickets(uint id,uint quantity) external payable{
   require(events[id].date!=0,"event does not exists");
   require(events[id].date>block.timestamp,"event is expired");
   Event storage _event=events[id];
   require(msg.value==(_event.price*quantity),"Ethers is not enough");
   require(_event.ticketRemain>=quantity,"not enough tickets available");
   _event.ticketRemain-=quantity;
   tickets[msg.sender][id]+=quantity; 
 }
 function Transfertickets(uint id,uint quantity,address to) external payable {
   require(events[id].date!=0,"event does not exits");
   require(events[id].date>block.timestamp,"event is already comleted");
   require(tickets[msg.sender][id]>=quantity,"dont have enough tickets to transfer");

   tickets[msg.sender][id]-=quantity;
   tickets[to][id]+=quantity;
 } 

}