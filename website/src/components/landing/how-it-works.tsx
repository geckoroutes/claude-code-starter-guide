"use client";

import { useState } from "react";
import { SETUP_STEPS } from "@/lib/constants";
import { CopyButton } from "@/components/ui/copy-button";
import { Button } from "@/components/ui/button";
import { ExternalLink, ChevronDown, ChevronUp, UserPlus, Monitor, Terminal } from "lucide-react";

export function HowItWorks() {
  const [expandedStep, setExpandedStep] = useState<number | null>(null);
  const { install } = SETUP_STEPS;

  const toggle = (step: number) => setExpandedStep(expandedStep === step ? null : step);

  return (
    <section id="steps" className="px-6 py-16 md:py-24">
      <div className="mx-auto max-w-2xl">
        <h2 className="mb-2 text-center text-2xl font-bold md:text-3xl">Three steps, one command</h2>
        <p className="mb-12 text-center text-muted-foreground">The setup script installs everything. You just follow along.</p>

        <div className="space-y-4">
          {/* Step 1 */}
          <div className="rounded-2xl border border-border bg-card overflow-hidden">
            <button onClick={() => toggle(1)} className="flex w-full cursor-pointer items-center gap-4 p-5 text-left transition-colors hover:bg-muted/30">
              <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-primary text-lg font-bold text-primary-foreground">1</div>
              <div className="flex-1">
                <h3 className="font-semibold">Get Claude + VS Code</h3>
                <p className="text-sm text-muted-foreground">Sign up for Claude AI, download VS Code</p>
              </div>
              <UserPlus size={20} className="shrink-0 text-muted-foreground" />
              {expandedStep === 1 ? <ChevronUp size={18} className="shrink-0 text-muted-foreground" /> : <ChevronDown size={18} className="shrink-0 text-muted-foreground" />}
            </button>
            {expandedStep === 1 && (
              <div className="border-t border-border bg-muted/20 p-5">
                <div className="space-y-4">
                  <div className="flex items-start gap-3">
                    <span className="mt-0.5 text-lg">&#x1f916;</span>
                    <div>
                      <p className="font-medium">Claude account</p>
                      <p className="mb-2 text-sm text-muted-foreground">The AI that writes your code. Pro plan is $20/mo, Max is $100/mo for heavy use.</p>
                      <a href="https://claude.ai/" target="_blank" rel="noopener noreferrer" className="inline-flex items-center gap-1 text-sm font-medium text-primary hover:underline">Sign up at claude.ai <ExternalLink size={12} /></a>
                    </div>
                  </div>
                  <div className="flex items-start gap-3">
                    <span className="mt-0.5 text-lg">&#x1f4bb;</span>
                    <div>
                      <p className="font-medium">VS Code</p>
                      <p className="mb-2 text-sm text-muted-foreground">Free code editor by Microsoft. No account needed &mdash; just download and install it.</p>
                      <a href="https://code.visualstudio.com/download" target="_blank" rel="noopener noreferrer" className="inline-flex items-center gap-1 text-sm font-medium text-primary hover:underline">Download VS Code <ExternalLink size={12} /></a>
                    </div>
                  </div>
                </div>
              </div>
            )}
          </div>

          {/* Step 2 */}
          <div className="rounded-2xl border border-border bg-card overflow-hidden">
            <button onClick={() => toggle(2)} className="flex w-full cursor-pointer items-center gap-4 p-5 text-left transition-colors hover:bg-muted/30">
              <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-primary text-lg font-bold text-primary-foreground">2</div>
              <div className="flex-1">
                <h3 className="font-semibold">Run the setup script</h3>
                <p className="text-sm text-muted-foreground">One command that installs and configures everything</p>
              </div>
              <Terminal size={20} className="shrink-0 text-muted-foreground" />
              {expandedStep === 2 ? <ChevronUp size={18} className="shrink-0 text-muted-foreground" /> : <ChevronDown size={18} className="shrink-0 text-muted-foreground" />}
            </button>
            {expandedStep === 2 && (
              <div className="border-t border-border bg-muted/20 p-5 space-y-4">
                <div>
                  <p className="mb-2 text-sm font-semibold">Mac / Linux:</p>
                  <ol className="mb-3 space-y-1.5 text-sm text-muted-foreground">
                    <li className="flex items-start gap-2"><span className="font-semibold text-primary">1.</span> Open VS Code</li>
                    <li className="flex items-start gap-2"><span className="font-semibold text-primary">2.</span> Open the terminal: press <kbd className="rounded bg-[#2a2a3e] px-1.5 py-0.5 text-xs font-mono text-green-300">Ctrl + `</kbd> (or go to <span className="font-medium text-foreground">Terminal &rarr; New Terminal</span> in the menu)</li>
                    <li className="flex items-start gap-2"><span className="font-semibold text-primary">3.</span> Paste this command and press Enter:</li>
                  </ol>
                  <div className="rounded-xl bg-[#1e1e2e] p-4">
                    <div className="mb-2 flex items-center justify-between">
                      <span className="text-xs text-gray-400">Terminal</span>
                      <CopyButton text={install.mac} />
                    </div>
                    <pre className="overflow-x-auto text-xs leading-relaxed text-green-300"><code>{install.mac}</code></pre>
                  </div>
                </div>
                <div>
                  <p className="mb-2 text-sm font-semibold">Windows:</p>
                  <ol className="space-y-1.5 text-sm text-muted-foreground">
                    <li className="flex items-start gap-2"><span className="font-semibold text-primary">1.</span> <a href={install.windowsZip} className="font-medium text-primary hover:underline">Download the ZIP file</a> and unzip it somewhere</li>
                    <li className="flex items-start gap-2"><span className="font-semibold text-primary">2.</span> Right-click <code className="rounded bg-[#2a2a3e] px-1.5 py-0.5 text-xs font-mono text-green-300">setup-windows.ps1</code> &rarr; &quot;Run with PowerShell&quot;</li>
                    <li className="flex items-start gap-2"><span className="font-semibold text-primary">3.</span> Follow the prompts</li>
                  </ol>
                </div>
                <div className="rounded-xl bg-muted/50 p-4">
                  <p className="mb-2 text-sm font-semibold">What the script sets up for you:</p>
                  <ul className="space-y-1.5">
                    {install.whatItDoes.map((item) => (
                      <li key={item} className="flex items-start gap-2 text-sm text-muted-foreground">
                        <span className="mt-1.5 h-1.5 w-1.5 shrink-0 rounded-full bg-accent" />{item}
                      </li>
                    ))}
                  </ul>
                  <p className="mt-3 text-xs italic text-muted-foreground">Nothing is sent anywhere. Everything stays on your machine.</p>
                </div>
              </div>
            )}
          </div>

          {/* Step 3 */}
          <div className="rounded-2xl border border-border bg-card overflow-hidden">
            <button onClick={() => toggle(3)} className="flex w-full cursor-pointer items-center gap-4 p-5 text-left transition-colors hover:bg-muted/30">
              <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-primary text-lg font-bold text-primary-foreground">3</div>
              <div className="flex-1">
                <h3 className="font-semibold">Open VS Code and start chatting</h3>
                <p className="text-sm text-muted-foreground">Just type what you want in plain English</p>
              </div>
              <Monitor size={20} className="shrink-0 text-muted-foreground" />
              {expandedStep === 3 ? <ChevronUp size={18} className="shrink-0 text-muted-foreground" /> : <ChevronDown size={18} className="shrink-0 text-muted-foreground" />}
            </button>
            {expandedStep === 3 && (
              <div className="border-t border-border bg-muted/20 p-5 space-y-3">
                <ol className="space-y-2 text-sm">
                  <li className="flex items-start gap-2"><span className="font-semibold text-primary">1.</span> Open VS Code</li>
                  <li className="flex items-start gap-2"><span className="font-semibold text-primary">2.</span> File &rarr; Open Folder &rarr; pick your workspace folder (the script told you where)</li>
                  <li className="flex items-start gap-2"><span className="font-semibold text-primary">3.</span> Click the Claude icon in the top right corner</li>
                  <li className="flex items-start gap-2"><span className="font-semibold text-primary">4.</span> Sign in with your Claude account</li>
                  <li className="flex items-start gap-2"><span className="font-semibold text-primary">5.</span> Start typing. That&apos;s it.</li>
                </ol>
                <div className="rounded-xl bg-secondary p-4">
                  <p className="mb-2 text-sm font-medium">Try saying something like:</p>
                  <div className="space-y-2">
                    {["Create a new project called my-app", "Build me a landing page for my business", "Go to mybusiness.com and tell me how to improve it"].map((prompt) => (
                      <div key={prompt} className="flex items-center gap-2 rounded-lg bg-card px-3 py-2 text-sm">
                        <span className="text-muted-foreground">&gt;</span>
                        <span className="flex-1">{prompt}</span>
                        <CopyButton text={prompt} className="ml-auto shrink-0" />
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>

        <div className="mt-8 text-center">
          <Button href="/setup" size="lg">Start setup</Button>
        </div>
      </div>
    </section>
  );
}
