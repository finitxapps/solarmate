import { create } from "zustand";
import { CalculatorFormValues } from "./form-schema";
import { ApplianceOption } from "@/lib/api-service";

interface CalculatorState {
    currentStep: number;
    formData: Partial<CalculatorFormValues>;
    apiOptions: ApplianceOption[] | null;
    TOTAL_STEPS: number;
    isLoading: boolean;

    setStep: (step: number) => void;
    nextStep: () => void;
    prevStep: () => void;
    updateFormData: (data: Partial<CalculatorFormValues>) => void;
    setApiOptions: (options: ApplianceOption[]) => void;
}

export const useCalculatorStore = create<CalculatorState>((set) => ({
    currentStep: 1,
    formData: {
        consumers: [{ id: "initial-item", appliance_id: "", category: "" }],
        concurrent_usage: [],
    },
    apiOptions: null,
    TOTAL_STEPS: 8,
    isLoading: true,

    setStep: (step) => set({ currentStep: step }),
    nextStep: () => set((state) => ({ currentStep: state.currentStep + 1 })),
    prevStep: () => set((state) => ({ currentStep: Math.max(1, state.currentStep - 1) })),

    updateFormData: (data) => set((state) => ({
        formData: { ...state.formData, ...data }
    })),

    setApiOptions: (options) => set({ apiOptions: options, isLoading: false }),
}));