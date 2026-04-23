import { useFormContext } from "react-hook-form";
import { CalculatorFormValues } from '../../../features/calculator/form-schema';
import { Input } from "@/components/ui/input";

export function Step7Roof() {
    const { register, formState: { errors } } = useFormContext<CalculatorFormValues>();

    return (
        <div className="space-y-6">
            <div className="flex justify-between items-end">
                <h2 className="text-2xl font-bold text-foreground">Floor Number</h2>
                <span className="text-xs bg-muted text-muted-foreground px-2 py-1 rounded-full font-medium">
                    Optional
                </span>
            </div>

            <div className="space-y-2">
                <div className="relative">
                    <Input
                        type="number"
                        placeholder="e.g., 3"
                        {...register("floor_number", { valueAsNumber: true })}
                    />
                </div>

                <div className="min-h-[30px] px-1 pt-1">
                    {errors.floor_number && (
                        <p className="text-sm text-destructive">{errors.floor_number.message}</p>
                    )}
                </div>
            </div>
        </div>
    );
}