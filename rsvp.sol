// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
/**
* @title Decentralized RSVP & Check-in
* @notice Organizers create event with capacity and fee (simulated).
Attendees RSVP by calling rsvp(amount).
* @custom:dev-run-script RSVP.sol
*
* Steps after deployment:
* 1. Deploy with args: capacity (e.g., 3), fee (e.g., 10).
* 2. Attendees call rsvp(fee) (simulated).
* 3. Call rsvpCount() to view number of RSVPs.
* 4. Organizer calls checkIn(attendeeAddress) to mark attendance (emits
event).
* 5. Call isAttending(address) to verify RSVP.
*/

contract RSVP {
    address public organizer;
    uint public capacity;
    uint public fee;
    uint public rsvps;
    mapping(address => bool) public attending;
    event RSVPed(address who);
    constructor(uint _capacity, uint _fee) {
        organizer = msg.sender;
        capacity = _capacity;
        fee = _fee;
        rsvps = 0;
    }
    function rsvp(uint amount) public {
        require(amount == fee, "pay exact fee");
        require(rsvps < capacity, "full");
        require(!attending[msg.sender], "already RSVP'd");
        attending[msg.sender] = true;
        rsvps += 1;
        emit RSVPed(msg.sender);
    }
    function isAttending(address a) public view returns (bool) {
        return attending[a];
    }
    function rsvpCount() public view returns (uint) {
        return rsvps;
    }
    function checkIn(address attendee) public view returns (bool) {
        require(msg.sender == organizer, "only organizer");
        return attending[attendee];
    }
}
