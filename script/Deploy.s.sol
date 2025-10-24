// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Upgrades} from "@openzeppelin-foundry-upgrades/Upgrades.sol";	
import "src/DegenAiPool.sol";

contract DeployScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        //Unichain replace with Optimism or Arbitrum addresses
        address router = address(0xA51afAFe0263b40EdaEf0Df8781eA9aa03E381a3);   //Uniswap universal router on Arbitrum
        address oracle = address(0x780991123cD5a1d6afAC88f9f20D2b16ef454B28);    // Oracle Pyth Network on Arbitrum
        address treasury = address(0x34FdB6F7A3A6b3007d745fd9f430Cc2d73e0E44C);  // Treasury address (8% fee recipient)
        address permit2 = address(0x000000000022D473030F116dDEE9F6B43aC78BA3);   //arbitrum Uniswap permit2 address

        //Tokens Prices IDs for Pyth Network Oracle
        bytes32  tokenPricesIdUsdc = 0xeaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a;
        bytes32  tokenPricesIdWeth = 0x9d4294bbcd1174d6f2003ec365831e64cc31d9f6f15a2b85399db8d5000960f6;
        bytes32  tokenPricesIdWbtc = 0xc9d8b075a5c69303365ae23633d4e085199bf5c520a3b90fed1322a0342ffc33;
        bytes32  tokenPricesIdArb = 0x3fa4252848f9f0a1480be62745a4629d9eb1322aebab8a791e344b3b9c1adcf5;
        bytes32  tokenPricesIdPendle = 0x9a4df90b25497f66b1afb012467e316e801ca3d839456db028892fe8c70c8016;
        bytes32  tokenPricesIdLink = 0x8ac0c70fff57e9aefdf5edf44b51d62c2d433653cbb2cf5cc06bb115af04d221;
        bytes32  tokenPricesIdAave = 0x2b9ab1e972a281585084148ba1389800799bd4be63b957507db1349314e47445;
        bytes32  tokenPricesIdCrv = 0xa19d04ac696c7a6616d291c7e5d1377cc8be437c327b75adb5dc1bad745fcae8;
        bytes32  tokenPricesIdDot = 0xca3eed9b267293f6595901c734c7525ce8ef49adafe8284606ceb307afa2ca5b;
        bytes32  tokenPricesIdUni = 0x78d185a741d07edb3412b09008b7c5cfb9bbbd7d568bf00ba737b456ba171501;
        bytes32  tokenPricesIdLdo = 0xc63e2a7f37a04e5e614c07238bedb25dcc38927fba8fe890597a593c0b2fa4ad;

        //Tokens addresses on Arbitrum
        address usdc = address(0xaf88d065e77c8cC2239327C5EDb3A432268e5831);
        address weth = address(0x82aF49447D8a07e3bd95BD0d56f35241523fBab1);
        address wbtc = address(0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f);
        address arb = address(0x912CE59144191C1204E64559FE8253a0e49E6548);
        address pendle = address(0x0c880f6761F1af8d9Aa9C466984b80DAb9a8c9e8);
        address link = address(0xf97f4df75117a78c1A5a0DBb814Af92458539FB4);
        address aave = address(0xba5DdD1f9d7F570dc94a51479a000E3BCE967196);
        address crv = address(0x11cDb42B0EB46D95f990BeDD4695A6e3fA034978);
        address dot = address(0x8d010bf9C26881788b4e6bf5Fd1bdC358c8F90b8);
        address uni = address(0xFa7F8980b0f1E64A2062791cc3b0871572f1F7f0);
        address ldo = address(0x13Ad51ed4F1B7e9Dc168d8a00cB3f4dDD85EfA60); 


        //address[] calldata tokens, bytes32[] calldata priceIds

        bytes32[] memory tokenPricesId = new bytes32[](11);
        tokenPricesId[0] =  tokenPricesIdUsdc;
        tokenPricesId[1] =  tokenPricesIdWeth;
        tokenPricesId[2] =  tokenPricesIdWbtc;
        tokenPricesId[3] =  tokenPricesIdArb;
        tokenPricesId[4] =  tokenPricesIdPendle;
        tokenPricesId[5] =  tokenPricesIdLink;
        tokenPricesId[6] =  tokenPricesIdAave;
        tokenPricesId[7] =  tokenPricesIdCrv;
        tokenPricesId[8] =  tokenPricesIdDot;
        tokenPricesId[9] =  tokenPricesIdUni;
        tokenPricesId[10] =  tokenPricesIdLdo;


        address[] memory tokens = new address[](11);
        tokens[0] = usdc;
        tokens[1] = weth;
        tokens[2] = wbtc;
        tokens[3] = arb;
        tokens[4] = pendle;
        tokens[5] = link;
        tokens[6] = aave;
        tokens[7] = crv;
        tokens[8] = dot;
        tokens[9] = uni;
        tokens[10] = ldo;

        address proxy = Upgrades.deployUUPSProxy(
            "DegenAiPool.sol:DegenAiPool",
            abi.encodeCall(DegenAiPool.initialize, (usdc, router, oracle, treasury, permit2, tokens, tokenPricesId))
        );



        console.log("DegenAiPool deployed at: %s", address(proxy));
        vm.stopBroadcast();
    }
}
