// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/tokens/BasicNft.sol";
import {AcidNft} from "../src/tokens/AcidNft.sol";

contract MintBasicNft is Script {
    string public constant SHROOMS =
        "ipfs://bafybeiasw3kn6a2vm2jbxy5dsdpb6zpzcxbxmcqdnc7mylqegyrkfenpiy/";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        BasicNft(mostRecentlyDeployed).mintNft(SHROOMS);
        vm.stopBroadcast();
    }
}

contract MintAcidNft is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "AcidNft",
            block.chainid
        );
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        AcidNft(mostRecentlyDeployed).mintNft();
        vm.stopBroadcast();
    }
}

contract SwitchTrip is Script {
    uint256 public constant TOKEN_ID_TO_SWITCH = 0;

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "AcidNft",
            block.chainid
        );
        switchTripOnContract(mostRecentlyDeployed);
    }

    function switchTripOnContract(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        AcidNft(mostRecentlyDeployed).switchTrip(TOKEN_ID_TO_SWITCH);
        vm.stopBroadcast();
    }
}
