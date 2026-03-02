import { PromptCards } from "@/components/start/prompt-cards";
import { LevelUp } from "@/components/start/level-up";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Get Started | Claude Code Starter Guide",
  description: "You're set up. Here's what to try first with Claude Code.",
};

export default function StartPage() {
  return (
    <div className="px-6 py-16 md:py-24">
      <div className="mx-auto max-w-2xl">
        <div className="mb-12 text-center">
          <div className="mb-4 inline-flex items-center gap-2 rounded-full bg-accent/10 px-4 py-1.5 text-sm font-medium text-accent">Setup complete</div>
          <h1 className="mb-3 text-3xl font-bold md:text-4xl">You&apos;re in. Now build something.</h1>
          <p className="text-lg text-muted-foreground">Open VS Code, click the Claude icon in the top right, sign in, and paste any of these prompts.</p>
        </div>
        <div className="space-y-16">
          <PromptCards />
          <LevelUp />
        </div>
      </div>
    </div>
  );
}
