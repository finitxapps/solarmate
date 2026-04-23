import { useFormContext } from "react-hook-form";
import { UploadCloud, Image as ImageIcon, X } from "lucide-react";
import { CalculatorFormValues } from '../../../features/calculator/form-schema';
import { Button } from "@/components/ui/button";

export function Step6RoofPhoto() {
    const { register, watch, setValue, formState: { errors } } = useFormContext<CalculatorFormValues>();

    const rawPhoto = watch("roof_photo") as unknown;

    let file: File | null = null;
    if (rawPhoto instanceof FileList && rawPhoto.length > 0) {
        file = rawPhoto[0];
    } else if (Array.isArray(rawPhoto) && rawPhoto.length > 0) {
        file = rawPhoto[0];
    } else if (rawPhoto instanceof File) {
        file = rawPhoto;
    }

    const { ref, onChange, ...rest } = register("roof_photo");
    const handleRemove = () => {
        setValue("roof_photo", undefined, { shouldValidate: true });
    };

    return (
        <div className="space-y-6">
            <div className="space-y-1">
                <div className="flex justify-between items-end">
                    <h2 className="text-2xl font-bold text-foreground">Roof Photo</h2>
                    <span className="text-xs bg-muted text-muted-foreground px-2 py-1 rounded-full font-medium">
                        Optional
                    </span>
                </div>
                <p className="text-muted-foreground text-sm">
                    Upload a photo of your roof heading south to help assess shading and panel placement.
                </p>
            </div>

            <div className="space-y-4">
                {!file ? (
                    <label
                        htmlFor="roof-photo-upload"
                        className="flex flex-col items-center justify-center w-full h-48 border-2 border-dashed border-border rounded-xl cursor-pointer bg-muted/30 hover:bg-muted/50 transition-colors"
                    >
                        <div className="flex flex-col items-center justify-center pt-5 pb-6">
                            <div className="p-3 bg-primary/10 rounded-full mb-3">
                                <UploadCloud className="w-8 h-8 text-primary" />
                            </div>
                            <p className="mb-2 text-sm text-foreground">
                                <span className="font-semibold">Click to upload</span> or drag and drop
                            </p>
                            <p className="text-xs text-muted-foreground">PNG, JPG or JPEG</p>
                        </div>
                        <input
                            id="roof-photo-upload"
                            type="file"
                            accept="image/*"
                            className="hidden"
                            {...rest}
                            onChange={onChange}
                            ref={ref}
                        />
                    </label>
                ) : (
                    <div className="relative flex items-center p-4 border border-border rounded-xl bg-card shadow-sm">
                        <div className="p-3 bg-primary/10 rounded-lg mr-4 shrink-0">
                            <ImageIcon className="w-6 h-6 text-primary" />
                        </div>
                        <div className="flex-1 overflow-hidden">
                            <p className="text-sm font-medium text-foreground truncate">
                                {file.name}
                            </p>
                            <p className="text-xs text-muted-foreground">
                                {(file.size / 1024 / 1024).toFixed(2)} MB
                            </p>
                        </div>
                        <Button
                            type="button"
                            variant="ghost"
                            size="icon"
                            className="shrink-0 text-destructive hover:bg-destructive/10 hover:text-destructive ml-2"
                            onClick={handleRemove}
                        >
                            <X className="w-4 h-4" />
                        </Button>
                    </div>
                )}

                <div className="min-h-[30px] px-1 pt-1">
                    {errors.roof_photo && (
                        <p className="text-sm text-destructive">
                            {errors.roof_photo.message as string}
                        </p>
                    )}
                </div>
            </div>
        </div>
    );
}