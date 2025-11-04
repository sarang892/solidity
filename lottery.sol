// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/**
* @title Decentralized Lottery System (No Wallet / No Ether Needed)
* @notice A simple blockchain-based lottery where users can join with their
names,
* and the manager picks a random winner. Uses Remix's JS VM (no MetaMask
or real ETH).
* @custom:dev-run-script LotterySystem.sol
*
* Steps to run in Remix:
* 1. Go to https://remix.ethereum.org
* 2. Create a new file named `DecentralizedLotterySystem.sol`
* 3. Paste this code and compile it (Solidity 0.8.0 or above)
* 4. Deploy the contract using JavaScript VM (no parameters needed)
* 5. Click `enterLottery` and input "Alice"
* 6. Click again and input "Bob"
* 7. Click again and input "Charlie"
* 8. Call `getPlayers()` → should return ["Alice", "Bob", "Charlie"]
* 9. Call `pickWinner()` → a random winner will be chosen
* 10. Call `winner()` → shows the name of the winner
* 11. Call `resetLottery()` → clears data for a new round
*/

contract LotterySystem {
    address public manager;
    string[] private players;
    string public winner;
    bool public lotteryEnded;
    constructor() {
        manager = msg.sender;
        lotteryEnded = false;
    }
    /// @notice Enter the lottery by providing your name.
    /// @param _name The name of the participant.
    function enterLottery(string memory _name) public {
        require(!lotteryEnded, "Lottery already ended");
        players.push(_name);
    }
    /// @dev Generates a pseudo-random number for winner selection.
    function random() private view returns (uint256) {
        return
            uint256(
                keccak256(abi.encodePacked(block.timestamp, players.length))
            );
    }
    /// @notice Manager picks a random winner from participants.
    function pickWinner() public {
        require(msg.sender == manager, "Only manager can pick winner");
        require(players.length > 0, "No participants yet");
        require(!lotteryEnded, "Lottery already ended");
        uint256 index = random() % players.length;
        winner = players[index];
        lotteryEnded = true;
    }
    /// @notice Returns the list of all participants.
    function getPlayers() public view returns (string[] memory) {
        return players;
    }
    /// @notice Resets the lottery for a new round.
    function resetLottery() public {
        require(msg.sender == manager, "Only manager can reset");
        delete players;
        lotteryEnded = false;
        winner = "";
    }
}
