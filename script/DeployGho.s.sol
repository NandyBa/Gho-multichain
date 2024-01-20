// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./Helper.sol";
import "forge-std/console.sol";
import { GhoToken } from "gho-core/src/contracts/gho/GhoToken.sol";
import { Faucet } from "../src/Faucet/Faucet.sol";

/**
 * @title DeployGho
 * @dev A contract for deploying the GhoToken and performing initialization tasks.
 * 
 * default admin role and facilitator manager role are granted to the deployer
 * This deployment also adds the deployer as a facilitator with a bucket capacity of 1 GHO (10**18)
 * and mint 1 GHO to the deployer
 * 
 * For testing purpose, we also deploy a faucet contract and add it as a facilitator
 * so people can test our project.
 * Do not use this in production.
 */
contract DeployGho is Script {
    address admin = address(0x629307a7aF7B65C1fDEe4c0dd8023E0ad450f70d);
    GhoToken ghoToken;
    address facilitator;

    /**
     * @dev Executes the deployment and initialization tasks.
     */
    function run() external {
        bytes32 FACILITATOR_MANAGER_ROLE = keccak256('FACILITATOR_MANAGER_ROLE');
        console.logBytes32(FACILITATOR_MANAGER_ROLE);
        uint256 senderPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.rememberKey(senderPrivateKey);
        uint128 bucketCapacity = 10**18;
        facilitator = deployer;
        vm.startBroadcast(senderPrivateKey);

        ghoToken = new GhoToken(admin);

        console.log(
            "GhoToken deployed with address: ",
            address(ghoToken)
        );

        ghoToken.grantRole(FACILITATOR_MANAGER_ROLE, facilitator);
        console.log(
            "GhoToken granted role: ",
            facilitator
        );
        ghoToken.addFacilitator(facilitator, 'test', bucketCapacity);
        console.log(
            "GhoToken addFacilitator: ",
            facilitator
        );

        ghoToken.mint(facilitator, 10**18);
        console.log(
            "GhoToken mint: ",
            facilitator
        );

        //Add faucet contract as a facilitator so people can test our project
        // @notice: this is only for testing purpose, do not use this in production

        Faucet faucet = new Faucet(ghoToken);
        address faucetAddress = address(faucet);
        console.log(
            "Faucet deployed with address: ",
            faucetAddress
        );

        uint128 faucetBucketCapacity = (10**8)*10**18;
        ghoToken.addFacilitator(faucetAddress, 'faucet', faucetBucketCapacity);
        console.log(
            "GhoToken addFacilitator: ",
            faucetAddress
        );
        console.log(
            "You can use this faucet to get GHO token for testing purpose"
        );

        vm.stopBroadcast();
    }
}
