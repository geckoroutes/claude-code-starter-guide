import Link from "next/link";
import { Sparkles } from "lucide-react";

export function Header() {
  return (
    <header className="sticky top-0 z-50 border-b border-border bg-background/80 backdrop-blur-md">
      <div className="mx-auto flex h-16 max-w-5xl items-center justify-between px-6">
        <Link href="/" className="flex items-center gap-2 font-semibold text-foreground">
          <Sparkles size={20} className="text-primary" />
          Claude Code Guide
        </Link>
        <nav className="flex items-center gap-6">
          <Link href="/setup" className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground">Setup</Link>
          <Link href="/start" className="text-sm font-medium text-muted-foreground transition-colors hover:text-foreground">Get Started</Link>
        </nav>
      </div>
    </header>
  );
}
