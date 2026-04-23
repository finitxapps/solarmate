import { Layers, Zap } from "lucide-react";
import { useFormContext } from "react-hook-form";

import { Card } from "@/components/ui/card";
import { Checkbox } from "@/components/ui/checkbox";
import { Label } from "@/components/ui/label";
import { CalculatorFormValues } from "@/features/calculator/form-schema";
import { useCalculatorStore } from "@/features/calculator/store";
import { AnimatedStep } from "../animated-step";

export function Step2Concurrent() {
    const { apiOptions } = useCalculatorStore();
    const { watch, setValue } = useFormContext<CalculatorFormValues>();

    const consumers = watch("consumers") || [];
    const concurrentUsage = watch("concurrent_usage") || [];

    const handleToggle = (id: string, isChecked: boolean) => {
        if (isChecked) {
            setValue("concurrent_usage", [...concurrentUsage, id], { shouldValidate: true });
        } else {
            setValue(
                "concurrent_usage",
                concurrentUsage.filter((itemId) => itemId !== id),
                { shouldValidate: true }
            );
        }
    };

    const getApplianceName = (applianceId?: string) => {
        if (!applianceId || !apiOptions) return "Unconfigured Appliance";
        const appliance = apiOptions.find((opt) => opt.id === applianceId);
        return appliance?.displayName || "Unknown Appliance";
    };

    const validConsumers = consumers.filter((c) => c.appliance_id);

    if (validConsumers.length === 0) {
        return (
            <div className="space-y-6 text-center py-10">
                <Layers className="h-12 w-12 text-muted-foreground mx-auto opacity-50 mb-4" />
                <h2 className="text-xl font-semibold text-foreground">No appliances defined</h2>
                <p className="text-muted-foreground">Please go back to Step 1 and add at least one appliance.</p>
            </div>
        );
    }

    return (
        <div className="space-y-6">
            <div className="space-y-1">
                <h2 className="text-2xl font-bold text-foreground">Concurrent Usage</h2>
                <p className="text-muted-foreground text-sm">
                    Select the appliances that will be running at the exact same time. This determines your peak load.
                </p>
            </div>

            <div className="grid gap-3 max-h-[50vh] overflow-y-auto p-2">
                {validConsumers.map((consumer, index) => {
                    // Fallback ID to prevent duplicate key crashes if crypto.randomUUID() failed in Step 1
                    const safeId = consumer.id || `fallback-id-${index}`;
                    const isChecked = concurrentUsage.includes(safeId);
                    const displayName = getApplianceName(consumer.appliance_id);

                    return (
                        <AnimatedStep index={index} safeId={safeId} key={safeId}
                        >
                            <Card
                                className={`relative overflow-hidden transition-all duration-200 ${isChecked
                                    ? "border-primary bg-primary/5 shadow-md"
                                    : "border-border bg-card hover:border-primary/50"
                                    }`}
                            >
                                <div className="flex items-center space-x-4 p-4">
                                    <Checkbox
                                        id={`checkbox-${safeId}`}
                                        checked={isChecked}
                                        onCheckedChange={(checked) => handleToggle(safeId, checked as boolean)}
                                        className="h-5 w-5"
                                    />

                                    <div className="flex flex-col grow">
                                        <Label
                                            htmlFor={`checkbox-${safeId}`}
                                            className="text-base font-medium cursor-pointer text-foreground flex items-center gap-2"
                                        >
                                            <Zap className={`h-4 w-4 ${isChecked ? "text-primary" : "text-muted-foreground"}`} />
                                            {displayName}
                                        </Label>

                                        <span className="text-xs text-muted-foreground mt-1">
                                            {consumer.category === "Air Conditioner" && consumer.ac_capacity
                                                ? `${consumer.ac_capacity} BTU | Inverter: ${consumer.ac_inverter || "N/A"}`
                                                : consumer.wattage
                                                    ? `${consumer.wattage} Watts`
                                                    : "Power draw not specified"}
                                        </span>
                                    </div>
                                </div>
                            </Card>
                        </AnimatedStep>
                    );
                })}
            </div>
        </div>
    );
}