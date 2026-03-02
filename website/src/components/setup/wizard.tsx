"use client";

import { useState, useEffect } from "react";
import { StepIndicator } from "@/components/ui/step-indicator";
import { StepAccounts } from "./step-accounts";
import { StepOs } from "./step-os";
import { StepInstall } from "./step-install";

const STEPS = ["Accounts", "System", "Install"];
const STORAGE_KEY = "claude-setup-wizard";

type OS = "mac" | "windows" | null;

interface WizardState {
  currentStep: number;
  os: OS;
}

function loadState(): WizardState {
  if (typeof window === "undefined") return { currentStep: 0, os: null };
  try {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved) return JSON.parse(saved);
  } catch { /* ignore */ }
  return { currentStep: 0, os: null };
}

export function Wizard() {
  const [state, setState] = useState<WizardState>({ currentStep: 0, os: null });
  const [mounted, setMounted] = useState(false);

  useEffect(() => { setState(loadState()); setMounted(true); }, []);
  useEffect(() => { if (mounted) localStorage.setItem(STORAGE_KEY, JSON.stringify(state)); }, [state, mounted]);

  const next = () => setState((s) => ({ ...s, currentStep: Math.min(s.currentStep + 1, 2) }));
  const setOs = (os: OS) => setState((s) => ({ ...s, os }));

  if (!mounted) {
    return <div className="flex min-h-[400px] items-center justify-center"><div className="h-8 w-8 animate-spin rounded-full border-2 border-primary border-t-transparent" /></div>;
  }

  return (
    <div className="mx-auto max-w-2xl">
      <div className="mb-10 flex justify-center"><StepIndicator steps={STEPS} currentStep={state.currentStep} /></div>
      {state.currentStep === 0 && <StepAccounts onNext={next} />}
      {state.currentStep === 1 && <StepOs os={state.os} setOs={setOs} onNext={next} />}
      {state.currentStep === 2 && <StepInstall os={state.os} />}
    </div>
  );
}
