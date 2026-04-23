"use client";

import { zodResolver } from "@hookform/resolvers/zod";
import { AnimatePresence, motion } from "framer-motion";
import { Loader2 } from "lucide-react";
import { useEffect } from "react";
import { FormProvider, useForm } from "react-hook-form";

import { CalculatorFormValues, calculatorSchema } from "@/features/calculator/form-schema";
import { useCalculatorStore } from "@/features/calculator/store";
import { fetchAppliances } from "@/lib/api-service";

import { FormNavigation } from "@/components/calculator/form-navigation";
import { StepRenderer } from "@/components/calculator/step-renderer";
import { Card } from "@/components/ui/card";
import { Progress } from "@/components/ui/progress";

export default function Calculator() {
    const { formData, updateFormData, currentStep, TOTAL_STEPS, setApiOptions, isLoading } = useCalculatorStore();

    const methods = useForm<CalculatorFormValues>({
        resolver: zodResolver(calculatorSchema),
        defaultValues: formData as CalculatorFormValues,
        mode: "onTouched",
    });

    useEffect(() => {
        let mounted = true;

        const initData = async () => {
            try {
                const appliances = await fetchAppliances();
                if (mounted) {
                    setApiOptions(appliances);
                }
            } catch (err) {
                console.error("Failed to fetch", err);
            }
        };

        initData();
        return () => { mounted = false; };
    }, [setApiOptions]);

    const onSubmit = (data: CalculatorFormValues) => {
        updateFormData(data);
        console.log("FINAL PAYLOAD:", data);
    };

    if (isLoading) {
        return (
            <div className="min-h-screen flex flex-col items-center justify-center text-muted-foreground bg-background">
                <Loader2 className="h-10 w-10 animate-spin mb-4 text-primary" />
                <p className="font-medium animate-pulse">Loading configuration...</p>
            </div>
        );
    }

    return (
        <div className="min-h-screen py-12 px-4">
            <div className="max-w-2xl mx-auto space-y-8">

                <div className="space-y-4">
                    <div className="flex justify-between items-end">
                        <h1 className="text-3xl font-extrabold tracking-tight text-foreground">Solar Calculator</h1>
                        <span className="text-sm font-medium text-muted-foreground">Step {currentStep} of {TOTAL_STEPS}</span>
                    </div>
                    <Progress value={(currentStep / TOTAL_STEPS) * 100} className="h-2 w-full" />
                </div>

                <Card className="p-6 shadow-lg bg-card border-border overflow-hidden">
                    <FormProvider {...methods}>
                        <form onSubmit={methods.handleSubmit(onSubmit)} className="flex flex-col">
                            <motion.div layout className="grow relative min-h-[350px]">
                                <AnimatePresence mode="popLayout" initial={false}>
                                    <motion.div
                                        key={currentStep}
                                        layout
                                        initial={{ opacity: 0, x: 20 }}
                                        animate={{ opacity: 1, x: 0 }}
                                        exit={{ opacity: 0, x: -20 }}
                                        transition={{ duration: 0.3, ease: "easeInOut" }}
                                    >
                                        <StepRenderer step={currentStep} />
                                    </motion.div>
                                </AnimatePresence>
                            </motion.div>

                            <motion.div layout>
                                <FormNavigation />
                            </motion.div>
                        </form>
                    </FormProvider>
                </Card>
            </div>
        </div>
    );
}