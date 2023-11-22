// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {AcidNft} from "../src/AcidNft.sol";

contract DeployAcidNft is Script {
    function run() external returns (AcidNft acidNft) {
        vm.startBroadcast();
        acidNft = new AcidNft();
        vm.stopBroadcast();
    }
}
