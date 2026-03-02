import { Wizard } from "@/components/setup/wizard";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Setup | Claude Code Starter Guide",
  description: "Get Claude Code running in 5 minutes. One command does everything.",
};

export default function SetupPage() {
  return (
    <div className="px-6 py-16 md:py-24">
      <div className="mx-auto mb-10 max-w-xl text-center">
        <h1 className="mb-3 text-3xl font-bold md:text-4xl">Setup in 5 minutes</h1>
        <p className="text-lg text-muted-foreground">Three steps. One command does the heavy lifting.</p>
      </div>
      <Wizard />
    </div>
  );
}
