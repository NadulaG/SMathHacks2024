<script>
    // @ts-nocheck
        export let saturation;
    
        let w;
        let sliderOffset;
        
        $: {
            // Calculate sliderOffset whenever concentration, low, high, or w changes
            if (w !== undefined) {
                sliderOffset = clamp(percent * w, 0, w);
            }
        }
    
        function clamp(value, min, max) {
            return Math.min(Math.max(value, min), max);
        }

        let saturationText;
        let color;

        if (0 <= saturation && saturation < 0.15)
        {
            saturationText = "Far Below Ideal";
            color = "#E15441";
        }
        else if (0.15 <= saturation && saturation < 0.35)
        {
            saturationText = "Below Ideal";
            color="#F4B71A";
        }
        else if (0.35 <= saturation && saturation < 0.45)
        {
            saturationText = "Ideal";
            color = "#24DD14";
        }
        else if (0.45 <= saturation && saturation < 0.65)
        {
            saturationText = "Above Ideal";
            color="#F4B71A";
        }
        else
        {
            saturationText = "Far Above Ideal";
            color = "#E15441";
        }
    
    </script>
    
    <h4 style="color: {color};">{saturationText}</h4>
    <div class="bar" bind:clientWidth={w}>
        <div id="slider" class="slider" style="width: {saturation*100}%; background-color: {color};"></div>
    </div>
    <div class="bar-text">
        <p>0%</p>
        <div>
            <p style="margin-right: 6px;">40%</p>
            <p style="font-size: 14px;" >(Ideal)</p>
        </div>
        <p>100%</p>
    </div>
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        h4 {
            font-weight: 500;
            margin-bottom: 12px;
        }
    
        .bar {
            width: 100%;
            height: 26px;
            background-color: #2A2A2A;
            border-radius: 8px;
        }
    
        .bar-text {
            display: flex;
            justify-content: space-between;
            color: white;
        }
    
        .slider {
            height: 100%;
            border-radius: 8px;
        }
    
    
    </style>