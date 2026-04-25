import React from 'react'
import { Minus, Plus } from 'lucide-react';
import { Button } from './button';

export const Stepper = ({ currentCount, minusDisabled = false, plusDisabled = false, handleReduce, handleIncrease }: { currentCount: number, minusDisabled?: boolean, plusDisabled?: boolean, handleReduce: () => void, handleIncrease: () => void }) => {
    return (
        <div className="flex items-center border border-border rounded-lg bg-background shadow-sm h-8 overflow-hidden">
            <Button
                type="button"
                variant="ghost"
                className="flex items-center justify-center h-full w-8 text-muted-foreground hover:bg-muted hover:text-foreground disabled:opacity-50 transition-colors"
                onClick={handleReduce}
                disabled={minusDisabled}
            >
                <Minus className="h-3 w-3" />
            </Button>
            <div className="w-8 text-center text-xs font-semibold text-foreground">
                {currentCount}
            </div>
            <Button
                type="button"
                variant="ghost"
                className="flex items-center justify-center h-full w-8 text-muted-foreground hover:bg-muted hover:text-foreground transition-colors"
                onClick={handleIncrease}
                disabled={plusDisabled}
            >
                <Plus className="h-3 w-3" />
            </Button>
        </div>
    )
}
