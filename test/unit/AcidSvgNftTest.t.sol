// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {AcidSvgNft} from "../../src/AcidSvgNft.sol";
import {DeployAcidSvgNft} from "../../script/DeployAcidSvgNft.s.sol";

contract AcidNftTest is Test {
    DeployAcidSvgNft public deployer;
    AcidSvgNft public acidSvgNft;

    address public USER = makeAddr("user");
    string public constant SHROOMS =
        "ipfs://bafybeiasw3kn6a2vm2jbxy5dsdpb6zpzcxbxmcqdnc7mylqegyrkfenpiy/";

    function setUp() public {
        deployer = new DeployAcidSvgNft();
        acidSvgNft = deployer.run();
    }

    function test_ViewTokenURI() public {
        vm.prank(USER);
        acidSvgNft.mintNft();
        console.log(acidSvgNft.tokenURI(0));
    }
}
