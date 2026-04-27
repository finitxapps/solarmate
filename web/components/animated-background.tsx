"use client";

import { motion } from "framer-motion";

export function AnimatedBackground() {
    return (
        <div className="fixed inset-0 overflow-hidden pointer-events-none -z-10 bg-background">

            <motion.div
                animate={{ rotate: 360 }}
                transition={{ duration: 25, repeat: Infinity, ease: "linear" }}
                style={{
                    x: "-50%",
                    y: "-50%",
                    background: "conic-gradient(from 0deg, var(--primary), var(--background), var(--secondary), var(--background), var(--primary))",
                }}
                className="absolute top-1/2 left-1/2 w-[150vw] h-[150vw] md:w-screen md:h-[100vw] opacity-60 dark:opacity-80 blur-[60px] rounded-full"
            />
        </div>
    );
}