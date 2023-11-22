// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {AcidNft} from "../../src/AcidNft.sol";
import {DeployAcidNft} from "../../script/DeployAcidNft.s.sol";

contract AcidNftTest is Test {
    DeployAcidNft public deployer;
    AcidNft public acidNft;

    address public USER = makeAddr("user");
    string public constant SHROOMS =
        "ipfs://bafybeiasw3kn6a2vm2jbxy5dsdpb6zpzcxbxmcqdnc7mylqegyrkfenpiy/";

    function setUp() public {
        deployer = new DeployAcidNft();
        acidNft = deployer.run();
    }

    function test_NameIsCorrect() public view {
        string memory expectedName = acidNft.NFT_NAME();
        string memory actualName = acidNft.name();
        //? string -> array of bytes
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function test_CanMintAndHaveABalance() public {
        vm.prank(USER);
        acidNft.mintNft(SHROOMS);

        assert(acidNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(SHROOMS)) ==
                keccak256(abi.encodePacked(acidNft.tokenURI(0)))
        );
    }
}
