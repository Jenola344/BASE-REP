// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AchievementToken is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;

    constructor() ERC721("AchievementToken", "ANFT") Ownable(msg.sender) {}

    function mintAchievement(address _to, string calldata _tokenURI) external {
        _mint(_to, nextTokenId);
        _setTokenURI(nextTokenId, _tokenURI);
        nextTokenId++;
    }
}