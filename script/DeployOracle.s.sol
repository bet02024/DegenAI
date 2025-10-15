// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "forge-std/Script.sol";
import "../src/Oracle.sol";

contract DeployOracle is Script {
    function run() external {
        // Set these values according to your target network
        vm.startBroadcast();
        Oracle oracle = new Oracle( );
        vm.stopBroadcast();
        console.log("Oracle deployed at: %s", address(oracle));
    }
} 