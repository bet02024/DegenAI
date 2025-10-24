// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "forge-std/Script.sol";
import "../src/PythOracle.sol";

contract DeployOracle is Script {
    function run() external {
        // Set these values according to your target network
        vm.startBroadcast();
        
        // Pyth Network contract addresses:
        // arbitrum 0xff1a0f4744e8582DF1aE09D5611b887B6a12925C
        // optimism 0xff1a0f4744e8582DF1aE09D5611b887B6a12925C
        // hype 0xe9d69CdD6Fe41e7B621B4A688C5D1a68cB5c8ADc
        // avalanche 0x4305FB66699C3B2702D4d05CF36551390A4c69C6


        PythOracle oracle = new PythOracle(0xff1a0f4744e8582DF1aE09D5611b887B6a12925C);
        vm.stopBroadcast();
        console.log("Oracle deployed at: %s", address(oracle));
    }
} 