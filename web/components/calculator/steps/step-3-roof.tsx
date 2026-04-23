import { useFormContext } from "react-hook-form";
import { CalculatorFormValues } from '../../../features/calculator/form-schema';
import { Input } from "@/components/ui/input";

export function Step3RoofArea() {
    const { register, formState: { errors } } = useFormContext<CalculatorFormValues>();

    return (
        <div className="space-y-6">
            <div className="space-y-1">
                <h2 className="text-2xl font-bold text-foreground">Roof Area</h2>
                <p className="text-muted-foreground text-sm">
                    Enter your available roof area in square meters.
                </p>
            </div>

            <div className="space-y-2">
                <div className="relative">
                    <Input
                        type="number"
                        placeholder="e.g., 50"
                        {...register("roof_area", { valueAsNumber: true })}
                    />
                    <span className="absolute right-4 top-2 text-muted-foreground font-medium">
                        m²
                    </span>
                </div>

                <div className="min-h-[30px] px-1 pt-1">
                    {errors.roof_area && (
                        <p className="text-sm text-destructive">{errors.roof_area.message}</p>
                    )}
                </div>
            </div>
        </div>
    );
}