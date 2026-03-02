import { Button } from "@/components/ui/button";
import { ArrowDown } from "lucide-react";

export function Hero() {
  return (
    <section className="px-6 pt-16 pb-8 md:pt-24 md:pb-12">
      <div className="mx-auto max-w-3xl text-center">
        <h1 className="mb-4 text-3xl font-bold leading-tight tracking-tight md:text-5xl md:leading-tight">
          Get Claude Code running<br className="hidden sm:block" /> in 5 minutes
        </h1>
        <p className="mx-auto mb-8 max-w-lg text-lg leading-relaxed text-muted-foreground">
          An AI assistant inside VS Code that writes code, controls your browser, and deploys your projects. You just chat with it in plain English.
        </p>
        <Button href="#steps" variant="secondary" size="md">
          See how it works <ArrowDown size={16} />
        </Button>
      </div>
    </section>
  );
}
