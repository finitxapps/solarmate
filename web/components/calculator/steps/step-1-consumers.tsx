import { AnimatePresence, motion } from "framer-motion";
import { Plus, Trash2, Zap } from "lucide-react";
import { useFieldArray, useFormContext } from "react-hook-form";


import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { CalculatorFormValues } from "@/features/calculator/form-schema";
import { useCalculatorStore } from "@/features/calculator/store";
import { AcInverter } from '../../../types/calculator';

export function Step1Consumers() {
    const { apiOptions } = useCalculatorStore();
    const { control, watch, setValue, formState: { errors } } = useFormContext<CalculatorFormValues>();
    const { fields, append, remove } = useFieldArray({ control, name: "consumers" });

    if (!apiOptions) return null;

    return (
        <div className="space-y-6">
            <div className="space-y-1">
                <h2 className="text-2xl font-bold text-foreground">Define Consumers</h2>
                <p className="text-muted-foreground text-sm">Select appliances and configure power draw.</p>
            </div>

            <div className="space-y-4 pr-2 pb-2">
                {fields.map((field, index) => {
                    const category = watch(`consumers.${index}.category`);
                    const fieldErrors = errors?.consumers?.[index];

                    return (
                        <Card key={field.id} className="border-l-4 border-l-primary bg-card shadow-sm">
                            <CardHeader className="py-3 px-4 flex flex-row items-center justify-between bg-muted/30">
                                <CardTitle className="text-sm font-semibold flex items-center gap-2 text-foreground">
                                    <Zap className="h-4 w-4 text-primary" /> Unit {index + 1}
                                </CardTitle>
                                {fields.length > 1 && (
                                    <Button variant="ghost" size="sm" className="h-8 w-8 p-0 text-destructive hover:bg-destructive/10" onClick={() => remove(index)}>
                                        <Trash2 className="h-4 w-4" />
                                    </Button>
                                )}
                            </CardHeader>
                            <CardContent className="p-4 space-y-4">

                                <div className="space-y-2">
                                    <Label className={fieldErrors?.appliance_id ? "text-destructive" : ""}>Appliance</Label>
                                    <Select
                                        onValueChange={(val) => {
                                            const item = apiOptions.find(a => a.id === val);
                                            setValue(`consumers.${index}.appliance_id`, val);
                                            setValue(`consumers.${index}.category`, item?.category || "");
                                            setValue(`consumers.${index}.wattage`, undefined);
                                            setValue(`consumers.${index}.ac_capacity`, undefined);
                                        }}
                                        defaultValue={field.appliance_id}
                                    >
                                        <SelectTrigger className={`bg-background ${fieldErrors?.appliance_id ? "border-destructive" : ""}`}>
                                            <SelectValue placeholder="e.g., Samsung Television" />
                                        </SelectTrigger>
                                        <SelectContent>
                                            {apiOptions.map((opt) => (
                                                <SelectItem key={opt.id} value={opt.id}>{opt.displayName}</SelectItem>
                                            ))}
                                        </SelectContent>
                                    </Select>
                                    <div className="min-h-[30px] px-1 pt-1">
                                        {fieldErrors?.appliance_id && <p className="text-xs text-destructive">{fieldErrors.appliance_id.message}</p>}
                                    </div>
                                </div>

                                <AnimatePresence mode="popLayout">
                                    {(category === "Television" || category === "Refrigerator" || category === "Other") && (
                                        <motion.div key="wattage" initial={{ opacity: 0, height: 0 }} animate={{ opacity: 1, height: "auto" }} exit={{ opacity: 0, height: 0 }} className="space-y-2">
                                            <Label className={fieldErrors?.wattage ? "text-destructive" : ""}>Wattage (W)</Label>
                                            <Input type="number" placeholder="e.g., 150" className="bg-background" {...control.register(`consumers.${index}.wattage`)} />
                                            <div className="min-h-[30px] px-1 pt-1">
                                                {fieldErrors?.wattage && <p className="text-xs text-destructive">{fieldErrors.wattage.message}</p>}
                                            </div>
                                        </motion.div>
                                    )}

                                    {category === "Air Conditioner" && (
                                        <motion.div key="ac" initial={{ opacity: 0, height: 0 }} animate={{ opacity: 1, height: "auto" }} exit={{ opacity: 0, height: 0 }} className="grid grid-cols-2 gap-4">
                                            <div className="space-y-2">
                                                <Label className={fieldErrors?.ac_capacity ? "text-destructive" : ""}>Capacity</Label>
                                                <Select onValueChange={(val) => setValue(`consumers.${index}.ac_capacity`, val)}>
                                                    <SelectTrigger className="bg-background"><SelectValue placeholder="BTU" /></SelectTrigger>
                                                    <SelectContent>
                                                        <SelectItem value="9k">9,000 BTU</SelectItem>
                                                        <SelectItem value="12k">12,000 BTU</SelectItem>
                                                        <SelectItem value="24k">24,000 BTU</SelectItem>
                                                    </SelectContent>
                                                </Select>
                                            </div>
                                            <div className="space-y-2">
                                                <Label className={fieldErrors?.ac_inverter ? "text-destructive" : ""}>Inverter</Label>
                                                <Select onValueChange={(val) => setValue(`consumers.${index}.ac_inverter`, val as AcInverter)}>
                                                    <SelectTrigger className="bg-background"><SelectValue placeholder="Yes/No" /></SelectTrigger>
                                                    <SelectContent>
                                                        <SelectItem value="Yes">Yes</SelectItem>
                                                        <SelectItem value="No">No</SelectItem>
                                                    </SelectContent>
                                                </Select>
                                            </div>
                                        </motion.div>
                                    )}
                                </AnimatePresence>

                            </CardContent>
                        </Card>
                    );
                })}
            </div>

            <Button type="button" variant="outline" className="w-full border-dashed bg-muted/30 hover:bg-primary/10" onClick={() => append({
                id: `item-${Date.now()}-${Math.floor(Math.random() * 1000)}`,
                appliance_id: "",
                category: ""
            })}
            >
                <Plus className="h-4 w-4 mr-2" /> Add Appliance
            </Button>
        </div>
    );
}