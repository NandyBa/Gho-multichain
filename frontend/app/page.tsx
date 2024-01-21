"use client";

import { useEffect, useState } from "react";
import { Input } from "@/components/ui/input";
import { HeightIcon } from "@radix-ui/react-icons";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { useAccount, useNetwork, useSwitchNetwork } from "wagmi";
import { fetchBalance } from "@/utils/contracts/fetchContracts";

export default function Home() {
  const { chains, error, switchNetwork } = useSwitchNetwork();
  const { address, isConnected } = useAccount();
  const { chain } = useNetwork();

  const [originNetwork, setOriginNetwork] = useState("");
  const [destinationNetwork, setDestinationNetwork] = useState("");
  const [amount, setAmount] = useState(0);
  const [isRotated, setIsRotated] = useState(false);

  const [ghoBalance, setGhoBalance] = useState(0);

  useEffect(() => {
    const fetchData = async () => {
      try {
        // @ts-ignore
        const balance = await fetchBalance(address);
        // @ts-ignore
        const result: BigInt = balance[0].result;
        // @ts-ignore
        const balanceInEther: number = Number(result / 10n ** 18n);
        setGhoBalance(balanceInEther);
      } catch (error) {
        console.error("Error fetching items:", error);
      }
    };

    if (chain && chain.name == "Polygon Mumbai") {
      console.log(chain.name);
      fetchData();
    }
  }, [isConnected, chain, !address]);

  const toggleRotation = async () => {
    setIsRotated(!isRotated);
    const selectedChain = chains.find((x) => x.name === destinationNetwork);
    if (selectedChain && switchNetwork) {
      try {
        await switchNetwork(selectedChain.id);
      } catch (error) {
        console.error("Error switching network:", error);
      }
    }
    setOriginNetwork((prevNetwork) =>
      prevNetwork === "Sepolia" ? "Polygon Mumbai" : "Sepolia"
    );
    setDestinationNetwork((prevNetwork) =>
      prevNetwork === "Sepolia" ? "Polygon Mumbai" : "Sepolia"
    );
  };

  const handleNetworkChange = (
    value: string,
    setNetwork: React.Dispatch<React.SetStateAction<string>>,
    otherNetwork: string,
    setOtherNetwork: React.Dispatch<React.SetStateAction<string>>
  ) => {
    setNetwork(value);
    if (value === otherNetwork) {
      setOtherNetwork((prevNetwork) =>
        prevNetwork === "Sepolia" ? "Polygon Mumbai" : "Sepolia"
      );
    }
  };

  const handleOriginNetworkChange = async (value: string) => {
    const selectedChain = chains.find((x) => x.name === value);
    if (selectedChain && switchNetwork) {
      try {
        await switchNetwork(selectedChain.id);
      } catch (error) {
        console.error("Error switching network:", error);
      }
    }
    handleNetworkChange(
      value,
      setOriginNetwork,
      destinationNetwork,
      setDestinationNetwork
    );
  };

  const handleDestinationNetworkChange = async (value: string) => {
    const selectedChain = chains.find((x) => x.name !== value);
    if (selectedChain && switchNetwork) {
      try {
        await switchNetwork(selectedChain.id);
      } catch (error) {
        console.error("Error switching network:", error);
      }
    }
    handleNetworkChange(
      value,
      setDestinationNetwork,
      originNetwork,
      setOriginNetwork
    );
  };

  const handleAmountChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setAmount(parseFloat(event.target.value));
  };

  const handleFormSubmit = () => {
    console.log("Origin Network:", originNetwork);
    console.log("Destination Network:", destinationNetwork);
    console.log("Amount:", amount);
  };

  return (
    <main className="flex flex-col items-center justify-center space-y-4">
      {/* {isDisconnected && (
        <Badge className="flex flex-col items-center justify-center space-y-4">
          Connect your wallet to Bridge your Gho.
        </Badge>
      )}
      {!isConnecting && !isDisconnected && ( */}
      <>
        <div>{error && error.message}</div>
        {chain && chain.name === "Polygon Mumbai" && (
          <Badge variant="secondary">
            Your balance in Gho on Mumbai: {ghoBalance}
          </Badge>
        )}
        <Badge variant="secondary">Origin network</Badge>
        <Select onValueChange={handleOriginNetworkChange} value={originNetwork}>
          <SelectTrigger>
            <SelectValue placeholder="Network" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="Sepolia">Sepolia</SelectItem>
            <SelectItem value="Polygon Mumbai">Mumbai</SelectItem>
          </SelectContent>
        </Select>
        <Input
          type="number"
          placeholder="Amount"
          value={amount}
          onChange={handleAmountChange}
        />
        <HeightIcon
          className={`h-[2rem] w-[2rem] transition-all transform ${
            isRotated ? "rotate-180" : "rotate-0"
          }`}
          onClick={toggleRotation}
        />
        <Badge variant="secondary">Destination network</Badge>
        <Select
          onValueChange={handleDestinationNetworkChange}
          value={destinationNetwork}
        >
          <SelectTrigger>
            <SelectValue placeholder="Network" />
          </SelectTrigger>
          <SelectContent>
            <SelectItem value="Sepolia">Sepolia</SelectItem>
            <SelectItem value="Polygon Mumbai">Mumbai</SelectItem>
          </SelectContent>
        </Select>
        <Button onClick={handleFormSubmit}>Bridge</Button>
      </>
      {/* )} */}
    </main>
  );
}
