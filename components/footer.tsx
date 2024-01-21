"use client";

import React from "react";
import { ConnectKitButton } from "connectkit";
import { Badge } from "./ui/badge";

export function Footer() {
  return (
    <div className="flex justify-between items-center p-4">
      <Badge>Github</Badge>
      <ConnectKitButton />
    </div>
  );
}
