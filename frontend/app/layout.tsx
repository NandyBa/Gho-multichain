import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./index.css";
import Provider from "@/components/provider";
import { Toaster } from "@/components/ui/toaster";
import { ThemeProvider } from "@/components/theme-provider";
import { Footer } from "@/components/footer";
import { Header } from "@/components/header";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Create Next App",
  description: "Generated by create next app",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <div className=" h-screen p-2">
          <ThemeProvider
            attribute="class"
            defaultTheme="system"
            enableSystem
            disableTransitionOnChange
          >
            <Provider>
              <Header />
              {children}
              <Toaster />
              <Footer />
            </Provider>
          </ThemeProvider>
        </div>
      </body>
    </html>
  );
}
