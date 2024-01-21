export const abi_faucet = [
  {
    inputs: [
      { internalType: "contract GhoToken", name: "_ghoToken", type: "address" },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "ghoToken",
    outputs: [{ internalType: "contract GhoToken", name: "", type: "address" }],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "mintGho",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];
