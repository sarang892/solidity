// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/**
 * @title Supply Chain Management (Simple)
 * @notice Add items and update status for traceability. Minimal example.
 * @custom:dev-run-script SupplyChain.sol
 *
 * Steps after deployment:
 * 1. Deploy contract.
 * 2. Call addItem("ItemA") -> id 0.
 * 3. Call updateStatus(0, "Shipped").
 * 4. Call getItem(0) -> returns name, status, timestamp.
 */

contract SupplyChain {
    struct Item {
        string name;
        string status;
        uint updatedAt;
    }
    mapping(uint => Item) public items;
    uint public nextId;
    event ItemAdded(uint id, string name);
    event StatusUpdated(uint id, string status);
    function addItem(string memory name) public {
        items[nextId] = Item(name, "Created", block.timestamp);
        emit ItemAdded(nextId, name);
        nextId++;
    }
    function updateStatus(uint id, string memory status) public {
        require(bytes(items[id].name).length != 0, "no item");
        items[id].status = status;
        items[id].updatedAt = block.timestamp;
        emit StatusUpdated(id, status);
    }
    function getItem(
        uint id
    ) public view returns (string memory, string memory, uint) {
        Item storage it = items[id];
        return (it.name, it.status, it.updatedAt);
    }
}
