// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

import {IOracle, IPermit2} from "../src/DegenAiPool.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

contract ERC20Mock is ERC20Upgradeable {
    constructor(address initialAccount, uint256 initialBalance) {
        _mint(initialAccount, initialBalance);
    }

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}

contract MockPermit2 is IPermit2 {
    function approve(address, address, uint160, uint48) external override {}
}

 contract MockOracle is IOracle {
     function  getPrices(
        bytes32[] memory tokenPricesId,
        bytes[] calldata pythUpdateData
    ) external virtual payable returns (uint256[] memory){}
}
 

