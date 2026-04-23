import { Step1Consumers } from "./steps/step-1-consumers";
import { Step2Concurrent } from "./steps/step-2-concurrent";
import { Step3RoofArea } from "./steps/step-3-roof";
import { Step4Location } from "./steps/step-4-location";
import { Step5MeterType } from "./steps/step-5-meterType";
import { Step6RoofPhoto } from "./steps/step-6-photo";
import { Step7Roof } from "./steps/step-7-floor";
import { Step8Expectations } from "./steps/step-8-expectations";

export function StepRenderer({ step }: { step: number }) {
    switch (step) {
        case 1: return <Step1Consumers />;
        case 2: return <Step2Concurrent />;
        case 3: return <Step3RoofArea />;
        case 4: return <Step4Location />;
        case 5: return <Step5MeterType />
        case 6: return <Step6RoofPhoto />
        case 7: return <Step7Roof />
        case 8: return <Step8Expectations />
        default: return <div>Step under construction</div>;
    }
}