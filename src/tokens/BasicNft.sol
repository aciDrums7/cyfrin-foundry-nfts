// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {
    string public constant NFT_NAME = "BasicNft";
    string public constant SYMBOL = "ACID";

    uint256 private s_tokenCounter;
    mapping(uint256 tokenId => string tokenUri) private s_tokenIdToUri;

    constructor() ERC721(NFT_NAME, SYMBOL) {
        s_tokenCounter = 0;
    }

    function mintNft(string memory _tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = _tokenUri;
        //? maps token to msg.sender, increase msg.sender token counter etc...
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[_tokenId];
    }
}
