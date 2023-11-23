// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {SvgUtils} from "../../src/utils/SvgUtils.sol";
import {DeployAcidNft} from "../../script/DeployAcidNft.s.sol";
import {AcidNft} from "../../src/tokens/AcidNft.sol";

contract DeployAcidNftTest is Test {
    string public constant EXAMPLE_SVG = "./img/svg/example.svg";

    DeployAcidNft public deployer;

    function setUp() public {
        deployer = new DeployAcidNft();
    }

    function test_ConvertSvgToURI() public view {
        string
            memory expectedURI = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHhtbG5zOnhsaW5rPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5L3hsaW5rIiB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCI+CiAgICA8dGV4dCB4PSIwIiB5PSIxNSIgZmlsbD0iYmxhY2siPkhpISBZb3VyIGJyb3dzZXIgZGVjb2RlZCB0aGlzPC90ZXh0Pgo8L3N2Zz4=";
        string memory svg = vm.readFile(EXAMPLE_SVG);
        string memory actualURI = SvgUtils.svgToImageURI(svg);
        assert(
            keccak256(abi.encodePacked(expectedURI)) ==
                keccak256(abi.encodePacked(actualURI))
        );
    }
}
