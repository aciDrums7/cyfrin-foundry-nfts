// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {AcidNft} from "../src/AcidNft.sol";
import {AcidSvgNft} from "../src/AcidSvgNft.sol";

contract MintAcidNft is Script {
    string public constant SHROOMS =
        "ipfs://bafybeiasw3kn6a2vm2jbxy5dsdpb6zpzcxbxmcqdnc7mylqegyrkfenpiy/";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "AcidNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        AcidNft(mostRecentlyDeployed).mintNft(SHROOMS);
        vm.stopBroadcast();
    }
}

contract MintAcidSvgNft is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "AcidSvgNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        AcidSvgNft(mostRecentlyDeployed).mintNft();
        vm.stopBroadcast();
    }
}
