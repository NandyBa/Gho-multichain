export GHO_MANAGER=0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A
export GHO_TOKEN_ADDRESS=0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f
export NEW_FACILITATOR=0x629307a7aF7B65C1fDEe4c0dd8023E0ad450f70d
cast rpc anvil_impersonateAccount $GHO_MANAGER
cast rpc anvil_setBalance $GHO_MANAGER 10000000000000000000 # 10 ETH

cast send $GHO_TOKEN_ADDRESS \
--unlocked \
--from $GHO_MANAGER \
  "addFacilitator(address,string,uint128)()" \
  $NEW_FACILITATOR \
  "test" \
  1 ether
