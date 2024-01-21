// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import { DestinationMinter } from "../src/cross-chain-minter/DestinationMinter.sol";
import { SourceMinter } from "../src/cross-chain-minter/SourceMinter.sol";
import { GhoToken } from "gho-core/src/contracts/gho/GhoToken.sol";

contract DeployCCIPDestitationChain is Script {

    address router = 0x1035CabC275068e0F4b745A29CEDf38E13aF41b1; // Mumbai
    address gho = 0x338351c23414a02A2549c944405F2B40Abe6DF43; // Mumbai Gho

    function run() external {
        uint256 senderPrivateKey = vm.envUint("PRIVATE_KEY");
        // address deployer = vm.rememberKey(senderPrivateKey);
        vm.startBroadcast(senderPrivateKey);

        DestinationMinter destinationMinter = new DestinationMinter(router, gho);
        console.log("DestinationMinter deployed at: ", address(destinationMinter));

        GhoToken ghoToken = GhoToken(gho);
        uint128 CCIPBucketCapacity = (10**8)*10**18;
        ghoToken.addFacilitator(address(destinationMinter), "ccipfacilitator", CCIPBucketCapacity);

        vm.stopBroadcast();
    }
}

contract DeployCCIPSourceChain is Script {

    address router = 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59; // Sepolia
    address link = 0x779877A7B0D9E8603169DdbD7836e478b4624789; // Sepolia

    function run() external {
        uint256 senderPrivateKey = vm.envUint("PRIVATE_KEY");
        // address deployer = vm.rememberKey(senderPrivateKey);
        vm.startBroadcast(senderPrivateKey);

        SourceMinter sourceMinter = new SourceMinter(router, link);
        console.log("SourceMinter deployed at: ", address(sourceMinter));
        
        vm.stopBroadcast();
    }
}
