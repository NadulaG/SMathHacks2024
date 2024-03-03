<script>
// @ts-nocheck

  import CircleProgressBar from "./CircleProgressBar.svelte";
  import { createEventDispatcher } from 'svelte';
  
  export let healthPercent;
  export let waterContent;
  export let growsCrops;
  export let locationIndex;

  let waterContentColor;

  let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];

  switch (waterContent) {
    case "Low":
      waterContentColor = "#F94B4B";
      break;
    case "Med":
      waterContentColor = "#F4B71A";
      break;
    case "High":
      waterContentColor = "#24DD14";
      break;
    default:
      waterContentColor = "white";
      break;
  }

  // Create an event dispatcher
  const dispatch = createEventDispatcher();
  
  // Trigger the function from the nested component
  function handleClick(index) {
    console.log("Button clicked from nested component with value:", index);
    // Dispatch an event with the integer argument to call the function in the parent component
    dispatch('buttonClick', index);
  }

</script>

<div class="popup">
  <div class="text">
    <h2>Grass <span style="font-weight: 400; font-size: 0.8dvw; color: #848484;">({alphabet[locationIndex]})</span></h2>
    <p><b>Grows Crops:</b> {growsCrops}</p>
    <p>
      <b>Water Content:</b>
      <span style="color: {waterContentColor}">{waterContent}</span>
    </p>
    <button on:click={() => handleClick(locationIndex)}>View Nutrients</button>
  </div>
  <div class="percentage">
    <CircleProgressBar percent={healthPercent} />
    <div class="percent-text">
      <h3>{healthPercent * 100}%</h3>
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
    background-color: #2a2a2a;
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
