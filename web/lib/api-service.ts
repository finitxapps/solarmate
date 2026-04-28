export interface ApplianceOption {
    id: string;
    displayName: string;
    category: string;
    defaultWattage: number;
    surgeWattage: number;
}
interface RawConsumerResponse {
    id: string;
    consumerType: string;
    type: string;
    normalWattage: number;
    surgeWattage: number;
    inverter: boolean | null;
    amperControl: boolean;
    features: {
        [key: string]: string | boolean | undefined;
        inverter?: string;
        amperControl?: boolean;
    };
}

export const fetchAppliances = async (): Promise<ApplianceOption[]> => {
    try {
        const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/consumers`, {
            method: 'GET',
            headers: {
                'accept': '*/*',
            }
        });

        if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`);
        }

        const data: RawConsumerResponse[] = await response.json();

        return data.map((item) => {
            let category = "Other";

            if (item.type.includes("کولر")) {
                category = "Air Conditioner";
            } else if (item.type.includes("تلویزیون")) {
                category = "Television";
            } else if (item.type.includes("یخچال")) {
                category = "Refrigerator";
            }

            return {
                id: item.id,
                displayName: item.type,
                category: category,
                defaultWattage: item.normalWattage,
                surgeWattage: item.surgeWattage,
            };
        });
    } catch (error) {
        console.error("Failed to fetch appliances:", error);
        return [];
    }
};