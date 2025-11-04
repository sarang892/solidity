// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WalletSim {
    mapping(address => uint) public balance;

    event Deposited(address indexed who, uint amount);
    event Withdrawn(address indexed who, uint amount);
    event Transferred(address indexed from, address indexed to, uint amount);

    function deposit(uint amount) public {
        require(amount > 0, "amount>0");
        balance[msg.sender] += amount;
        emit Deposited(msg.sender, amount);
    }

    function withdraw(uint amount) public {
        require(balance[msg.sender] >= amount, "insufficient");
        balance[msg.sender] -= amount;
        emit Withdrawn(msg.sender, amount);
    }

    function transferTo(address to, uint amount) public {
        require(balance[msg.sender] >= amount, "insufficient");
        balance[msg.sender] -= amount;
        balance[to] += amount;
        emit Transferred(msg.sender, to, amount);
    }

    function myBalance() public view returns (uint) {
        return balance[msg.sender];
    }
}
