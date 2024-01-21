"use client";

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

import { useState } from "react";

export default function Home() {
  const [isRotated, setIsRotated] = useState(false);

  const handleIconClick = () => {
    setIsRotated(!isRotated);
  };

  return (
    <main className="flex flex-col items-center justify-center space-y-4">
      <Select>
        <SelectTrigger className="w-[180px]">
          <SelectValue placeholder="Network" />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="Sepolia">Sepolia</SelectItem>
          <SelectItem value="Mumbai">Mumbai</SelectItem>
        </SelectContent>
      </Select>
      <Input type="number" placeholder="number" />
      <HeightIcon
        className={`h-[2rem] w-[2rem] transition-all transform ${
          isRotated ? "rotate-180" : "rotate-0"
        }`}
        onClick={handleIconClick}
      />
      <Select>
        <SelectTrigger className="w-[180px]">
          <SelectValue placeholder="Network" />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="Sepolia">Sepolia</SelectItem>
          <SelectItem value="Mumbai">Mumbai</SelectItem>
        </SelectContent>
      </Select>
      <Input type="number" placeholder="number" />
      <Button>Bridge</Button>
    </main>
  );
}
