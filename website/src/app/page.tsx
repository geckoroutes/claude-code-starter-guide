import { Hero } from "@/components/landing/hero";
import { HowItWorks } from "@/components/landing/how-it-works";
import { AnimatedDemo } from "@/components/landing/animated-demo";
import { BuildCards } from "@/components/landing/build-cards";
import { BottomCta } from "@/components/landing/bottom-cta";

export default function Home() {
  return (
    <>
      <Hero />
      <HowItWorks />
      <AnimatedDemo />
      <BuildCards />
      <BottomCta />
    </>
  );
}
