// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

interface IOracle {
    function getPrice(address token) external view returns (uint256);

    function update(
        address[] calldata tokens,
        uint256[] calldata prices
    ) external;

}


interface IPermit2 {
    function approve(address, address, uint160, uint48) external;
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
 

