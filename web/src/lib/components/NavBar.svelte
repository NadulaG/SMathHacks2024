<script>
  /**
   * @type {string}
   */
  export let route;

  /**
   * @type {string}
   */
  export let image;
</script>

<div class="bg-[#1B1B1B] py-2">
  <div class="container ml-8 mx-auto">
    <div class="flex justify-between">
      <div class="text-white text-2xl font-bold">Flight History</div>
      <div class="flex flex-row space-x-10">
        <a
          href="/"
          class="font-semibold {route == '/'
            ? 'underline text-white'
            : 'text-gray-300'}">Home</a
        >
        <a
          href="/regions"
          class="font-semibold {route == '/regions'
            ? 'underline text-white'
            : 'text-gray-300'}">Regions</a
        >
      </div>
      <div class="flex items-center space-x-4">
        <!-- <span class="text-gray-300 font-semibold">3/2/2024</span> -->

        <select id="image" name="image" class="rounded-md bg-gray-300 p-1 istok" bind:value={image}>
          <option value="3/1/2024">3/1/2024</option>
          <option value="3/2/2024">3/2/2024</option>
          <option value="3/3/2024" selected>3/3/2024</option>
        </select>
      </div>
    </div>
  </div>
</div>
