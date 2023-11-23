// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
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

    function test_ViewTokenURI() public {
        vm.prank(USER);
        acidNft.mintNft();
        console.log(acidNft.tokenURI(0));
    }
}
