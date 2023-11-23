// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {AcidNft} from "../src/tokens/AcidNft.sol";

contract DeployAcidNft is Script {
    string public constant NORMAL_TRIP_SVG_PATH = "./img/svg/normal.svg";
    string public constant HEROIC_TRIP_SVG_PATH = "./img/svg/heroic.svg";

    function svgToImageURI(
        string memory _svgPath
    ) public view returns (string memory) {
        string memory baseURI = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            abi.encodePacked(vm.readFile(_svgPath))
        );
        return string.concat(baseURI, svgBase64Encoded);
    }

    function run() external returns (AcidNft acidNft) {
        string memory heroicImageURI = svgToImageURI(HEROIC_TRIP_SVG_PATH);
        string memory normalImageURI = svgToImageURI(NORMAL_TRIP_SVG_PATH);
        vm.startBroadcast();
        acidNft = new AcidNft(normalImageURI, heroicImageURI);
        vm.stopBroadcast();
    }
}
