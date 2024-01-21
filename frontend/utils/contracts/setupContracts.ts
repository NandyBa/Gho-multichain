import { abi_faucet } from "./ABI/faucet";
import { abi_gho_token } from "./ABI/gho_token";
import { Faucet_Gho, Gho } from "./constant";

export const faucetContract = {
  address: Faucet_Gho,
  abi: abi_faucet,
};

export const ghoContract = {
  address: Gho,
  abi: abi_gho_token,
};
