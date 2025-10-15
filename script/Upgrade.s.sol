// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import "src/DegenAiPool.sol";

import {Upgrades} from "@openzeppelin-foundry-upgrades/Upgrades.sol";	
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";

contract Upgrade is Script {
     function run() external {

        address proxyAddress = 0xc79AB5D4544E50Db86061cF34908Ea42ADc2EDda;
        vm.startBroadcast();
        Upgrades.upgradeProxy(proxyAddress, "DegenAiPool.sol:DegenAiPool", "");
        vm.stopBroadcast();
        console.log("Proxy upgraded:");
    }
}