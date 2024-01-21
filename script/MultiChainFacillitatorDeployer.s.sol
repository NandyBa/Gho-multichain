// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import { MultiChainFacilitator } from "../src/MultiChainFacilitator.sol";
import { SourceMinter } from "../src/cross-chain-minter/SourceMinter.sol";
import { GhoToken } from "gho-core/src/contracts/gho/GhoToken.sol";

contract Deploy is Script {

    function run(address router, address link, address gho) external {
        uint256 senderPrivateKey = vm.envUint("PRIVATE_KEY");
        // address deployer = vm.rememberKey(senderPrivateKey);
        vm.startBroadcast(senderPrivateKey);

        MultiChainFacilitator multiChainFacilitator = new MultiChainFacilitator(router, link, gho);
        console.log("MultiChainFacilitator successfully deployed at: ", address(multiChainFacilitator));
        

        GhoToken ghoToken = GhoToken(gho);
        uint128 CCIPBucketCapacity = (10**8)*10**18;
        ghoToken.addFacilitator(address(multiChainFacilitator), "multichainfacilitator", CCIPBucketCapacity);

        vm.stopBroadcast();
    }
}

contract DeployOnMumbai is Script {
    address router = 0x1035CabC275068e0F4b745A29CEDf38E13aF41b1; // Mumbai
    address gho = 0x92D6EcaC04f636b1827795E5f4eaD3d883Bc5937; // Mumbai Gho
    address link = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB; // Mumbai

    function run() external {
        Deploy deploy = new Deploy();
        deploy.run(router, link, gho);
    }
}

contract DeployOnSepolia is Script {
    address router = 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59; // Sepolia
    address gho = 0x579b36161bC93fe63F6b25E3bF239E54936641d1; // Sepolia Gho
    address link = 0x779877A7B0D9E8603169DdbD7836e478b4624789; // Sepolia

    function run() external {
        Deploy deploy = new Deploy();
        deploy.run(router, link, gho);
    }
}
