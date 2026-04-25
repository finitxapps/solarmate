import { Metadata } from "next";
import Calculator from "@/components/calculator/calculator";
import { AnimatedBackground } from "@/components/animated-background";

export const metadata: Metadata = {
  title: "Solar mate | Calculator",
  description: "Accurately calculate your solar panel requirements, inverter capacity, and battery backup needs based on your specific home appliances and usage.",
  keywords: ["solar calculator", "solar panel estimate", "off-grid calculator", "inverter size"],
  openGraph: {
    title: "Solar Energy Calculator",
    description: "Calculate your exact solar needs.",
    type: "website",
    url: "https://yourdomain.com/calculator",
  }
};

export default function CalculatorPage() {
  return (
    <main className="bg-transparent">
          <AnimatedBackground />
      <Calculator />
    </main>
  );
}