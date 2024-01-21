import { readContracts } from "@wagmi/core";
import { faucetContract, ghoContract } from "@/utils/contracts/setupContracts";

export async function fetchBalance(address: string) {
  console.log(address);
  const data = await readContracts({
    contracts: [
      // @ts-ignore
      {
        ...ghoContract,
        functionName: "balanceOf",
        args: [address],
      },
    ],
  });
  return data;
}

export async function mintgho() {
  const data = await readContracts({
    contracts: [
      // @ts-ignore
      {
        ...faucetContract,
        functionName: "mintGho",
      },
    ],
  });
  return data;
}
