<script>
  // @ts-nocheck
  import Popup from "$lib/components/Popup.svelte";
  import NavBar from "$lib/components/NavBar.svelte";
  import ConcentrationBar from "$lib/components/ConcentrationBar.svelte";
  import CircleProgressBar from "$lib/components/CircleProgressBar.svelte";
  import BoundingBox from "$lib/components/BoundingBox.svelte";
  import SaturationBar from "$lib/components/SaturationBar.svelte";

  import nutrientData from "../nutrients.json";
  import mapLocations from "../locations.json";

  /**
   * @type {string}
   */
  let image = "3/3/2024";

  let expandNutrients = [false, false, false, false, false, false];

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

  let currentLocation = -1;
  let currentMap = 0;

  function handleMapUpdate() {
    console.log("Updating Map");
    switch(image) {
      case "3/3/2024":
        currentMap = 0;
        break;
      case "3/2/2024":
        currentMap = 1;
        break;
      case "3/1/2024":
        currentMap = 2;
        break;
    }
    currentLocation = -1;
  }

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

  function onExpand(index) {
    for (let i = 0; i < expandNutrients.length; i++) {
      if (i != index && expandNutrients[i] == true) {
        expandNutrients[i] = false;
      }
    }

    expandNutrient(index);
  }

</script>

<svelte:head>
  <title>Home</title>
</svelte:head>

