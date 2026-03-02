"use client";

import { useEffect, useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import { DEMO_SEQUENCE } from "@/lib/constants";

type Phase = "typing" | "coding" | "result" | "caption" | "pause";

export function AnimatedDemo() {
  const [phase, setPhase] = useState<Phase>("typing");
  const [typedChars, setTypedChars] = useState(0);
  const [codedLines, setCodedLines] = useState(0);

  const message = DEMO_SEQUENCE.userMessage;
  const codeLines = DEMO_SEQUENCE.codeSnippet.split("\n");

  useEffect(() => {
    if (phase === "typing") {
      if (typedChars < message.length) {
        const timer = setTimeout(() => setTypedChars((c) => c + 1), 30);
        return () => clearTimeout(timer);
      }
      const timer = setTimeout(() => setPhase("coding"), 600);
      return () => clearTimeout(timer);
    }
    if (phase === "coding") {
      if (codedLines < codeLines.length) {
        const timer = setTimeout(() => setCodedLines((l) => l + 1), 80);
        return () => clearTimeout(timer);
      }
      const timer = setTimeout(() => setPhase("result"), 500);
      return () => clearTimeout(timer);
    }
    if (phase === "result") {
      const timer = setTimeout(() => setPhase("caption"), 1200);
      return () => clearTimeout(timer);
    }
    if (phase === "caption") {
      const timer = setTimeout(() => setPhase("pause"), 2500);
      return () => clearTimeout(timer);
    }
    if (phase === "pause") {
      const timer = setTimeout(() => { setTypedChars(0); setCodedLines(0); setPhase("typing"); }, 1000);
      return () => clearTimeout(timer);
    }
  }, [phase, typedChars, codedLines, message.length, codeLines.length]);

  return (
    <section className="px-6 py-16 md:py-24">
      <div className="mx-auto max-w-3xl">
        <h2 className="mb-4 text-center text-3xl font-bold md:text-4xl">See the magic</h2>
        <p className="mx-auto mb-10 max-w-md text-center text-muted-foreground">You type what you want. Claude builds it.</p>

        <div className="overflow-hidden rounded-2xl border border-border bg-card shadow-lg">
          <div className="flex items-center gap-2 border-b border-border bg-muted/50 px-4 py-3">
            <div className="h-3 w-3 rounded-full bg-red-400/60" />
            <div className="h-3 w-3 rounded-full bg-yellow-400/60" />
            <div className="h-3 w-3 rounded-full bg-green-400/60" />
            <span className="ml-2 text-xs text-muted-foreground">Claude Code</span>
          </div>

          <div className="min-h-[340px] p-6">
            {/* User message */}
            <div className="mb-4 flex gap-3">
              <div className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-primary/10 text-xs font-bold text-primary">You</div>
              <div className="rounded-2xl rounded-tl-md bg-secondary px-4 py-3 text-sm leading-relaxed">
                {message.slice(0, typedChars)}
                {phase === "typing" && <span className="inline-block h-4 w-0.5 animate-pulse bg-foreground" />}
              </div>
            </div>

            {/* Claude coding */}
            <AnimatePresence>
              {(phase === "coding" || phase === "result" || phase === "caption" || phase === "pause") && (
                <motion.div initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} className="mb-4 flex gap-3">
                  <div className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-accent/10 text-xs font-bold text-accent">AI</div>
                  <div className="min-w-0 flex-1">
                    <div className="overflow-hidden rounded-2xl rounded-tl-md bg-[#1e1e2e] p-4">
                      <pre className="overflow-x-auto text-xs leading-relaxed text-green-300">
                        <code>
                          {codeLines.slice(0, codedLines).join("\n")}
                          {phase === "coding" && <span className="inline-block h-3 w-1.5 animate-pulse bg-green-400" />}
                        </code>
                      </pre>
                    </div>
                  </div>
                </motion.div>
              )}
            </AnimatePresence>

            {/* Result preview */}
            <AnimatePresence>
              {(phase === "result" || phase === "caption" || phase === "pause") && (
                <motion.div initial={{ opacity: 0, scale: 0.95 }} animate={{ opacity: 1, scale: 1 }} transition={{ duration: 0.4 }} className="ml-10 overflow-hidden rounded-xl border border-border">
                  <div className="flex items-center gap-2 border-b border-border bg-muted/30 px-3 py-2">
                    <div className="h-2 w-2 rounded-full bg-green-400" />
                    <span className="text-[10px] text-muted-foreground">localhost:3000</span>
                  </div>
                  <div className="bg-amber-50 p-6 text-center">
                    <div className="mb-1 text-2xl">&#x1f43e;</div>
                    <h3 className="mb-1 text-lg font-bold text-amber-900">{DEMO_SEQUENCE.resultTitle}</h3>
                    <p className="mb-3 text-xs text-amber-700">{DEMO_SEQUENCE.resultSubtitle}</p>
                    <div className="flex justify-center gap-2">
                      {["Basic $15", "Premium $25", "VIP $40"].map((plan) => (
                        <div key={plan} className="rounded-lg bg-white px-3 py-1.5 text-[10px] font-medium text-amber-800 shadow-sm">{plan}</div>
                      ))}
                    </div>
                  </div>
                </motion.div>
              )}
            </AnimatePresence>

            {/* Caption */}
            <AnimatePresence>
              {(phase === "caption" || phase === "pause") && (
                <motion.p initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="mt-6 text-center text-sm font-semibold text-primary">
                  {DEMO_SEQUENCE.caption}
                </motion.p>
              )}
            </AnimatePresence>
          </div>
        </div>
      </div>
    </section>
  );
}
