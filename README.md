# GHO Multichain

This project levrage GHO ecosystem.

## Before execution

### Define env variables

Set up `PRIVATE_KEY` env variable.
Notice: ⚠️ Do not put your personal wallet private key. It's must be a wallet only for testing
```bash
 export PRIVATE_KEY=<YOU_TEST_WALLET_PRIVATE_KEY>
```

### Seed wallet

Seed your wallet with Sepolia and Mumbai funds

### Get RPC for Sepolia and Mumbai testnets
You can use [Anker](https://www.ankr.com/rpc/) got get these RPC

### Recommended: Get Etherscan and PolygonScan API keys
Visit [Etherscan](https://etherscan.io/login) and [PolygonScan](https://polygonscan.com/login) to get your API key. These API Token are requested to verify the contract on block explorers.

## Scripts

### Deploy GHO and Facilitators
With block explorer API key
```bash
forge script script/DeployGho.s.sol:DeployGho --rpc-url <SEPOLIA_RPC> --etherscan-api-key <ETHERSCAN_API_KEY> --verify --broadcast
```

Without block explorer API key
```bash
forge script script/DeployGho.s.sol:DeployGho --rpc-url <SEPOLIA_RPC> --broadcast
```

### Deploy CCIP Contracts
You must run these both scripts

#### Destination Chain
With block explorer API key
```bash
forge script script/CCIPPersonalDeployer.s.sol:DeployCCIPDestitationChain --rpc-url <MUMBAI_RPC> --etherscan-api-key <ETHERSCAN_API_KEY> --verify --broadcast
```

Without block explorer API key
```bash
forge script script/CCIPPersonalDeployer.s.sol:DeployCCIPDestitationChain --rpc-url <MUMBAI_RPC> --broadcast
```
