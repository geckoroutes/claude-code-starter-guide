"use client";

import { Card } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { SETUP_STEPS } from "@/lib/constants";
import { ExternalLink } from "lucide-react";

export function StepAccounts({ onNext }: { onNext: () => void }) {
  const { accounts } = SETUP_STEPS;

  return (
    <div>
      <h2 className="mb-2 text-center text-2xl font-bold">{accounts.title}</h2>
      <p className="mb-8 text-center text-muted-foreground">Sign up for Claude and download VS Code. Already have them? Skip ahead.</p>

      <div className="grid gap-4 sm:grid-cols-2">
        <Card hover={false}>
          <div className="mb-4 flex h-12 w-12 items-center justify-center rounded-xl bg-secondary text-2xl">&#x1f916;</div>
          <h3 className="mb-1 text-lg font-semibold">Claude account</h3>
          <p className="mb-4 text-sm text-muted-foreground">The AI that powers everything. Pro ($20/mo) or Max ($100/mo).</p>
          <a href={accounts.claudeUrl} target="_blank" rel="noopener noreferrer" className="inline-flex items-center gap-1.5 text-sm font-medium text-primary hover:underline">Create account <ExternalLink size={14} /></a>
        </Card>
        <Card hover={false}>
          <div className="mb-4 flex h-12 w-12 items-center justify-center rounded-xl bg-secondary text-2xl">&#x1f4bb;</div>
          <h3 className="mb-1 text-lg font-semibold">VS Code</h3>
          <p className="mb-4 text-sm text-muted-foreground">Free code editor by Microsoft. No account needed &mdash; just download and install.</p>
          <a href={accounts.vscodeUrl} target="_blank" rel="noopener noreferrer" className="inline-flex items-center gap-1.5 text-sm font-medium text-primary hover:underline">Download VS Code <ExternalLink size={14} /></a>
        </Card>
      </div>

      <div className="mt-8 flex flex-col items-center gap-3">
        <Button onClick={onNext} size="lg">I have both &mdash; next</Button>
        <button onClick={onNext} className="text-sm text-muted-foreground hover:text-foreground cursor-pointer">Skip, I already have these</button>
      </div>
    </div>
  );
}
