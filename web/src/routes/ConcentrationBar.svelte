<script>
// @ts-nocheck

    export let concentration;
    export let low;
    export let high;
    let percent = (concentration - low) / (high - low);

    export let show;

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

</script>

<div class="concentration-container" style="display: {show ? "block" : "none"};">
    <h4>Concentration (ppm): {concentration}</h4>
    <div class="bar" bind:clientWidth={w}>
        <div id="slider" class="slider" style="left: {sliderOffset}px;"></div>
    </div>
    <div class="bar-text">
        <p>Low</p>
        <p>High</p>
    </div>
</div>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    .concentration-container {
        color: white;
        background-color: #2A2A2A;
        padding: 12px 16px;
        border-radius: 6px;
        /* margin-left: 26px; */
    }

    .bar {
        width: 100%;
        height: 26px;
        background: linear-gradient(90deg, rgba(225,84,65,1) 0%, rgba(225,84,65,1) 20%, rgba(244,183,26,1) 20.01%, rgba(244,183,26,1) 40%, rgba(36,221,20,1) 40.001%, rgba(36,221,20,1) 60%, rgba(244,183,26,1) 60.001%, rgba(244,183,26,1) 80%, rgba(225,84,65,1) 80.001%);;
    }

    .bar-text {
        display: flex;
        justify-content: space-between;
    }

    .slider {
        width: 3px;
        height: 140%;
        position: relative;
        top: -40%;
        background-color: white;
    }

    h4 {
        margin-bottom: 20px;
    }


</style>