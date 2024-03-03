<script>
  import CircleProgressBar from "./CircleProgressBar.svelte";
  import { createEventDispatcher } from "svelte";

  /**
   * @type {number}
   */
  export let healthPercent;

  /**
   * @type {string}
   */
  export let waterContent;

  /**
   * @type {string}
   */
  export let growsCrops;

  /**
   * @type {number}
   */
  export let locationIndex;

  /**
   * @type {number}
   */
  export let positionX;

  /**
   * @type {number}
  */
  export let positionY;

  let offset = 0;

  if(positionX > 0.7) {
    offset = 180;
  }

  /**
   * @type {string}
   */
  let waterContentColor;

  let alphabet = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
  ];

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

  const dispatch = createEventDispatcher();

  /**
   * @param {number} index
   */
  function handleClick(index) {
    dispatch("buttonClick", index);
  }
</script>

<div class="popup" style="top: {positionY*100}%; left: calc({positionX*100}% - {offset}px)">
  <img src="/summary/triangle.png" class="triangle" style="top: -12px; left: calc(12px + {offset}px);" alt="triangle">
  <div class="text">
    <h2>
      Grass <span style="font-weight: 400; font-size: 0.8dvw; color: #848484;"
        >({alphabet[locationIndex]})</span
      >
    </h2>
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
    border-radius: 20px 20px 20px 20px;
    justify-content: space-between;
    align-items: center;
    padding: 10px 20px 20px 20px;
    gap: 2dvw;
    -webkit-box-shadow: 0px 0px 54px -1px rgba(0,0,0,0.7);
    -moz-box-shadow: 0px 0px 54px -1px rgba(0,0,0,0.7);
    box-shadow: 0px 0px 54px -1px rgba(0,0,0,0.7);
    z-index: 2;
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

  .triangle {
    position: absolute;
    height: 20px;
    z-index: 1;
  }

</style>
