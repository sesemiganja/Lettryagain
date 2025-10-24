import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Thesys Morphic-Based Template",
  description: "Morphic-inspired UI fully powered by Thesys C1",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}