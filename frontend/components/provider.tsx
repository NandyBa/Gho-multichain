"use client";

import { NextUIProvider } from "@nextui-org/react";
import { WagmiConfig, createConfig, sepolia } from "wagmi";
import { ConnectKitProvider, getDefaultConfig } from "connectkit";
import { createContext, useEffect, useState } from "react";
import { polygonMumbai } from "wagmi/chains";
import { useTheme } from "next-themes";

export const chains = [sepolia, polygonMumbai];

export const config = createConfig(
  getDefaultConfig({
    // Required API Keys
    alchemyId: "H50hcWGh3-idqI-_fQAj3A57AbEdwMdf",
    walletConnectProjectId: "79b445e0921705d5a1e2477813653d50",

    // Required
    appName: "Your App Name",

    // Optional
    appDescription: "Your App Description",
    appUrl: "https://family.co", // your app's url
    appIcon: "https://family.co/logo.png", // your app's icon, no bigger than 1024x1024px (max. 1MB)
    chains,
  })
);

export const ProviderContext = createContext<{}>({});

export type Mode = "light" | "dark" | "auto";

export default function Provider({ children }: { children: React.ReactNode }) {
  const { theme } = useTheme();
  const [currentTheme, setCurrentTheme] = useState<Mode>("light");

  useEffect(() => {
    console.log(theme);
    // @ts-ignore
    setCurrentTheme(theme);
  }, [theme]);

  useEffect(() => {
    console.log("currentTheme :", currentTheme);
  }, [currentTheme]);

  return (
    <ProviderContext.Provider value={{}}>
      <WagmiConfig config={config}>
        <ConnectKitProvider mode={currentTheme}>
          <NextUIProvider>{children}</NextUIProvider>
        </ConnectKitProvider>
      </WagmiConfig>
    </ProviderContext.Provider>
  );
}
