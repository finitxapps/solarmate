export type ApplianceCategory = "Television" | "Air Conditioner" | "Refrigerator" | "Other";

export interface ApplianceOption {
    id: string;
    displayName: string;
    category: ApplianceCategory;
    defaultWattage: number; // <-- Added this
}

export const fetchAppliances = async (): Promise<ApplianceOption[]> => {
    return new Promise((resolve) => {
        setTimeout(() => {
            resolve([
                { id: "lg_ac", displayName: "LG Air Conditioner", category: "Air Conditioner", defaultWattage: 1500 },
                { id: "general_ac", displayName: "O General AC", category: "Air Conditioner", defaultWattage: 1800 },
                { id: "samsung_tv", displayName: "Samsung TV", category: "Television", defaultWattage: 150 },
                { id: "sony_tv", displayName: "Sony TV", category: "Television", defaultWattage: 120 },
                { id: "bosch_fridge", displayName: "Bosch Refrigerator", category: "Refrigerator", defaultWattage: 400 },
                { id: "water_pump", displayName: "Water Pump", category: "Other", defaultWattage: 800 },
            ]);
        }, 800);
    });
};