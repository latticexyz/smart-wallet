// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Vm} from "forge-std/Vm.sol";
import {Script, console2} from "forge-std/Script.sol";
import {SafeSingletonDeployer} from "safe-singleton-deployer-sol/src/SafeSingletonDeployer.sol";
import {EntryPoint} from "account-abstraction/core/EntryPoint.sol";

import {CoinbaseSmartWallet, CoinbaseSmartWalletFactory} from "../src/CoinbaseSmartWalletFactory.sol";

contract DeployFactoryScript is Script {
    address constant EXPECTED_IMPLEMENTATION =
        0x591CF65f7EB7FBfB4fb551F7094477f4B70aA9d6;
    address constant EXPECTED_FACTORY =
        0xdc40db589b2B9e62ea6CCa7ff38a38E73595B5Aa;

    function run() public {
        console2.log("Deploying on chain ID", block.chainid);

        address entrypoint = address(new EntryPoint{salt: 0}());
        console2.log("entrypoint", entrypoint);

        address implementation = SafeSingletonDeployer.broadcastDeploy({
            creationCode: type(CoinbaseSmartWallet).creationCode,
            salt: 0
        });
        console2.log("implementation", implementation);
        assert(implementation == EXPECTED_IMPLEMENTATION);

        address factory = SafeSingletonDeployer.broadcastDeploy({
            creationCode: type(CoinbaseSmartWalletFactory).creationCode,
            args: abi.encode(EXPECTED_IMPLEMENTATION),
            salt: 0
        });
        console2.log("factory", factory);
        assert(factory == EXPECTED_FACTORY);
    }
}
