// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {SvgUtils} from "../src/utils/SvgUtils.sol";
import {AcidNft} from "../src/tokens/AcidNft.sol";

contract DeployAcidNft is Script {
    string public constant NORMAL_TRIP_SVG_PATH = "../img/svg/normal.svg";
    string public constant HEROIC_TRIP_SVG_PATH = "./img/svg/heroic.svg";

    function run() external returns (AcidNft acidNft) {
        vm.startBroadcast();
        acidNft = new AcidNft(
            SvgUtils.svgToImageURI(NORMAL_TRIP_SVG_PATH),
            SvgUtils.svgToImageURI(HEROIC_TRIP_SVG_PATH)
        );
        vm.stopBroadcast();
    }
}
