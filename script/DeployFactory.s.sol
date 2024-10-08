// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {SafeSingletonDeployer} from "safe-singleton-deployer-sol/src/SafeSingletonDeployer.sol";

import {CoinbaseSmartWallet, CoinbaseSmartWalletFactory} from "../src/CoinbaseSmartWalletFactory.sol";

contract DeployFactoryScript is Script {
    address constant EXPECTED_IMPLEMENTATION = 0xBd1E16ddd9f190a9fF9e262e9B99Ba4459B7820B;
    address constant EXPECTED_FACTORY = 0xFE8cDc868E8C8a6C43Cd457D482D153F172d22a1;

    function run() public {
        console2.log("Deploying on chain ID", block.chainid);
        address implementation =
            SafeSingletonDeployer.broadcastDeploy({creationCode: type(CoinbaseSmartWallet).creationCode, salt: 0x0});
        console2.log("implementation", implementation);
        assert(implementation == EXPECTED_IMPLEMENTATION);
        address factory = SafeSingletonDeployer.broadcastDeploy({
            creationCode: type(CoinbaseSmartWalletFactory).creationCode,
            args: abi.encode(EXPECTED_IMPLEMENTATION),
            salt: 0x0
        });
        console2.log("factory", factory);
        assert(factory == EXPECTED_FACTORY);
    }
}
