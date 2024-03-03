<script>
  import Popup from "$lib/components/Popup.svelte";
  import NavBar from "$lib/components/NavBar.svelte";
</script>

<NavBar route="/regions" />

<div class="flex h-max overflow-hidden">
  <div class="bg-[#1B1B1B] w-80">
    <div class="flex flex-col h-full">
      <div class="text-white text-xl font-medium mt-4 ml-8">Regions
      </div>
      <div class="flex flex-col items-center space-y-12 mt-4">
        
        <!-- JUICE GOES HERE -->

      </div>
    </div>
  </div>

  <div class="flex justify-center flex-1">
    <Popup healthPercent="0.83" waterContent="High" growsCrops="Yes" />
    <img src="/regions/image.svg" alt="landscape" class="w-full h-fit" />
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
