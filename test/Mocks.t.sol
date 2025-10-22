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
    mapping(address => uint256) public prices;
    function update(
        address[] calldata _tokens,
        uint256[] calldata _prices
    ) external{
        for (uint256 i = 0; i < _tokens.length; i++) {
            prices[_tokens[i]] = _prices[i];
        }
    }
    function getPrice(address token) external view override returns (uint256) {
        return prices[token];
    }
}
 

