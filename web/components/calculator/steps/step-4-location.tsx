import { useFormContext } from "react-hook-form";
import { CalculatorFormValues } from '../../../features/calculator/form-schema';
import { Input } from "@/components/ui/input";

export function Step4Location() {
    const { register, formState: { errors } } = useFormContext<CalculatorFormValues>();

    return (
        <div className="space-y-6">
            <div className="space-y-1">
                <div className="flex justify-between items-end">
                    <h2 className="text-2xl font-bold text-foreground">Location</h2>
                    <span className="text-xs bg-muted text-muted-foreground px-2 py-1 rounded-full font-medium">
                        Optional
                    </span>
                </div>
                <p className="text-muted-foreground text-sm">
                    Enter your location
                </p>
            </div>

            <div className="space-y-1">
                <div className="relative grid md:grid-cols-2 gap-2">
                    <Input
                        type="number"
                        step="any"
                        placeholder="Latitude"
                        {...register("location.lat", { valueAsNumber: true })}
                    />
                    <Input
                        type="number"
                        step="any"
                        placeholder="Longitude"
                        {...register("location.lng", { valueAsNumber: true })}
                    />
                </div>

                <div className="min-h-[30px] px-1 pt-1">
                    {errors.location?.lat && (
                        <p className="text-sm text-destructive">
                            {errors.location.lat.message}
                        </p>
                    )}
                </div>
            </div>
        </div>
    );
}