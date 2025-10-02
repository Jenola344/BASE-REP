// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TemporalVault {
    struct Vault {
        address owner;
        uint256 unlockTime;
        uint256 amount;
    }

    mapping(uint256 => Vault) public vaults;  // Fixed: Correct struct name
    uint256 public nextVaultId;  // Fixed: Renamed to avoid shadowing

    function createVault(uint256 _unlockTime) external payable {
        require(msg.value > 0, "Send ETH");
        require(_unlockTime > block.timestamp, "Time must be future");

        vaults[nextVaultId] = Vault(msg.sender, _unlockTime, msg.value);
        nextVaultId++;
    }

    function withdrawCapsule(uint256 _id) external {
        Vault storage cap = vaults[_id];  // Fixed: Correct struct name
        require(msg.sender == cap.owner, "Not owner");
        require(block.timestamp >= cap.unlockTime, "Too early");

        uint256 amount = cap.amount;
        cap.amount = 0;
        payable(msg.sender).transfer(amount);
    }
}