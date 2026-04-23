import { useFormContext } from "react-hook-form";
import { Button } from "@/components/ui/button";
import { useCalculatorStore } from "@/features/calculator/store";

export function FormNavigation() {
    const { trigger, getValues } = useFormContext();
    const { TOTAL_STEPS, currentStep, nextStep, prevStep, updateFormData } = useCalculatorStore();

    const handleNext = async () => {
        let isValid = false;

        switch (currentStep) {
            case 1: isValid = await trigger(["consumers"]); break;
            case 2: isValid = await trigger(["concurrent_usage"]); break;
            case 3: isValid = await trigger(["roof_area"]); break;
            case 4: isValid = await trigger(["location"]); break;
            case 5: isValid = await trigger(["meter_type"]); break;
            case 6: isValid = await trigger(["roof_photo"]); break;
            case 7: isValid = await trigger(["floor_number"]); break;
            case 8: isValid = await trigger(["expectations"]); break;
            default: isValid = true;
        }

        if (isValid) {
            updateFormData(getValues());
            nextStep();
        }
    };

    return (
        <div className="flex justify-between pt-6 mt-8 border-t border-border">
            <Button
                type="button"
                variant="outline"
                disabled={currentStep === 1}
                onClick={prevStep}
                className="w-28"
            >
                Back
            </Button>

            {currentStep < TOTAL_STEPS ? (
                <Button
                    key="btn-next"
                    type="button"
                    onClick={handleNext}
                    className="w-28"
                >
                    Next
                </Button>
            ) : (
                <Button
                    key="btn-calculate"
                    type="submit"
                    className="w-32 bg-green-600 hover:bg-green-700 text-white"
                >
                    Calculate
                </Button>
            )}
        </div>
    );
}