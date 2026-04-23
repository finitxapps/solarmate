import { useRef, useState } from "react";
import { AnimatePresence, motion, LayoutGroup } from "framer-motion";
import { Zap, PlusCircle, Monitor, Wind, Refrigerator, Plug, Plus, Minus, X } from "lucide-react";
import { useFieldArray, useFormContext } from "react-hook-form";

import { Button } from "@/components/ui/button";
import { Stepper } from "@/components/ui/stepper";
import { Label } from "@/components/ui/label";
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select";
import { useCalculatorStore } from "@/features/calculator/store";
import { CalculatorFormValues } from "@/features/calculator/form-schema";
import { AcInverter, Appliance } from "@/types/calculator";

const getCategoryIcon = (category: string) => {
    switch (category) {
        case "Television": return <Monitor className="w-4 h-4" />;
        case "Air Conditioner": return <Wind className="w-4 h-4" />;
        case "Refrigerator": return <Refrigerator className="w-4 h-4" />;
        default: return <Plug className="w-4 h-4" />;
    }
};

export function Step1Consumers() {
    const { apiOptions } = useCalculatorStore();
    const { control, watch, setValue, formState: { errors } } = useFormContext<CalculatorFormValues>();
    const { fields, prepend, remove } = useFieldArray({ control, name: "consumers" });

    const scrollRef = useRef<HTMLDivElement>(null);
    const [isDragging, setIsDragging] = useState(false);
    const [startX, setStartX] = useState(0);
    const [scrollLeft, setScrollLeft] = useState(0);

    const handleMouseDown = (e: React.MouseEvent) => {
        if (!scrollRef.current) return;
        setIsDragging(true);
        setStartX(e.pageX - scrollRef.current.offsetLeft);
        setScrollLeft(scrollRef.current.scrollLeft);
    };

    const handleMouseLeave = () => setIsDragging(false);
    const handleMouseUp = () => setIsDragging(false);

    const handleMouseMove = (e: React.MouseEvent) => {
        if (!isDragging || !scrollRef.current) return;
        e.preventDefault();
        const x = e.pageX - scrollRef.current.offsetLeft;
        const walk = (x - startX) * 2;
        scrollRef.current.scrollLeft = scrollLeft - walk;
    };

    if (!apiOptions) return null;

    const handleAddAppliance = (appliance: Appliance) => {
        if (isDragging) return;

        const existingIndex = fields.findIndex(f => f.appliance_id === appliance.id);

        if (existingIndex >= 0) {
            const currentCount = watch(`consumers.${existingIndex}.count`) || 1;
            setValue(`consumers.${existingIndex}.count`, currentCount + 1, { shouldValidate: true });
        } else {
            prepend({
                id: crypto.randomUUID(),
                appliance_id: appliance.id,
                category: appliance.category,
                wattage: appliance.defaultWattage,
                count: 1,
            });
        }
    };

    const activeFields = fields.filter(f => f.appliance_id);

    return (
        <LayoutGroup>
            <div className="space-y-8">

                <motion.div layout className="space-y-1">
                    <h2 className="text-2xl font-bold text-foreground">Define Consumers</h2>
                    <p className="text-muted-foreground text-sm">Click or drag to select appliances.</p>
                </motion.div>

                <motion.div layout className="relative group/scroll">
                    <div
                        ref={scrollRef}
                        onMouseDown={handleMouseDown}
                        onMouseLeave={handleMouseLeave}
                        onMouseUp={handleMouseUp}
                        onMouseMove={handleMouseMove}
                        className="flex space-x-3 overflow-x-auto pb-4 cursor-grab select-none no-scrollbar active:cursor-grabbing"
                        style={{ scrollBehavior: isDragging ? 'auto' : 'smooth' }}
                    >
                        {apiOptions.map((opt) => (
                            <button
                                key={opt.id}
                                type="button"
                                onClick={() => handleAddAppliance(opt)}
                                className="shrink-0 w-36 p-4 text-left border border-border rounded-xl bg-card hover:border-primary hover:bg-primary/5 transition-all group pointer-events-auto"
                            >
                                <div className="text-muted-foreground group-hover:text-primary transition-colors mb-2">
                                    {getCategoryIcon(opt.category)}
                                </div>
                                <p className="text-sm font-semibold text-foreground truncate">{opt.displayName}</p>
                                <div className="flex items-center justify-between mt-1">
                                    <p className="text-xs text-muted-foreground">{opt.defaultWattage}W</p>
                                    <PlusCircle className="w-4 h-4 text-primary opacity-0 group-hover:opacity-100 transition-opacity" />
                                </div>
                            </button>
                        ))}
                    </div>
                    <div className="absolute right-0 top-0 bottom-4 w-12 bg-linear-to-l from-background to-transparent pointer-events-none opacity-0 group-hover/scroll:opacity-100 transition-opacity" />
                </motion.div>

                <div className="space-y-4">
                    <AnimatePresence mode="wait">
                        {activeFields.length > 0 ? (
                            <motion.div
                                key="list-container"
                                layout
                                initial={{ opacity: 0 }}
                                animate={{ opacity: 1 }}
                                exit={{ opacity: 0 }}
                                // The new single container for all items
                                className="border border-border rounded-xl bg-card shadow-sm overflow-hidden divide-y divide-border/50"
                            >
                                {activeFields.map((field, index) => {
                                    const category = watch(`consumers.${index}.category`);
                                    const currentCount = watch(`consumers.${index}.count`) || 1;
                                    const fieldErrors = errors?.consumers?.[index];
                                    const applianceDetails = apiOptions.find(a => a.id === field.appliance_id);

                                    return (
                                        <motion.div
                                            key={field.id}
                                            layout
                                            initial={{ opacity: 0, backgroundColor: "hsl(var(--primary) / 0.1)" }}
                                            animate={{ opacity: 1, backgroundColor: "transparent" }}
                                            exit={{ opacity: 0, height: 0, overflow: "hidden" }}
                                            transition={{ duration: 0.3 }}
                                            className="p-4 sm:p-5 relative group/item"
                                        >
                                            <div className="flex justify-between">
                                                {/* Compact Row Header */}
                                                <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                                                    <div className="flex items-center gap-3 min-w-0">
                                                        <div className="p-2 bg-muted/50 rounded-lg text-muted-foreground group-hover/item:text-primary transition-colors">
                                                            {getCategoryIcon(category)}
                                                        </div>
                                                        <div className="truncate">
                                                            <p className="text-sm font-semibold text-foreground truncate">
                                                                {applianceDetails?.displayName || "Appliance"}
                                                            </p>
                                                            <p className="text-xs text-muted-foreground flex items-center gap-1 mt-0.5">
                                                                <Zap className="h-3 w-3" />
                                                                {field.wattage ? `${field.wattage}W` : 'Variable'} per unit
                                                            </p>
                                                        </div>
                                                    </div>

                                                    <div className="flex items-center gap-3 shrink-0">
                                                        <Stepper currentCount={currentCount}
                                                            handleReduce={() => {
                                                                if (currentCount > 1) {
                                                                    setValue(`consumers.${index}.count`, currentCount - 1, { shouldValidate: true });
                                                                }
                                                            }}
                                                            minusDisabled={currentCount <= 1}
                                                            handleIncrease={() => {
                                                                setValue(`consumers.${index}.count`, currentCount + 1, { shouldValidate: true });
                                                            }}
                                                        />
                                                    </div>
                                                </div>
                                                {/* Minimal Delete Button */}
                                                <Button
                                                    variant="ghost"
                                                    size="icon"
                                                    className="h-8 w-8 text-muted-foreground hover:text-destructive hover:bg-destructive/10 -mr-2 sm:mr-0"
                                                    onClick={() => remove(index)}
                                                >
                                                    <X className="h-4 w-4" />
                                                </Button>
                                            </div>

                                            {/* AC Config - Rendered inline below the row without bulky borders */}
                                            {category === "Air Conditioner" && (
                                                <div className="mt-4 pt-4 border-t border-dashed border-border/60 pl-0 sm:pl-11 grid grid-cols-2 gap-4">
                                                    <div className="space-y-1.5">
                                                        <Label className={`text-xs text-muted-foreground ${fieldErrors?.ac_capacity ? "text-destructive" : ""}`}>Capacity</Label>
                                                        <Select
                                                            defaultValue={field.ac_capacity}
                                                            onValueChange={(val) => setValue(`consumers.${index}.ac_capacity`, val, { shouldValidate: true })}
                                                        >
                                                            <SelectTrigger className="h-8 text-xs bg-background"><SelectValue placeholder="Select BTU" /></SelectTrigger>
                                                            <SelectContent>
                                                                <SelectItem value="9k" className="text-xs">9,000 BTU</SelectItem>
                                                                <SelectItem value="12k" className="text-xs">12,000 BTU</SelectItem>
                                                                <SelectItem value="24k" className="text-xs">24,000 BTU</SelectItem>
                                                            </SelectContent>
                                                        </Select>
                                                        {fieldErrors?.ac_capacity && <p className="text-[10px] text-destructive leading-none">{fieldErrors.ac_capacity.message}</p>}
                                                    </div>
                                                    <div className="space-y-1.5">
                                                        <Label className={`text-xs text-muted-foreground ${fieldErrors?.ac_inverter ? "text-destructive" : ""}`}>Inverter Tech</Label>
                                                        <Select
                                                            defaultValue={field.ac_inverter}
                                                            onValueChange={(val) => setValue(`consumers.${index}.ac_inverter`, val as AcInverter, { shouldValidate: true })}
                                                        >
                                                            <SelectTrigger className="h-8 text-xs bg-background"><SelectValue placeholder="Yes/No" /></SelectTrigger>
                                                            <SelectContent>
                                                                <SelectItem value="Yes" className="text-xs">Yes</SelectItem>
                                                                <SelectItem value="No" className="text-xs">No</SelectItem>
                                                            </SelectContent>
                                                        </Select>
                                                        {fieldErrors?.ac_inverter && <p className="text-[10px] text-destructive leading-none">{fieldErrors.ac_inverter.message}</p>}
                                                    </div>
                                                </div>
                                            )}
                                        </motion.div>
                                    );
                                })}
                            </motion.div>
                        ) : (
                            <motion.div
                                key="empty-state"
                                layout
                                initial={{ opacity: 0 }}
                                animate={{ opacity: 1 }}
                                exit={{ opacity: 0 }}
                                className="text-center py-10 border-2 border-dashed border-border rounded-xl bg-muted/10"
                            >
                                <div className="mx-auto w-10 h-10 rounded-full bg-muted flex items-center justify-center mb-3">
                                    <Plug className="w-5 h-5 text-muted-foreground/60" />
                                </div>
                                <p className="text-sm font-medium text-foreground">No appliances added yet</p>
                                <p className="text-xs text-muted-foreground mt-1">Select from the catalogue above to start building your load.</p>
                            </motion.div>
                        )}
                    </AnimatePresence>
                </div>
            </div>
        </LayoutGroup>
    );
}