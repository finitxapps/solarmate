import { useFormContext } from "react-hook-form";
import { CalculatorFormValues } from "@/features/calculator/form-schema";
import { useCalculatorStore } from "@/features/calculator/store";
import { Button } from "@/components/ui/button";
import { Stepper } from "@/components/ui/stepper";
import { Zap, Plus, Minus } from "lucide-react";

export function Step2Concurrent() {
    const { apiOptions } = useCalculatorStore();
    const { watch, setValue } = useFormContext<CalculatorFormValues>();

    const consumers = watch("consumers") || [];
    const concurrentUsage = watch("concurrent_usage") || [];

    if (consumers.length === 0) {
        return (
            <div className="text-center py-8 border-2 border-dashed border-border rounded-xl bg-muted/10">
                <p className="text-sm text-muted-foreground">Please add appliances in the previous step first.</p>
            </div>
        );
    }

    return (
        <div className="space-y-6">
            <div className="space-y-1">
                <h2 className="text-2xl font-bold text-foreground">Concurrent Usage</h2>
                <p className="text-muted-foreground text-sm">
                    Specify how many of each appliance will run at the exact same time.
                </p>
            </div>

            <div className="space-y-3">
                {consumers.map((consumer) => {
                    const applianceDetails = apiOptions?.find(a => a.id === consumer.appliance_id);
                    const maxCount = consumer.count || 1;

                    // Count how many units of this specific consumer exist in the concurrent_usage array
                    const activeIds = concurrentUsage.filter(id => id.startsWith(`${consumer.id}-`));
                    const currentConcurrentCount = activeIds.length;

                    const handleIncrement = () => {
                        if (currentConcurrentCount < maxCount) {
                            // Push a uniquely indexed ID to the array (e.g., "baseId-0", "baseId-1")
                            setValue(
                                "concurrent_usage",
                                [...concurrentUsage, `${consumer.id}-${currentConcurrentCount}`],
                                { shouldValidate: true }
                            );
                        }
                    };

                    const handleDecrement = () => {
                        if (currentConcurrentCount > 0) {
                            // Target the highest indexed ID to remove
                            const idToRemove = `${consumer.id}-${currentConcurrentCount - 1}`;
                            setValue(
                                "concurrent_usage",
                                concurrentUsage.filter(id => id !== idToRemove),
                                { shouldValidate: true }
                            );
                        }
                    };

                    return (
                        <div
                            key={consumer.id}
                            className={`flex flex-col md:flex-row gap-4 items-center justify-between p-4 border rounded-xl transition-all ${currentConcurrentCount > 0
                                ? "border-primary bg-primary/5"
                                : "border-border bg-card hover:border-primary/50"
                                }`}
                        >
                            <div className="flex items-center gap-4">
                                <div className={`p-2 rounded-lg transition-colors ${currentConcurrentCount > 0
                                    ? "bg-primary/20 text-primary"
                                    : "bg-muted text-muted-foreground"
                                    }`}>
                                    <Zap className="h-5 w-5" />
                                </div>
                                <div>
                                    <p className="text-sm font-semibold text-foreground">
                                        {applianceDetails?.displayName || "Unknown Appliance"}
                                    </p>
                                    <p className="text-xs text-muted-foreground mt-0.5">
                                        System Total: {maxCount} | {applianceDetails?.defaultWattage}W each
                                    </p>
                                </div>
                            </div>

                            {/* Precise Quantity Stepper */}
                            <Stepper
                                currentCount={currentConcurrentCount}
                                handleReduce={handleDecrement}
                                minusDisabled={currentConcurrentCount <= 0}
                                handleIncrease={handleIncrement}
                                plusDisabled={currentConcurrentCount === maxCount}
                            />
                        </div>
                    );
                })}
            </div>
        </div>
    );
}