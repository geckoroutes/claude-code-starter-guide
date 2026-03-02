"use client";

import { Card } from "@/components/ui/card";
import { CopyButton } from "@/components/ui/copy-button";
import { STARTER_PROMPTS } from "@/lib/constants";
import { MessageSquare } from "lucide-react";

export function PromptCards() {
  return (
    <div className="space-y-4">
      <h2 className="mb-6 text-2xl font-bold">Try these first</h2>
      {STARTER_PROMPTS.map((item) => (
        <Card key={item.prompt} hover={false} className="relative">
          <div className="flex items-start gap-3">
            <div className="flex h-8 w-8 shrink-0 items-center justify-center rounded-lg bg-secondary">
              <MessageSquare size={16} className="text-primary" />
            </div>
            <div className="min-w-0 flex-1">
              <p className="mb-1 font-medium leading-snug">{item.prompt}</p>
              <p className="text-sm text-muted-foreground">{item.description}</p>
            </div>
            <CopyButton text={item.prompt} className="shrink-0" />
          </div>
        </Card>
      ))}
    </div>
  );
}
