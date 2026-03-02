"use client";

import { useState } from "react";
import { CopyButton } from "@/components/ui/copy-button";
import { Button } from "@/components/ui/button";
import { SETUP_STEPS } from "@/lib/constants";
import { ChevronDown, ChevronUp, PartyPopper } from "lucide-react";
import Link from "next/link";

export function StepInstall({ os }: { os: "mac" | "windows" | null }) {
  const [showDetails, setShowDetails] = useState(false);
  const [done, setDone] = useState(false);
  const { install } = SETUP_STEPS;

  if (done) {
    return (
      <div className="text-center">
        <div className="mx-auto mb-4 flex h-16 w-16 items-center justify-center rounded-full bg-accent/10">
          <PartyPopper size={32} className="text-accent" />
        </div>
        <h2 className="mb-2 text-2xl font-bold">You&apos;re all set!</h2>
        <p className="mb-8 text-muted-foreground">Open VS Code, click the Claude icon, and start chatting.</p>
        <Button href="/start" size="lg">See what to try first</Button>
      </div>
    );
  }

  return (
    <div>
      <h2 className="mb-2 text-center text-2xl font-bold">{install.title}</h2>
      {os === "mac" ? (
        <div className="space-y-4">
          <ol className="space-y-2 text-sm">
            <li className="flex items-start gap-2"><span className="font-semibold text-primary">1.</span> Open VS Code</li>
            <li className="flex items-start gap-2"><span className="font-semibold text-primary">2.</span> Open the terminal: press <kbd className="rounded bg-[#2a2a3e] px-1.5 py-0.5 text-xs font-mono text-green-300">Ctrl + `</kbd> (or go to <span className="font-medium">Terminal &rarr; New Terminal</span>)</li>
            <li className="flex items-start gap-2"><span className="font-semibold text-primary">3.</span> Paste this command and press Enter:</li>
          </ol>
          <div className="rounded-xl border border-border bg-[#1e1e2e] p-4">
            <div className="mb-3 flex items-center justify-between">
              <span className="text-xs text-gray-400">Terminal</span>
              <CopyButton text={install.mac} />
            </div>
            <pre className="overflow-x-auto text-sm leading-relaxed text-green-300"><code>{install.mac}</code></pre>
          </div>
        </div>
      ) : (
        <div className="space-y-4">
          <ol className="space-y-2 text-sm">
            <li className="flex items-start gap-2"><span className="font-semibold text-primary">1.</span> <a href={install.windowsZip} className="font-medium text-primary hover:underline">Download the ZIP file</a> and unzip it somewhere</li>
            <li className="flex items-start gap-2"><span className="font-semibold text-primary">2.</span> Right-click <code className="rounded bg-muted px-1.5 py-0.5 text-xs font-mono">setup-windows.ps1</code> and select <strong>&quot;Run with PowerShell&quot;</strong></li>
            <li className="flex items-start gap-2"><span className="font-semibold text-primary">3.</span> Follow the prompts &mdash; the script does the rest</li>
          </ol>
        </div>
      )}

      <div className="mt-6">
        <button onClick={() => setShowDetails(!showDetails)} className="flex w-full cursor-pointer items-center justify-between rounded-lg bg-muted px-4 py-3 text-sm font-medium text-muted-foreground hover:text-foreground transition-colors">
          What does the script do?
          {showDetails ? <ChevronUp size={16} /> : <ChevronDown size={16} />}
        </button>
        {showDetails && (
          <ul className="mt-3 space-y-2 px-4">
            {install.whatItDoes.map((item) => (
              <li key={item} className="flex items-start gap-2 text-sm text-muted-foreground">
                <span className="mt-1 h-1.5 w-1.5 shrink-0 rounded-full bg-accent" />{item}
              </li>
            ))}
            <li className="flex items-start gap-2 text-sm text-muted-foreground italic">
              <span className="mt-1 h-1.5 w-1.5 shrink-0 rounded-full bg-border" />Nothing is sent anywhere. Everything stays on your machine.
            </li>
          </ul>
        )}
      </div>

      <div className="mt-8 flex flex-col items-center gap-3">
        <Button onClick={() => setDone(true)} size="lg">I&apos;ve run the script</Button>
        <Link href="/start" className="text-sm text-muted-foreground hover:text-foreground">Skip for now</Link>
      </div>
    </div>
  );
}
