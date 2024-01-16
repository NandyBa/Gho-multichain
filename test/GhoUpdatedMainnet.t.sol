import {Test, console2} from "forge-std/Test.sol";
import { GhoToken } from "gho-core/src/contracts/gho/GhoToken.sol";

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

    function test_start() public {

    }

}
