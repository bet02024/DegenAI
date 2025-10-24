// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@pythnetwork/pyth-sdk-solidity/IPyth.sol";
import "@pythnetwork/pyth-sdk-solidity/PythStructs.sol";
import "@pythnetwork/pyth-sdk-solidity/PythUtils.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";


/**
 * @title Oracle
 * @dev Price oracle using Pyth network as data source
 * @notice All prices are based on USDC with 6 decimals
 */
contract PythOracle {
    
      IPyth pyth;

    constructor(address pythContract) {
            pyth = IPyth(pythContract);
    }

    /**
     * @dev Updates prices for multiple tokens
     * @param tokenPricesId Array of token Prices Ids to get the prices
     * @param pythUpdateData pythUpdateData to update the prices
     */

    
    function getPrices(
        bytes32[] memory tokenPricesId,
        bytes[] calldata pythUpdateData
    ) external payable returns (uint256[] memory) {  

        uint256 updateFee = pyth.getUpdateFee(pythUpdateData);
        pyth.updatePriceFeeds{value: updateFee}(pythUpdateData);

        uint256[] memory prices = new uint256[](tokenPricesId.length); 

        for (uint256 i = 0; i < tokenPricesId.length; i++) {
            PythStructs.Price memory currentPrice = pyth.getPriceNoOlderThan(
                tokenPricesId[i],
                60
            );
            prices[i] = PythUtils.convertToUint(currentPrice.price, currentPrice.expo, 18); // all prices are in USDC with 6 decimals
        }

        return prices;
    }
 
}