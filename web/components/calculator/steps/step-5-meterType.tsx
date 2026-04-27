import { Label } from "@/components/ui/label";
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group";
import { meterType, meterTypes } from "@/types/calculator";
import { useFormContext } from "react-hook-form";
import { CalculatorFormValues } from '../../../features/calculator/form-schema';

export function Step5MeterType() {
    const { setValue, watch, formState: { errors } } = useFormContext<CalculatorFormValues>();
    const selectedMeter = watch("meter_type");

    return (
        <div className="space-y-6">
            <div className="space-y-1">
                <h2 className="text-2xl font-bold text-foreground">Select your electricity meter type</h2>
            </div>

            <RadioGroup
                // FIX: Fallback to empty string
                value={selectedMeter || ""}
                onValueChange={(val) => {
                    setValue("meter_type", val as meterType, { shouldValidate: true });
                }}
                className="grid gap-3"
            >
                {meterTypes.map((type) => (
                    <Label
                        key={type}
                        className={`flex items-center space-x-3 p-4 border rounded-xl cursor-pointer transition-all hover:bg-muted/50 ${selectedMeter === type
                            ? "border-primary bg-primary/5 ring-1 ring-primary"
                            : "border-border bg-card"
                            }`}
                    >
                        <RadioGroupItem value={type} id={type} />
                        <span className="text-sm font-medium text-foreground">{type}</span>
                    </Label>
                ))}
            </RadioGroup>

            <div className="min-h-[30px] px-1 pt-1">
                {errors.meter_type && (
                    <p className="text-sm text-destructive mt-2">
                        {errors.meter_type.message}
                    </p>
                )}
            </div>
        </div>
    );
}