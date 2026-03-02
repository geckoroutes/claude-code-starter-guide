"use client";

import { useState } from "react";
import { Clipboard, Check } from "lucide-react";

export function CopyButton({ text, className = "" }: { text: string; className?: string }) {
  const [copied, setCopied] = useState(false);

  const handleCopy = async () => {
    await navigator.clipboard.writeText(text);
    setCopied(true);
    setTimeout(() => setCopied(false), 2000);
  };

  return (
    <button
      onClick={handleCopy}
      className={`inline-flex items-center gap-2 rounded-lg px-3 py-1.5 text-sm font-medium transition-all duration-200 cursor-pointer ${copied ? "bg-accent/10 text-accent" : "bg-muted text-muted-foreground hover:bg-border hover:text-foreground"} ${className}`}
    >
      {copied ? <><Check size={14} /> Copied!</> : <><Clipboard size={14} /> Copy</>}
    </button>
  );
}
