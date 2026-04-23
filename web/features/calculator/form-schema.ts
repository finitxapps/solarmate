import { expectations, meterTypes } from "@/types/calculator";
import { z } from "zod";

const consumerSchema = z.object({
    id: z.string(),
    appliance_id: z.string().min(1, "Please select an appliance"),
    category: z.string(),
    wattage: z.string().optional(),
    ac_capacity: z.string().optional(),
    ac_inverter: z.enum(["Yes", "No"]).optional(),
}).superRefine((data, ctx) => {
    if (data.category === "Air Conditioner") {
        if (!data.ac_capacity) {
            ctx.addIssue({ code: "custom", path: ["ac_capacity"], message: "Capacity is required" });
        }
        if (!data.ac_inverter) {
            ctx.addIssue({ code: "custom", path: ["ac_inverter"], message: "Required" });
        }
    }
    if (data.category === "Television" || data.category === "Refrigerator" || data.category === "Other") {
        if (!data.wattage) {
            ctx.addIssue({ code: "custom", path: ["wattage"], message: "Wattage is required" });
        }
    }
});

export const calculatorSchema = z.object({
    consumers: z.array(consumerSchema).min(1, "Add at least one consumer"),
    concurrent_usage: z.array(z.string()).optional(),
    roof_area: z.number({ message: "Please enter your Roof Area" }),
    location: z.object({
        lat: z.number().optional().or(z.nan().transform(() => undefined)),
        lng: z.number().optional().or(z.nan().transform(() => undefined))
    }).optional().superRefine((data, ctx) => {
        const hasLat = data?.lat !== undefined;
        const hasLng = data?.lng !== undefined;
        if (hasLat !== hasLng) {
            ctx.addIssue({
                code: "custom",
                path: ["lat"],
                message: "Either enter both lat and lng or skip this step"
            })
        }
    }),
    meter_type: z.enum(meterTypes, {
        message: "Please select a meter type"
    }),
    roof_photo: z.any()
        .optional()
        .refine((files) => {
            if (!files || files.length === 0) return true;
            return true;
        })
        .refine((files) => {
            if (!files || files.length === 0) return true;
            return files[0]?.size <= 5 * 1024 * 1024;
        }, "Max file size is 5MB")
        .refine((files) => {
            if (!files || files.length === 0) return true;
            const acceptedImageTypes = ['image/jpeg', 'image/png', 'image/webp'];
            return acceptedImageTypes.includes(files[0]?.type);
        }, "Only .jpg, .png, and .webp formats are supported"),
    floor_number: z.number().optional().or(z.nan().transform(() => undefined)),
    expectations: z.enum(expectations, {
        message: "Please select your expectations for power outages",
    }
    )
});

export type CalculatorFormValues = z.infer<typeof calculatorSchema>;