// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/**
* @title Rental Agreement DApp (Simple)
* @notice Records a rental agreement, allows tenant to pay simulated rent,
owner to set tenant, and log disputes.
* @custom:dev-run-script Rental.sol
*
* Steps after deployment:
* 1. Deploy with args: tenantAddress (address), rentPerMonth (uint).
* 2. Owner (deployer) may call setTenant(newAddress).
* 3. As tenant account call payRent(amount) with amount == rentPerMonth.
* 4. Call tenantPaid() to view total paid by tenant.
* 5. Owner/tenant can call raiseDispute("text") to log disputes (stored).
* 6. Call getDisputeCount() and getDispute(i) to view disputes.
*/

contract RentalAgreement {
    address public owner;
    address public tenant;
    uint public rentPerMonth;
    mapping(address => uint) public paid;
    struct Dispute {
        address raisedBy;
        string message;
        uint timestamp;
    }
    Dispute[] public disputes;
    event RentPaid(address who, uint amount);
    event TenantChanged(address newTenant);
    event DisputeRaised(address who, string message);
    constructor(address _tenant, uint _rentPerMonth) {
        owner = msg.sender;
        tenant = _tenant;
        rentPerMonth = _rentPerMonth;
    }
    function setTenant(address newTenant) public {
        require(msg.sender == owner, "Only owner");
        tenant = newTenant;
        emit TenantChanged(newTenant);
    }
    function payRent(uint amount) public {
        require(msg.sender == tenant, "Only tenant");
        require(amount == rentPerMonth, "Pay exact rent");
        paid[msg.sender] += amount;
        emit RentPaid(msg.sender, amount);
    }
    function tenantPaid() public view returns (uint) {
        return paid[tenant];
    }
    function raiseDispute(string memory message) public {
        disputes.push(Dispute(msg.sender, message, block.timestamp));
        emit DisputeRaised(msg.sender, message);
    }
    function getDisputeCount() public view returns (uint) {
        return disputes.length;
    }
    function getDispute(
        uint i
    ) public view returns (address, string memory, uint) {
        require(i < disputes.length, "bad index");
        Dispute storage d = disputes[i];
        return (d.raisedBy, d.message, d.timestamp);
    }
}
