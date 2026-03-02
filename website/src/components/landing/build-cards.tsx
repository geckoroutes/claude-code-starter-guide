import { Card } from "@/components/ui/card";

const EXAMPLES = [
  { prompt: "Build me a landing page for a dog walking business", result: "Full website with hero, pricing, contact form", time: "~3 min" },
  { prompt: "Go to competitor.com and analyze their strategy", result: "Detailed report with actionable priorities", time: "~2 min" },
  { prompt: "Create an invoice generator I can use", result: "Working tool with PDF export and calculations", time: "~5 min" },
  { prompt: "Fix the login bug in my app", result: "Bug found, explained, and fixed", time: "~1 min" },
  { prompt: "Open my Notion and organize my tasks", result: "Restructured workspace with automation tips", time: "~4 min" },
  { prompt: "Ship my-app", result: "Built, tested, deployed to your server", time: "~2 min" },
];

export function BuildCards() {
  return (
    <section className="bg-muted/30 px-6 py-16 md:py-24">
      <div className="mx-auto max-w-3xl">
        <h2 className="mb-2 text-center text-2xl font-bold md:text-3xl">Things people ask Claude to do</h2>
        <p className="mb-10 text-center text-muted-foreground">Real prompts, real results. You just type and it happens.</p>
        <div className="grid gap-3 sm:grid-cols-2">
          {EXAMPLES.map((ex) => (
            <Card key={ex.prompt} hover={false} className="p-4">
              <p className="mb-2 text-sm font-medium leading-snug">&ldquo;{ex.prompt}&rdquo;</p>
              <div className="flex items-center justify-between text-xs text-muted-foreground">
                <span>{ex.result}</span>
                <span className="shrink-0 rounded-full bg-accent/10 px-2 py-0.5 font-medium text-accent">{ex.time}</span>
              </div>
            </Card>
          ))}
        </div>
      </div>
    </section>
  );
}
