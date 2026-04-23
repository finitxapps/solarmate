import { motion } from "framer-motion";
import { ReactNode } from "react";

export function AnimatedStep({ children, safeId, index }: { children: ReactNode, safeId: string, index: number }) {
    return (
        <motion.div
            key={safeId}
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: index * 0.05 }}
        >
            {children}
        </motion.div>
    );
}