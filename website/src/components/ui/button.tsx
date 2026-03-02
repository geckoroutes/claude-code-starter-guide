import Link from "next/link";

type ButtonVariant = "primary" | "secondary";
type ButtonSize = "sm" | "md" | "lg";

interface ButtonProps {
  children: React.ReactNode;
  href?: string;
  variant?: ButtonVariant;
  size?: ButtonSize;
  fullWidth?: boolean;
  onClick?: () => void;
  className?: string;
}

const variants: Record<ButtonVariant, string> = {
  primary: "bg-primary text-primary-foreground hover:bg-primary-hover shadow-md hover:shadow-lg",
  secondary: "bg-secondary text-secondary-foreground hover:bg-primary hover:text-primary-foreground border border-border",
};

const sizes: Record<ButtonSize, string> = {
  sm: "px-4 py-2 text-sm",
  md: "px-6 py-3 text-base",
  lg: "px-8 py-4 text-lg",
};

export function Button({ children, href, variant = "primary", size = "md", fullWidth, onClick, className = "" }: ButtonProps) {
  const classes = `inline-flex items-center justify-center gap-2 rounded-xl font-semibold transition-all duration-200 cursor-pointer ${variants[variant]} ${sizes[size]} ${fullWidth ? "w-full" : ""} ${className}`;

  if (href) {
    const isExternal = href.startsWith("http");
    if (isExternal) {
      return <a href={href} target="_blank" rel="noopener noreferrer" className={classes}>{children}</a>;
    }
    return <Link href={href} className={classes}>{children}</Link>;
  }

  return <button onClick={onClick} className={classes}>{children}</button>;
}
