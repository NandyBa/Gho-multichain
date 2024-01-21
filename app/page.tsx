"use client";

import { useState } from "react";
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

export default function Home() {
  const [originNetwork, setOriginNetwork] = useState("");
  const [destinationNetwork, setDestinationNetwork] = useState("");
  const [amount, setAmount] = useState(0);
  const [isRotated, setIsRotated] = useState(false);

  const toggleRotation = () => {
    setIsRotated(!isRotated);
    setOriginNetwork((prevNetwork) =>
      prevNetwork === "Sepolia" ? "Mumbai" : "Sepolia"
    );
    setDestinationNetwork((prevNetwork) =>
      prevNetwork === "Sepolia" ? "Mumbai" : "Sepolia"
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
        prevNetwork === "Sepolia" ? "Mumbai" : "Sepolia"
      );
    }
  };

  const handleOriginNetworkChange = (value: string) => {
    handleNetworkChange(
      value,
      setOriginNetwork,
      destinationNetwork,
      setDestinationNetwork
    );
  };

  const handleDestinationNetworkChange = (value: string) => {
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
      <Badge variant="secondary">Origin network</Badge>
      <Select onValueChange={handleOriginNetworkChange} value={originNetwork}>
        <SelectTrigger>
          <SelectValue placeholder="Network" />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="Sepolia">Sepolia</SelectItem>
          <SelectItem value="Mumbai">Mumbai</SelectItem>
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
          <SelectItem value="Mumbai">Mumbai</SelectItem>
        </SelectContent>
      </Select>
      <Button onClick={handleFormSubmit}>Bridge</Button>
    </main>
  );
}
