<script>
  import Popup from "$lib/components/Popup.svelte";
  import NavBar from "$lib/components/NavBar.svelte";

  /**
   * @type {string}
   */
  let image = "3/3/2024";
</script>

<svelte:head>
  <title>Regions</title>
</svelte:head>

<NavBar route="/regions" bind:image={image} />

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
    <img src="/regions/{image.replaceAll('/', '-')}.svg" alt="landscape" class="w-full h-fit" />
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
