import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { meterType, meterTypes } from "@/types/calculator";
import { useFormContext } from "react-hook-form";
import { CalculatorFormValues } from '../../../features/calculator/form-schema';

export function Step5MeterType() {
    const { setValue, watch, formState: { errors } } = useFormContext<CalculatorFormValues>();

    const meterType = watch("meter_type");
    return (
        <div className="space-y-6">
            <div className="space-y-1">
                <h2 className="text-2xl font-bold text-foreground">Select your electricity meter type</h2>
            </div>

            <div className="space-y-1 w-full">
                <div className="relative w-full">
                    <Select value={meterType} onValueChange={(val) => {
                        setValue("meter_type", val as meterType, { shouldValidate: true });
                    }}>
                        <SelectTrigger className="w-full">
                            <SelectValue placeholder={meterTypes.join(" | ")} />
                        </SelectTrigger>
                        <SelectContent>
                            {meterTypes.map((meterType) => (
                                <SelectItem value={meterType} key={meterType}>{meterType}</SelectItem>
                            ))}
                        </SelectContent>
                    </Select>
                </div>

                <div className="min-h-[30px] px-1 pt-1">
                    {errors.meter_type && (
                        <p className="text-sm text-destructive">
                            {errors.meter_type.message}
                        </p>
                    )}
                </div>
            </div>
        </div>
    );
}