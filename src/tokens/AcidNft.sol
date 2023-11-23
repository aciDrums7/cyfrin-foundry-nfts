// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract AcidNft is ERC721 {
    /**
     * Errors
     */
    error AcidNft__CantSwitchTripIfNotOwner();

    /**
     * Type Declarations
     */
    enum Trip {
        NORMAL,
        HEROIC
    }

    /**
     * State Variables
     */
    string public constant NFT_NAME = "ShroomNFT";
    string public constant SYMBOL = "ACID";

    uint256 private s_tokenCounter;
    string private s_normalSvgImageURI;
    string private s_heroicSvgImageURI;

    mapping(uint256 tokenId => Trip trip) private s_tokenIdToTrip;

    constructor(
        string memory _normalSvgImageURI,
        string memory _heroicSvgImageURI
    ) ERC721(NFT_NAME, SYMBOL) {
        s_tokenCounter = 0;
        s_normalSvgImageURI = _normalSvgImageURI;
        s_heroicSvgImageURI = _heroicSvgImageURI;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToTrip[s_tokenCounter] = Trip.HEROIC;
        s_tokenCounter++;
    }

    function switchTrip(uint256 _tokenId) public {
        // only want the NFT owner to be able to switch the trip
        if (!_isAuthorized(msg.sender, msg.sender, _tokenId)) {
            revert AcidNft__CantSwitchTripIfNotOwner();
        }
        if (s_tokenIdToTrip[_tokenId] == Trip.HEROIC) {
            s_tokenIdToTrip[_tokenId] = Trip.NORMAL;
        } else {
            s_tokenIdToTrip[_tokenId] = Trip.HEROIC;
        }
    }

    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory tokenMetadata) {
        string memory imageURI;
        if (s_tokenIdToTrip[_tokenId] == Trip.HEROIC) {
            imageURI = s_heroicSvgImageURI;
        } else {
            imageURI = s_normalSvgImageURI;
        }
        //? This is needed to get a JSON tokenURI with SVG as imageURI
        tokenMetadata = string.concat(
            _baseURI(),
            Base64.encode(
                abi.encodePacked(
                    '{"name":"',
                    name(), // You can add whatever name here
                    '", "description":"Question authority. Think for yourself.", ',
                    '"attributes": [{"strain_type": "Golden Teacher", "value": 137}], "image":"',
                    imageURI,
                    '"}'
                )
            )
        );
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    /**
     * Getters
     */
    function getTripTypeByTokenId(uint256 _tokenId) public view returns (Trip) {
        return s_tokenIdToTrip[_tokenId];
    }
}
