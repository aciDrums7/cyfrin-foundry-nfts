// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";

contract AcidTrueNft is ERC721 {
    string public constant NFT_NAME = "acidNFT";
    string public constant SYMBOL = "ACID";

    uint256 private s_tokenCounter;
    string private s_normalShrooms;
    string private s_heroicShrooms;

    constructor(
        string memory _normalShrooms,
        string memory _heroicShrooms
    ) ERC721(NFT_NAME, SYMBOL) {
        s_tokenCounter = 0;
        s_normalShrooms = _normalShrooms;
        s_heroicShrooms = _heroicShrooms;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {}
}
