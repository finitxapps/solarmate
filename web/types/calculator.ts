export const applianceTypes = ["Air Conditioner", "Refrigerator", "Television", "Lighting", "Washing Machine", "Other"] as const;
export type ApplianceTypes = typeof applianceTypes[number];

export const coolerTypes = ["Water cooler", "AC", "Chiller"] as const;
export type CoolerTypes = typeof coolerTypes[number];

export const acBrands = ["LG", "Ogneral", "Samsung", "Other"] as const;
export type AcBrands = typeof acBrands[number];

export const acCapacities = ["24k", "12k", "9k"] as const;
export type AcCapacity = typeof acCapacities[number];

export const acInverter = ["Yes", "No"] as const;
export type AcInverter = typeof acInverter[number];

export const meterTypes = ["1ph", "3ph", "none"];
export type meterType = typeof meterTypes[number];

export const expectations = ["emergencies only (refs, lights)", "up + AC | coolers for 5hrs"];
export type expectation = typeof expectations[number];