// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public arbiter;
    address public depositor;
    address public beneficiary;
    uint256 public bal;
    event Approved(uint);

    constructor(address _arbiter, address _beneficiary) payable {
        arbiter = _arbiter;
        depositor = msg.sender;
        beneficiary = _beneficiary;
        bal = address(this).balance;
    }

    function approve() external {
        assert(msg.sender == arbiter);
        (bool s, ) = beneficiary.call{ value: address(this).balance}("");
        require(s);
        emit Approved(bal);
    }
}
