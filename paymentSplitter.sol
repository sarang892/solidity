// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/**
* @title Payment Splitter (Simulated)
* @notice Splits a provided total among configured receivers and records owed
amounts (no real ETH).
* @custom:dev-run-script Splitter.sol
*
* Steps after deployment:
* 1. Deploy with constructor array of addresses (Remix format) ["ADDRESS
1","ADDRESS 2","ADDRESS 3"].
* 2. Call split(totalAmount) e.g., split(300).
* 3. Each receiver calls myOwed() to view their share.
*/

contract Splitter {
    address[] public receivers;
    mapping(address => uint) public owed;
    constructor(address[] memory _receivers) {
        require(_receivers.length > 0, "need receivers");
        for (uint i = 0; i < _receivers.length; i++) {
            receivers.push(_receivers[i]);
        }
    }
    function split(uint total) public {
        require(total > 0, "total>0");
        uint share = total / receivers.length;
        for (uint i = 0; i < receivers.length; i++) {
            owed[receivers[i]] += share;
        }
    }
    function myOwed() public view returns (uint) {
        return owed[msg.sender];
    }
    function receiversCount() public view returns (uint) {
        return receivers.length;
    }
}
