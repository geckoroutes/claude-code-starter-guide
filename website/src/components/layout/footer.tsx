export function Footer() {
  return (
    <footer className="border-t border-border bg-muted/50 py-8">
      <div className="mx-auto max-w-5xl px-6 text-center text-sm text-muted-foreground">
        <p>
          Open source on{" "}
          <a href="https://github.com/geckoroutes/claude-code-starter-guide" target="_blank" rel="noopener noreferrer" className="font-medium text-foreground underline-offset-4 hover:underline">GitHub</a>.
          Built with Claude Code.
        </p>
      </div>
    </footer>
  );
}
