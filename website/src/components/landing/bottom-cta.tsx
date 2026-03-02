import { Button } from "@/components/ui/button";

export function BottomCta() {
  return (
    <section className="px-6 py-16 md:py-20">
      <div className="mx-auto max-w-md text-center">
        <p className="mb-6 text-lg text-muted-foreground">
          That&apos;s it. Three steps and you&apos;re building things you never thought you could.
        </p>
        <Button href="/setup" size="lg">Start setup</Button>
      </div>
    </section>
  );
}
