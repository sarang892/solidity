// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/// @title Simple Decentralized Crowdfunding Platform
/// @notice A lightweight crowdfunding contract using virtual balances (no real Ether).
/// @dev Works in Remix with JavaScript VM, no MetaMask needed.
/// @custom:dev-run-script
/// 1. Deploy the contract.
/// 2. Call contribute(200) from different accounts (use Account switch in Remix).
/// 3. Call getDetails() to see total funds.
/// 4. If target met, manager calls markGoalReached().
/// 5. If not met and deadline passed, contributors call refund().

contract SimpleCrowdfunding {
    address public manager;
    uint256 public target;
    uint256 public deadline;
    uint256 public totalRaised;
    bool public goalReached;
    mapping(address => uint256) public contributions;
    constructor(uint256 _target, uint256 _durationMinutes) {
        manager = msg.sender;
        target = _target;
        deadline = block.timestamp + (_durationMinutes * 1 minutes);
        goalReached = false;
    }
    /// @notice Allows users to contribute a fake amount (no real Ether used)
    function contribute(uint256 amount) public {
        require(block.timestamp < deadline, "Campaign ended");
        contributions[msg.sender] += amount;
        totalRaised += amount;
    }
    /// @notice Returns basic campaign details
    function getDetails()
        public
        view
        returns (
            uint256 _target,
            uint256 _deadline,
            uint256 _totalRaised,
            bool _goalReached
        )
    {
        return (target, deadline, totalRaised, goalReached);
    }
    /// @notice Manager marks the goal as reached manually
    function markGoalReached() public {
        require(msg.sender == manager, "Only manager");
        require(totalRaised >= target, "Target not reached yet");
        goalReached = true;
    }
    /// @notice Contributors can refund if goal not met and deadline passed
    function refund() public {
        require(block.timestamp >= deadline, "Deadline not passed");
        require(!goalReached, "Goal reached - no refunds");
        uint256 amount = contributions[msg.sender];
        require(amount > 0, "No funds to refund");
        contributions[msg.sender] = 0;
        // simulate refund by resetting balance
    }
    /// @notice Test helper
    function testRun() public pure returns (string memory) {
        return "Contract running fine";
    }
}
