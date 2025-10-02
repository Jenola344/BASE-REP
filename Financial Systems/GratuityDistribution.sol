// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GratuityDistribution {
    event Distribution(address indexed from, address indexed to, uint256 amount, string message);

    function tip(address payable _to, string calldata _message) external payable {
        require(msg.value > 0, "Must send ETH");
        _to.transfer(msg.value);
        emit Distribution(msg.sender, _to, msg.value, _message);
    }
}