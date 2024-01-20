// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./Helper.sol";
import "forge-std/console.sol";
import { MyNFT } from "../src/cross-chain-nft-minter/MyNFT.sol";
import { DestinationMinter } from "../src/cross-chain-nft-minter/DestinationMinter.sol";
import { SourceMinter } from "../src/cross-chain-nft-minter/SourceMinter.sol";

contract DeployCCIPDestitationChain is Script {

    address router = 0x1035CabC275068e0F4b745A29CEDf38E13aF41b1; // Mumbai

    function run() external {
        uint256 senderPrivateKey = vm.envUint("PRIVATE_KEY");
        // address deployer = vm.rememberKey(senderPrivateKey);
        vm.startBroadcast(senderPrivateKey);

        MyNFT myNFT = new MyNFT();
        console.log("MyNFT deployed at: ", address(myNFT));

        DestinationMinter destinationMinter = new DestinationMinter(router, address(myNFT));
        console.log("DestinationMinter deployed at: ", address(destinationMinter));

        myNFT.transferOwnership(address(destinationMinter));
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
