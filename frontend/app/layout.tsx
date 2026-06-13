import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import { Providers } from "@/lib/providers";
import { Toaster } from "@/components/ui/sonner";
import Link from "next/link";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Nursery Portal",
  description: "Sistema de gestión de turnos para personal de enfermería",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="es" className={`${geistSans.variable} ${geistMono.variable} h-full antialiased`}>
      <body className="min-h-full flex flex-col bg-background text-foreground">
        <Providers>
          <header className="border-b">
            <div className="container mx-auto px-4 flex items-center justify-between h-14">
              <Link href="/" className="font-semibold text-lg">
                Nursery Portal
              </Link>
              <nav className="flex items-center gap-4 text-sm">
                <Link href="/employees" className="hover:text-primary transition-colors">
                  Empleados
                </Link>
                <Link href="/schedules" className="hover:text-primary transition-colors">
                  Planificaciones
                </Link>
              </nav>
            </div>
          </header>
          <main className="flex-1 container mx-auto px-4 py-6">
            {children}
          </main>
          <Toaster />
        </Providers>
      </body>
    </html>
  );
}
