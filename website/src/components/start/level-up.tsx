import { Card } from "@/components/ui/card";
import { LEVEL_UPS } from "@/lib/constants";
import { Github, Rocket, ExternalLink } from "lucide-react";

const iconMap = { Github, Rocket };

export function LevelUp() {
  return (
    <div>
      <h2 className="mb-2 text-2xl font-bold">Level up</h2>
      <p className="mb-6 text-muted-foreground">Optional next steps to unlock more power.</p>
      <div className="grid gap-4 sm:grid-cols-2">
        {LEVEL_UPS.map((item) => {
          const Icon = iconMap[item.icon];
          return (
            <Card key={item.title}>
              <div className="mb-3 flex h-10 w-10 items-center justify-center rounded-xl bg-secondary">
                <Icon size={20} className="text-primary" />
              </div>
              <h3 className="mb-1 font-semibold">{item.title}</h3>
              <p className="text-sm text-muted-foreground">{item.description}</p>
              {item.href && (
                <a href={item.href} target="_blank" rel="noopener noreferrer" className="mt-3 inline-flex items-center gap-1.5 text-sm font-medium text-primary hover:underline">
                  Set up <ExternalLink size={14} />
                </a>
              )}
            </Card>
          );
        })}
      </div>
    </div>
  );
}
