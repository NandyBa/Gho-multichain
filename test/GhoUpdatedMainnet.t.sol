import {Test, console2} from "forge-std/Test.sol";
import { GhoToken } from "gho-core/src/contracts/gho/GhoToken.sol";

pragma solidity ^0.8.0;

contract ForkTest is Test {
    // the identifiers of the forks
    uint256 mainnetFork;
    uint256 optimismFork;
    // RPC URLs are imported from environment variables
    string MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");

    GhoToken ghoToken;




    // create two _different_ forks during setup
    function setUp() public {
        mainnetFork = vm.createFork(MAINNET_RPC_URL);
        vm.selectFork(mainnetFork);
        ghoToken = GhoToken(address(0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f));
    }

    function test_addFacilitator() public {
        address manager = address(0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A);
        address facilitator = address(0x1);
        string memory label = "test";
        uint128 bucketCapacity = 100e18;
        vm.prank(manager);
        ghoToken.addFacilitator(facilitator, label, bucketCapacity);
        assertEq(ghoToken.getFacilitator(facilitator).label, label);
        assertEq(ghoToken.getFacilitator(facilitator).bucketCapacity, bucketCapacity);
        assertEq(ghoToken.getFacilitator(facilitator).bucketLevel, 0);
    }

}