<NavBar on:listSelect={handleMapUpdate} route="/" bind:image/>

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
              class="flex justify-center items-center w-full h-full bg-no-repeat"
            >
            <CircleProgressBar percent={mapLocations[currentMap].averageHealth} />
              <div class="text-white font-semibold font-serif text-center" style="position: absolute;">
                <p class="text-xl istok" style="font-weight: 700;">{Math.round(mapLocations[currentMap].averageHealth*100)}%</p>
                <p class="text-xs istok">Healthy</p>
              </div>
            </div>
          </div>
        </div>

        <div class="text-center">
          <h2 class="text-white text-xl istok font-bold">
            Estimated Saturation
            <br><span style="font-weight: 500;">{Math.round(mapLocations[currentMap].averageSaturation*100)}%</span>
          </h2>
          <SaturationBar saturation={mapLocations[currentMap].averageSaturation} />
        </div>

        <div
          class="text-center"
          style="display: {currentLocation == -1 ? 'none' : 'block'};"
        >
          <h2 class="text-white text-xl istok font-bold">
            <button on:click={() => (currentLocation = -1)}
              ><img
                src="/x.svg"
                style="position: relative; top: 5px;"
              /></button
            >
            Essential Nutrients
            <span style="font-size: 14px; font-weight: 400; color: gray;"
              >({alphabet[currentLocation]})</span
            >
          </h2>

          <div class="flex flex-col space-y-2 mt-2">
            <div class="flex flex-row">
              <img src="/summary/nutrients/potassium.svg" alt="potassium" />
              <button
                on:click={() => {
                  onExpand(0);
                }}
                class="ml-2 text-[#D239CC] istok font-semibold"
                >Potassium <span style="font-weight: 400;"
                  >({mapLocations[currentMap].locations[Math.max(0, currentLocation)].nutrients.potassium}ppm)</span
                ><span style="color: white;"
                  >{expandNutrients[0] ? " -" : " +"}</span
                ></button
              >
            </div>
            <ConcentrationBar
              low={nutrientData.potassium.low}
              high={nutrientData.potassium.high}
              concentration={mapLocations[currentMap].locations[Math.max(0, currentLocation)].nutrients
                .potassium}
              show={expandNutrients[0]}
            />

            <div class="flex flex-row">
              <img src="/summary/nutrients/nitrogen.svg" alt="nitrogen" />
              <button
                on:click={() => {
                  onExpand(1);
                }}
                class="ml-2 text-[#E07B04] istok font-semibold"
                >Nitrogen <span style="font-weight: 400;"
                  >({mapLocations[currentMap].locations[Math.max(0, currentLocation)].nutrients
                    .nitrogen}ppm)</span
                ><span style="color: white;"
                  >{expandNutrients[1] ? " -" : " +"}</span
                ></button
              >
            </div>
            <ConcentrationBar
              low={nutrientData.nitrogen.low}
              high={nutrientData.nitrogen.high}
              concentration={mapLocations[currentMap].locations[Math.max(0, currentLocation)].nutrients
                .nitrogen}
              show={expandNutrients[1]}
            />

            <div class="flex flex-row">
              <img src="/summary/nutrients/phosphorus.svg" alt="phosphorus" />
              <button
                on:click={() => {
                  onExpand(2);
                }}
                class="ml-2 text-[#5427B5] istok font-semibold"
                >Phosphorus <span style="font-weight: 400;"
                  >({mapLocations[currentMap].locations[Math.max(0, currentLocation)].nutrients
                    .phosphorus}ppm)</span
                ><span style="color: white;"
                  >{expandNutrients[2] ? " -" : " +"}</span
                ></button
              >
            </div>
            <ConcentrationBar
              low={nutrientData.phosphorus.low}
              high={nutrientData.phosphorus.high}
              concentration={mapLocations[currentMap].locations[Math.max(0, currentLocation)].nutrients
                .phosphorus}
              show={expandNutrients[2]}
            />

            <div class="flex flex-row">
              <img src="/summary/nutrients/calcium.svg" alt="calcium" />
              <button
                on:click={() => {
                  onExpand(3);
                }}
                class="ml-2 text-[#FF1D1D] istok font-semibold"
                >Calcium <span style="font-weight: 400;"
                  >({mapLocations[currentMap].locations[Math.max(0, currentLocation)].nutrients
                    .calcium}ppm)</span
                ><span style="color: white;"
                  >{expandNutrients[3] ? " -" : " +"}</span
                ></button
              >
            </div>
            <ConcentrationBar
              low={nutrientData.calcium.low}
              high={nutrientData.calcium.high}
              concentration={mapLocations[currentMap].locations[Math.max(0, currentLocation)].nutrients
                .calcium}
              show={expandNutrients[3]}
            />

            <div class="flex flex-row">
              <img src="/summary/nutrients/magnesium.svg" alt="magnesium" />
              <button
                on:click={() => {
                  onExpand(4);
                }}
                class="ml-2 text-[#24B682] istok font-semibold"
                >Magnesium <span style="font-weight: 400;"
                  >({mapLocations[currentMap].locations[Math.max(0, currentLocation)].nutrients
                    .magnesium}ppm)</span
                ><span style="color: white;"
                  >{expandNutrients[4] ? " -" : " +"}</span
                ></button
              >
            </div>
            <ConcentrationBar
              low={nutrientData.magnesium.low}
              high={nutrientData.magnesium.high}
              concentration={mapLocations[currentMap].locations[Math.max(0, currentLocation)].nutrients
                .magnesium}
              show={expandNutrients[4]}
            />

            <div class="flex flex-row">
              <img src="/summary/nutrients/sulfur.svg" alt="sulfur" />
              <button
                on:click={() => {
                  onExpand(5);
                }}
                class="ml-2 text-[#F9DD4B] istok font-semibold"
                >Sulfur <span style="font-weight: 400;"
                  >({mapLocations[currentMap].locations[Math.max(0, currentLocation)].nutrients
                    .sulfur}ppm)</span
                ><span style="color: white;"
                  >{expandNutrients[5] ? " -" : " +"}</span
                ></button
              >
            </div>
            <ConcentrationBar
              low={nutrientData.sulfur.low}
              high={nutrientData.sulfur.high}
              concentration={mapLocations[currentMap].locations[Math.max(0, currentLocation)].nutrients
                .sulfur}
              show={expandNutrients[5]}
            />
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="flex justify-center flex-1" style="position: relative;">
    {#each mapLocations[currentMap].locations as location, index}
      <Popup
        locationIndex={index}
        healthPercent={location.health}
        waterContent={location.waterContent}
        growsCrops={location.growsCrops}
        positionX={location.positionX}
        positionY={location.positionY}
        on:buttonClick={handleLocationSelect}
      />
      <BoundingBox
        quality={location.health}
        width={location.width}
        height={location.height}
        positionX={location.positionX}
        positionY={location.positionY}
      />
    {/each}
    <img
      src="/summary/{image.replaceAll('/', '-')}.svg"
      alt="landscape"
      class="w-full h-fit"
    />
  </div>
</div>

<style lang="postcss">
  :global(html) {
    background-color: #1b1b1b;
  }

</style>
