// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/token/ERC721/ERC721.sol";

contract AcidNft is ERC721 {
    string public constant NFT_NAME = "acidNFT";
    string public constant SYMBOL = "ACID";

    uint256 private s_tokenCounter;

    constructor() ERC721(NFT_NAME, SYMBOL) {
        s_tokenCounter = 0;
    }

    function mintNft() public {}

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        return "";
    }
}
