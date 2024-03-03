<script>
  import Popup from "$lib/components/Popup.svelte";
  import NavBar from "$lib/components/NavBar.svelte";

  /**
   * @type {string}
   */
  let image = "3/3/2024";
</script>

<svelte:head>
  <title>Home</title>
</svelte:head>

<NavBar route="/" bind:image />

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

        <div class="text-center">
          <h2 class="text-white text-xl istok font-bold">
            Essential Nutrients
          </h2>
          <div class="flex flex-col space-y-2 mt-2">
            <div class="flex flex-row">
              <img src="/summary/nutrients/potassium.svg" alt="potassium" />
              <p class="ml-2 text-[#D239CC] istok font-semibold">Potassium</p>
            </div>

            <div class="flex flex-row">
              <img src="/summary/nutrients/nitrogen.svg" alt="nitrogen" />
              <p class="ml-2 text-[#E07B04] istok font-semibold">Nitrogen</p>
            </div>

            <div class="flex flex-row">
              <img src="/summary/nutrients/phosphorus.svg" alt="phosphorus" />
              <p class="ml-2 text-[#5427B5] istok font-semibold">Phosphorus</p>
            </div>

            <div class="flex flex-row">
              <img src="/summary/nutrients/calcium.svg" alt="calcium" />
              <p class="ml-2 text-[#FF1D1D] istok font-semibold">Calcium</p>
            </div>

            <div class="flex flex-row">
              <img src="/summary/nutrients/magnesium.svg" alt="magnesium" />
              <p class="ml-2 text-[#24B682] istok font-semibold">Magnesium</p>
            </div>

            <div class="flex flex-row">
              <img src="/summary/nutrients/sulfur.svg" alt="sulfur" />
              <p class="ml-2 text-[#F9DD4B] istok font-semibold">Sulfur</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="flex justify-center flex-1">
    <!-- <Popup healthPercent="0.83" waterContent="High" growsCrops="Yes" /> -->
    <img src="/summary/{image.replaceAll('/', '-')}.svg" alt="landscape" class="w-full h-fit" />
  </div>
</div>

<style lang="postcss">
  :global(html) {
    background-color: #1b1b1b;
  }
</style>
