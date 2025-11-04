// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/**
* @title Voting-Based Fund Disbursement (Simulated)
* @notice Contributors contribute simulated amounts. Manager proposes
requests; contributors vote; majority needed to execute.
* @custom:dev-run-script VotingFund.sol
*
* Steps after deployment:
* 1. Deploy contract.
* 2. Account A: contribute(50), Account B: contribute(50).
* 3. Manager: createRequest("Buy tools", 60, recipientAddress).
* 4. Contributors call vote(requestId).
* 5. Manager calls execute(requestId) when votes >= majority
((contributors/2)+1).
* 6. After execute, total fund will reduce by the request amount (simulated).
*/

contract VotingFund {
    address public manager;
    mapping(address => uint) public contributions;
    address[] public contributors;
    uint public total;
    uint public spent;
    struct Request {
        string desc;
        uint amount;
        address recipient;
        uint yes;
        bool executed;
    }
    Request[] public requests;
    mapping(uint => mapping(address => bool)) public voted;
    constructor() {
        manager = msg.sender;
    }
    // Simulate contributing to the fund
    function contribute(uint amount) public {
        require(amount > 0, "amount>0");
        if (contributions[msg.sender] == 0) {
            contributors.push(msg.sender);
        }
        contributions[msg.sender] += amount;
        total += amount;
    }
    // Manager creates a spending request
    function createRequest(
        string memory desc,
        uint amount,
        address recipient
    ) public {
        require(msg.sender == manager, "Only manager");
        require(amount <= total, "Not enough funds");
        requests.push(Request(desc, amount, recipient, 0, false));
    }
    // Contributors vote for the request
    function vote(uint id) public {
        require(contributions[msg.sender] > 0, "must contribute");
        require(id < requests.length, "bad id");
        require(!voted[id][msg.sender], "already voted");
        voted[id][msg.sender] = true;
        requests[id].yes += 1;
    }
    // Manager executes the request if majority approves
    function execute(uint id) public {
        require(msg.sender == manager, "Only manager");
        require(id < requests.length, "bad id");
        Request storage r = requests[id];
        require(!r.executed, "already executed");
        uint needed = (contributors.length / 2) + 1;
        require(r.yes >= needed, "not majority");
        require(total >= r.amount, "Insufficient funds");
        // Mark executed and subtract simulated amount
        r.executed = true;
        total -= r.amount;
        spent += r.amount;
    }
    // Helper functions
    function contributorsCount() public view returns (uint) {
        return contributors.length;
    }
    function requestsCount() public view returns (uint) {
        return requests.length;
    }
}
