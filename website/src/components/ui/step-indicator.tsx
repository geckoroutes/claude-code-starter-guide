"use client";

import { Check } from "lucide-react";

export function StepIndicator({ steps, currentStep }: { steps: string[]; currentStep: number }) {
  return (
    <div className="flex items-center gap-3">
      {steps.map((label, i) => {
        const isCompleted = i < currentStep;
        const isCurrent = i === currentStep;
        return (
          <div key={label} className="flex items-center gap-3">
            <div className="flex items-center gap-2">
              <div className={`flex h-8 w-8 items-center justify-center rounded-full text-sm font-semibold transition-all duration-300 ${isCompleted ? "bg-accent text-accent-foreground" : isCurrent ? "bg-primary text-primary-foreground" : "bg-muted text-muted-foreground"}`}>
                {isCompleted ? <Check size={16} /> : i + 1}
              </div>
              <span className={`hidden text-sm font-medium sm:inline ${isCurrent ? "text-foreground" : "text-muted-foreground"}`}>{label}</span>
            </div>
            {i < steps.length - 1 && <div className={`h-0.5 w-8 rounded transition-colors duration-300 ${isCompleted ? "bg-accent" : "bg-border"}`} />}
          </div>
        );
      })}
    </div>
  );
}
