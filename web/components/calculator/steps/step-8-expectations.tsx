import { useFormContext } from "react-hook-form";
import { Lightbulb, Snowflake } from "lucide-react";
import { CalculatorFormValues } from '../../../features/calculator/form-schema';
import { Card } from "@/components/ui/card";
import { expectation } from "@/types/calculator";

export function Step8Expectations() {
    const { watch, setValue, formState: { errors, submitCount } } = useFormContext<CalculatorFormValues>();

    const currentExpectation = watch("expectations");

    const handleSelect = (value: expectation) => {
        setValue("expectations", value, { shouldValidate: true });
    };

    return (
        <div className="space-y-6">
            <div className="space-y-1">
                <h2 className="text-2xl font-bold text-foreground">Outage Expectations</h2>
                <p className="text-muted-foreground text-sm">
                    When the electricity grid is out and there is no sun (e.g., cloudy days or at night), what do you expect from your system?
                </p>
            </div>

            <div className="space-y-4">
                <div className="grid gap-4">
                    <Card
                        onClick={() => handleSelect("emergencies only (refs, lights)")}
                        className={`relative overflow-hidden cursor-pointer transition-all duration-200 p-5 ${currentExpectation === "emergencies only (refs, lights)"
                            ? "border-amber-500 bg-amber-500/5 shadow-md"
                            : "border-border bg-card hover:border-amber-500/30"
                            }`}
                    >
                        <div className="flex items-start space-x-4">
                            <div className={`p-3 rounded-lg shrink-0 ${currentExpectation === "emergencies only (refs, lights)"
                                ? "bg-amber-500/20 text-amber-600 dark:text-amber-400"
                                : "bg-muted text-muted-foreground"
                                }`}>
                                <Lightbulb className="w-6 h-6" />
                            </div>
                            <div>
                                <h3 className="font-semibold text-foreground text-base">
                                    Emergencies Only
                                </h3>
                                <p className="text-sm text-muted-foreground mt-1">
                                    Keep refrigerators, Wi-Fi, and basic lighting running.
                                    Air conditioners and heavy appliances will turn off.
                                </p>
                            </div>
                        </div>
                    </Card>

                    <Card
                        onClick={() => handleSelect("up + AC | coolers for 5hrs")}
                        className={`relative overflow-hidden cursor-pointer transition-all duration-200 p-5 ${currentExpectation === "up + AC | coolers for 5hrs"
                            ? "border-primary bg-primary/5 shadow-md"
                            : "border-border bg-card hover:border-primary/30"
                            }`}
                    >
                        <div className="flex items-start space-x-4">
                            <div className={`p-3 rounded-lg shrink-0 ${currentExpectation === "up + AC | coolers for 5hrs"
                                ? "bg-primary/20 text-primary"
                                : "bg-muted text-muted-foreground"
                                }`}>
                                <Snowflake className="w-6 h-6" />
                            </div>
                            <div>
                                <h3 className="font-semibold text-foreground text-base">
                                    Heavy Usage
                                </h3>
                                <p className="text-sm text-muted-foreground mt-1">
                                    Full power backup. Keep everything running, including AC units and coolers, for up to 5 hours.
                                </p>
                            </div>
                        </div>
                    </Card>
                </div>

                <div className="min-h-[30px] px-1 pt-1">
                    {errors.expectations && (
                        <p className="text-sm text-destructive">
                            {errors.expectations.message}
                        </p>
                    )}
                </div>
            </div>
        </div>
    );
}