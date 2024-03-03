<script>
// @ts-nocheck
  import Popup from "$lib/components/Popup.svelte";
  import NavBar from "$lib/components/NavBar.svelte";
  import ConcentrationBar from "./ConcentrationBar.svelte";

  import nutrientData from '../../../web/static/summary/nutrients/nutrients.json';

  let expandNutrients = [false, false, false, false, false, false];

  let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
  
  let currentLocation = -1;

  //RANDOM VALUES
  let nutrientObjects = [
    //LOCATION ONE
    {
      potassium: 86,
      nitrogen: 54,
      phosphorus: 42,
      calcium: 500,
      magnesium: 48,
      sulfur: 10
    },
    //LOCATION TWO
    {
      potassium: 86,
      nitrogen: 54,
      phosphorus: 42,
      calcium: 500,
      magnesium: 48,
      sulfur: 10
    }
  ]

  function expandNutrient(index) {
    expandNutrients[index] = !expandNutrients[index];
    console.log(expandNutrients[index]);
  }

  function handleLocationSelect(index) {
    currentLocation = index.detail;
  }

  function clamp(value, min, max) {
    return Math.min(Math.max(value, min), max);
  }

</script>

<NavBar route="/" />

<div class="flex h-max overflow-hidden">
  <div class="bg-[#1B1B1B] w-80">
    <div class="flex flex-col h-full">
      <div class="text-white text-xl font-medium mt-4 ml-8">Summary</div>
      <div class="flex flex-col items-center space-y-12 mt-4">
        <div
          class="w-60 h-28 shrink-0 [background:#2B2B2B] rounded-[0px_8.824px]"
        >
          <div class="flex flex-col items-center justify-center h-full">
            <div
              class="flex justify-center items-center w-full h-full bg-no-repeat bg-center bg-[url('/summary/health.svg')]"
            >
              <div class="text-white font-semibold font-serif text-center">
                <p class="text-xl istok">72%</p>
                <p class="text-xs istok">Healthy</p>
              </div>
            </div>
          </div>
        </div>

        <div class="text-center">
          <h2 class="text-white text-xl istok font-bold">
            Estimated Saturation
          </h2>
          <span class="text-[#E15441] text-base istok font-bold"
            >Far Below Ideal</span
          >
          <img src="/summary/saturation.svg" alt="saturation" />
        </div>

        <div class="text-center" style="display: {currentLocation == -1 ? "none" : "block"};">
          <h2 class="text-white text-xl istok font-bold">
            <button on:click={() => currentLocation = -1}><img src="../../static/x.svg" style="position: relative; top: 5px;"></button>
            Essential Nutrients <span style="font-size: 14px; font-weight: 400; color: gray;">({alphabet[currentLocation]})</span>
          </h2>
          
          <div class="flex flex-col space-y-2 mt-2">
            <div class="flex flex-row">
                <img src="/summary/nutrients/potassium.svg" alt="potassium" />
                <button on:click={() => expandNutrient(0)} class="ml-2 text-[#D239CC] istok font-semibold">Potassium <span style="font-weight: 400;">({nutrientObjects[Math.max(0, currentLocation)].potassium}ppm)</span><span style="color: white;">{expandNutrients[0] ? "-" : "+"}</span></button>
            </div>
            <ConcentrationBar low={nutrientData.potassium.low} high={nutrientData.potassium.high} concentration={nutrientObjects[Math.max(0, currentLocation)].potassium} show={expandNutrients[0]}/>
            
            <div class="flex flex-row">
                <img src="/summary/nutrients/nitrogen.svg" alt="nitrogen" />
                <button on:click={() => expandNutrient(1)} class="ml-2 text-[#E07B04] istok font-semibold">Nitrogen <span style="font-weight: 400;">({nutrientObjects[Math.max(0, currentLocation)].nitrogen}ppm)</span><span style="color: white;">{expandNutrients[1] ? "-" : "+"}</span></button>
            </div>
            <ConcentrationBar low={nutrientData.nitrogen.low} high={nutrientData.nitrogen.high} concentration={nutrientObjects[Math.max(0, currentLocation)].nitrogen} show={expandNutrients[1]}/>
            
            <div class="flex flex-row">
                <img src="/summary/nutrients/phosphorus.svg" alt="phosphorus" />
                <button on:click={() => expandNutrient(2)} class="ml-2 text-[#5427B5] istok font-semibold">Phosphorus <span style="font-weight: 400;">({nutrientObjects[Math.max(0, currentLocation)].phosphorus}ppm)</span><span style="color: white;">{expandNutrients[2] ? "-" : "+"}</span></button>
            </div>
            <ConcentrationBar low={nutrientData.phosphorus.low} high={nutrientData.phosphorus.high} concentration={nutrientObjects[Math.max(0, currentLocation)].phosphorus} show={expandNutrients[2]}/>
            
            <div class="flex flex-row">
                <img src="/summary/nutrients/calcium.svg" alt="calcium" />
                <button on:click={() => expandNutrient(3)} class="ml-2 text-[#FF1D1D] istok font-semibold">Calcium <span style="font-weight: 400;">({nutrientObjects[Math.max(0, currentLocation)].calcium}ppm)</span><span style="color: white;">{expandNutrients[3] ? "-" : "+"}</span></button>
            </div>
            <ConcentrationBar low={nutrientData.calcium.low} high={nutrientData.calcium.high} concentration={nutrientObjects[Math.max(0, currentLocation)].calcium} show={expandNutrients[3]}/>
            
            <div class="flex flex-row">
                <img src="/summary/nutrients/magnesium.svg" alt="magnesium" />
                <button on:click={() => expandNutrient(4)} class="ml-2 text-[#24B682] istok font-semibold">Magnesium <span style="font-weight: 400;">({nutrientObjects[Math.max(0, currentLocation)].magnesium}ppm)</span><span style="color: white;">{expandNutrients[4] ? "-" : "+"}</span></button>
            </div>
            <ConcentrationBar low={nutrientData.magnesium.low} high={nutrientData.magnesium.high} concentration={nutrientObjects[Math.max(0, currentLocation)].magnesium} show={expandNutrients[4]}/>
            
            <div class="flex flex-row">
                <img src="/summary/nutrients/sulfur.svg" alt="sulfur" />
                <button on:click={() => expandNutrient(5)} class="ml-2 text-[#F9DD4B] istok font-semibold">Sulfur <span style="font-weight: 400;">({nutrientObjects[Math.max(0, currentLocation)].sulfur}ppm)</span><span style="color: white;">{expandNutrients[5] ? "-" : "+"}</span></button>
            </div>
            <ConcentrationBar low={nutrientData.sulfur.low} high={nutrientData.sulfur.high} concentration={nutrientObjects[Math.max(0, currentLocation)].sulfur} show={expandNutrients[5]}/>
            
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="flex justify-center flex-1">
    <Popup healthPercent="0.83" waterContent="High" growsCrops="Yes" locationIndex=0 on:buttonClick={handleLocationSelect}/>
    <img src="/summary/image.svg" alt="landscape" class="w-full h-fit" />
  </div>
</div>

<style lang="postcss">
  :global(html) {
    background-color: #1b1b1b;
  }

  .istok {
    font-family: "Istok Web", sans-serif;
  }
</style>
