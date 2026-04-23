export type ApplianceCategory = "Television" | "Air Conditioner" | "Refrigerator" | "Other";

export interface ApplianceOption {
    id: string;
    displayName: string;
    category: ApplianceCategory;
}

export const fetchAppliances = async (): Promise<ApplianceOption[]> => {
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve([
                { id: "lg_ac", displayName: "LG Air Conditioner", category: "Air Conditioner" },
                { id: "general_ac", displayName: "O General Air Conditioner", category: "Air Conditioner" },
                { id: "samsung_tv", displayName: "Samsung Television", category: "Television" },
                { id: "sony_tv", displayName: "Sony Television", category: "Television" },
                { id: "bosch_fridge", displayName: "Bosch Refrigerator", category: "Refrigerator" },
            ]);
        }, 800);
    });
};