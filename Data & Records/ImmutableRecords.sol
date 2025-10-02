// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ImmutableRecords {
    event RecordSaved(address indexed author, uint256 indexed id, string text, uint256 timestamp);

    struct Record { address author; string text; uint256 timestamp; }
    mapping(uint256 => Record) public Records;
    uint256 public nextId;

    function save(string calldata text) external {
        Records[nextId] = Record(msg.sender, text, block.timestamp);
        emit RecordSaved(msg.sender, nextId, text, block.timestamp);
        nextId++;
    }

    function get(uint256 id) external view returns (Record memory) {
        return Records[id];
    }
}