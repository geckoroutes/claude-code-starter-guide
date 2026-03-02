"use client";

import { useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Apple, Monitor } from "lucide-react";

function detectOS(): "mac" | "windows" {
  if (typeof navigator === "undefined") return "windows";
  return navigator.userAgent.toLowerCase().includes("mac") ? "mac" : "windows";
}

export function StepOs({ os, setOs, onNext }: { os: "mac" | "windows" | null; setOs: (os: "mac" | "windows") => void; onNext: () => void }) {
  useEffect(() => { if (!os) setOs(detectOS()); }, [os, setOs]);

  return (
    <div>
      <h2 className="mb-2 text-center text-2xl font-bold">Confirm your system</h2>
      <p className="mb-8 text-center text-muted-foreground">We detected your operating system. Is this right?</p>
      <div className="flex justify-center gap-4">
        {(["mac", "windows"] as const).map((o) => (
          <button key={o} onClick={() => setOs(o)} className={`flex cursor-pointer flex-col items-center gap-3 rounded-xl border-2 p-6 transition-all ${os === o ? "border-primary bg-secondary shadow-md" : "border-border hover:border-primary/30"}`}>
            {o === "mac" ? <Apple size={32} className={os === o ? "text-primary" : "text-muted-foreground"} /> : <Monitor size={32} className={os === o ? "text-primary" : "text-muted-foreground"} />}
            <span className={`font-semibold ${os === o ? "text-primary" : "text-muted-foreground"}`}>{o === "mac" ? "Mac / Linux" : "Windows"}</span>
          </button>
        ))}
      </div>
      <div className="mt-8 flex justify-center">
        <Button onClick={onNext} size="lg" className={os ? "" : "opacity-50 pointer-events-none"}>Next</Button>
      </div>
    </div>
  );
}
