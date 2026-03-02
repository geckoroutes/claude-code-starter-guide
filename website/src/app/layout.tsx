import type { Metadata } from "next";
import { Inter, Geist_Mono } from "next/font/google";
import { Header } from "@/components/layout/header";
import { Footer } from "@/components/layout/footer";
import "./globals.css";

const inter = Inter({ variable: "--font-inter", subsets: ["latin"] });
const geistMono = Geist_Mono({ variable: "--font-geist-mono", subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Claude Code Starter Guide",
  description: "Build apps by talking to your computer. No coding required.",
  openGraph: {
    title: "Build apps by talking to your computer",
    description: "Claude Code turns plain English into working software. No coding required.",
    url: "https://claude-code-starter-guide.vercel.app",
    siteName: "Claude Code Starter Guide",
    images: [{ url: "/og-image.png", width: 1200, height: 630 }],
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Build apps by talking to your computer",
    description: "Claude Code turns plain English into working software. No coding required.",
    images: ["/og-image.png"],
  },
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en">
      <body className={`${inter.variable} ${geistMono.variable} antialiased`}>
        <Header />
        <main>{children}</main>
        <Footer />
      </body>
    </html>
  );
}
