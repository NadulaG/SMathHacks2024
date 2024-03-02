<script>
    import CirlceProgressBar from "./CirlceProgressBar.svelte";
    export let healthPercent;
    export let waterContent;
    export let growsCrops;

    let waterContentColor;

    switch(waterContent){
        case "Low":
            waterContentColor = "#F94B4B";
            break;
        case "Med":
            waterContentColor = "#F4B71A"
            break;
        case "High":
            waterContentColor = "#24DD14"
            break;
        default:
            waterContentColor = "white"; 
            break;
    }

    // $: cssVarStyles = `--color:${waterContentColor}`
</script>


<div class="popup">
    <div class="text">
        <h2>Grass</h2>
        <p><b>Grows Crops:</b> {growsCrops}</p>
        <p><b>Water Content:</b> <span style="color: {waterContentColor}">{waterContent}</span></p>
        <button>View Nutrients</button>
    </div>
    <div class="percentage">
        <CirlceProgressBar percent={healthPercent} />
        <div class="percent-text">
            <h3>{healthPercent*100}%</h3>
            <h4>Healthy</h4>
        </div>
    </div>
</div>

<style>
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    .popup {
        position: absolute;
        background-color: #2A2A2A;
        color: white;
        display: flex;
        border-radius: 20px;
        justify-content: space-between;
        align-items: center;
        padding: 10px 20px 20px 20px;
        gap: 2dvw;
    }

    h2 {
        font-size: 1.4vw;
        font-weight: 700;
        margin-bottom: 0.2dvw;
    }

    p {
        font-size: 0.9dvw;
    }

    .percentage {
        display: flex;
        align-items: center;
        justify-content: center;
        text-align: center;
    }

    .percentage .percent-text {
        position: absolute;
    }

    .percent-text h3 {
        font-size: 1.4dvw;
        font-weight: 700;
    }

    .percent-text h4 {
        margin-top: -4px;
        font-size: 0.8dvw;
    }

    .text button {
        background-color: #454545;
        color: white;
        padding: 4px 8px;
        margin-top: 0.8dvw;
        border-radius: 6px;
        font-size: 0.9dvw;
    }

</style>