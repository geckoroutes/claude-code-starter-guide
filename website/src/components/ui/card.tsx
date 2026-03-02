interface CardProps {
  children: React.ReactNode;
  className?: string;
  hover?: boolean;
}

export function Card({ children, className = "", hover = true }: CardProps) {
  return (
    <div className={`rounded-xl border border-border bg-card p-6 shadow-sm ${hover ? "transition-all duration-200 hover:shadow-md hover:-translate-y-0.5" : ""} ${className}`}>
      {children}
    </div>
  );
}
