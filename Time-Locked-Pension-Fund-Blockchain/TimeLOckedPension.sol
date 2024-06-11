// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC20.sol";

contract TimeLockedWallet {

    address public creator;
    address public owner;
    uint256 public unlockDate;
    uint256 public createdAt;
    uint256 public balance;

    // modifier onlyOwner {
    //     require(msg.sender == owner);
    //     _;
    // }

   constructor(uint256 _unlockDate, uint256 _balance) {
        creator = msg.sender;
        unlockDate = _unlockDate;
        createdAt = block.timestamp;
        balance = _balance;
    }

    // keep all the ether sent to this address
    function sendmoney(uint256 value) public {  
        balance = balance + value;
    }
    
    // callable by owner only, after specified time
    function withdraw() public {
       require(msg.sender == owner,"You are not the owner");
       require(block.timestamp >= unlockDate);
       //now send all the balance
       msg.sender.transfer(this.balance);
       Withdrew(msg.sender, this.balance);
    }

    // callable by owner only, after specified time, only for Tokens implementing ERC20
    function withdrawTokens(address _tokenContract) public {
       require(msg.sender >= owner);
       require(block.timestamp >= unlockDate);
       ERC20 token = ERC20(_tokenContract);
       //now send all the token balance
       uint256 tokenBalance = token.balanceOf(this);
       token.transfer(owner, tokenBalance);
       WithdrewTokens(_tokenContract, msg.sender, tokenBalance);
    }

    function info() public view returns(address, address, uint256, uint256, uint256) {
        return (creator, owner, unlockDate, createdAt, this.balance);
    }

    event Received(address from, uint256 amount);
    event Withdrew(address to, uint256 amount);
    event WithdrewTokens(address tokenContract, address to, uint256 amount);
}
