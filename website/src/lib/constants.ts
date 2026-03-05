export const SITE = {
  title: "Claude Code Starter Guide",
  description: "Build apps by talking to your computer. No coding required.",
  url: "https://claude-code-starter-guide.vercel.app",
  ogImage: "/og-image.png",
};

export const HERO = {
  headline: "Build apps by talking to your computer",
  subtitle: "Claude Code turns plain English into working software — in VS Code or from the command line. No coding experience required.",
  cta: "Get started — it's free",
  ctaHref: "/setup",
};

export const HOW_IT_WORKS = [
  { step: 1, title: "Describe what you want", description: 'Type in plain English: "Build me a landing page for my business"', icon: "MessageSquare" as const },
  { step: 2, title: "Claude builds it", description: "Claude writes the code, installs packages, and runs everything automatically", icon: "Code" as const },
  { step: 3, title: "Use your working app", description: "Open your browser and see the result. Chat back to refine it.", icon: "CheckCircle" as const },
];

export const BUILD_CARDS = [
  { title: "Landing pages", description: "Describe your business, get a complete website with copy, design, and contact forms.", icon: "Globe" as const },
  { title: "Competitor analysis", description: "Point Claude at any website and get actionable insights on design, copy, and strategy.", icon: "Search" as const },
  { title: "Business tools", description: "Invoice generators, dashboards, admin panels — describe it and Claude builds it.", icon: "Wrench" as const },
  { title: "Workflow automation", description: "Organize Notion, automate ClickUp, connect APIs — let Claude handle the busywork.", icon: "Zap" as const },
];

export const SETUP_STEPS = {
  accounts: {
    title: "Create your accounts",
    claudeUrl: "https://claude.ai/",
    claudeUpgradeUrl: "https://claude.ai/upgrade",
    vscodeUrl: "https://code.visualstudio.com/download",
  },
  os: { title: "Confirm your system" },
  install: {
    title: "Run one command",
    mac: "curl -fsSL https://raw.githubusercontent.com/geckoroutes/claude-code-starter-guide/master/setup-mac.sh -o setup-mac.sh && bash setup-mac.sh",
    windowsZip: "https://github.com/geckoroutes/claude-code-starter-guide/archive/refs/heads/master.zip",
    whatItDoes: [
      "Installs VS Code, Node.js, and Git (if not already installed)",
      "Installs the Claude Code extension",
      "Creates your workspace folder (default: ~/Projects)",
      "Creates a CLAUDE.md file — Claude reads this every session to know your preferences",
      "Connects your GitHub account (optional)",
      "Sets up browser control, live docs, and GitHub integration",
      "Installs design, marketing, security, and deployment skills",
      "Installs code intelligence and review plugins",
      "Enables bypass mode (Claude works without asking permission)",
    ],
  },
};

export const STARTER_PROMPTS = [
  { prompt: "Create a new Next.js project called my-app", description: "Scaffolds a full project with all the right settings" },
  { prompt: "Build me a landing page for [your business idea]", description: "Creates a complete website with hero, features, pricing, and contact form" },
  { prompt: "Go to www.mybusiness.com. Analyze the entire site and give me your top 5 priorities.", description: "Claude opens your browser, reviews everything, and gives actionable advice" },
  { prompt: "Open my browser and check if my site looks right", description: "Claude takes screenshots, spots issues, and fixes them on the spot" },
];

export const LEVEL_UPS = [
  { title: "Connect GitHub", description: "Let Claude manage your code repositories, create pull requests, and review code.", icon: "Github" as const, href: "https://github.com/settings/tokens/new?scopes=repo&description=Claude%20Code" },
  { title: "Add the deploy skill", description: 'Say "ship my-app" and Claude handles the full deployment — build, release, push to server.', icon: "Rocket" as const },
];

export const DEMO_SEQUENCE = {
  userMessage: "Build me a landing page for a dog walking business called PawPatrol",
  codeSnippet: `export default function Home() {
  return (
    <main className="min-h-screen">
      <section className="hero bg-amber-50 py-20">
        <h1>PawPatrol</h1>
        <p>Your dog deserves the best walks</p>
        <button>Book a Walk</button>
      </section>
      <section className="pricing grid grid-cols-3">
        <PriceCard plan="Basic" price="$15" />
        <PriceCard plan="Premium" price="$25" />
        <PriceCard plan="VIP" price="$40" />
      </section>
    </main>
  );
}`,
  resultTitle: "PawPatrol",
  resultSubtitle: "Your dog deserves the best walks in town",
  caption: "That just happened. In 2 minutes.",
};
