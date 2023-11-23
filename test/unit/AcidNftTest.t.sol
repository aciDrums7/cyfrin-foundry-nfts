// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {SvgUtils} from "../../src/utils/SvgUtils.sol";
import {DeployAcidNft} from "../../script/DeployAcidNft.s.sol";
import {AcidNft} from "../../src/tokens/AcidNft.sol";

contract AcidNftTest is Test {
    string public constant NORMAL_TRIP_SVG_PATH = "../img/svg/normal.svg";
    string public constant HEROIC_TRIP_SVG_PATH = "./img/svg/heroic.svg";
    AcidNft public acidNft;

    address public USER = makeAddr("user");

    function setUp() public {
        acidNft = new AcidNft(
            SvgUtils.svgToImageURI(NORMAL_TRIP_SVG_PATH),
            SvgUtils.svgToImageURI(HEROIC_TRIP_SVG_PATH)
        );
    }

    function test_ViewTokenURI() public {
        vm.prank(USER);
        acidNft.mintNft();
        console.log(acidNft.tokenURI(0));
    }
}
