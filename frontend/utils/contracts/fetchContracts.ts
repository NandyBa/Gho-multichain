import { readContracts } from "@wagmi/core";
import { ghoContract } from "@/utils/contracts/setupContracts";

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
