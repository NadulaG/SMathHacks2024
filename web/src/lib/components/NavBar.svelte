<script>
  /**
   * @type {string}
   */
  export let route;
</script>

<div class="bg-[#1B1B1B] py-2">
  <div class="container ml-8 mx-auto">
    <div class="flex justify-between">
      <div class="text-white text-2xl font-bold">Flight History</div>
      <div class="flex flex-row space-x-4">
        <a href="/" class="text-gray-300 font-semibold {route == "/" ? "underline" : ""}">Home</a>
        <a href="/regions" class="text-gray-300 font-semibold {route == "/regions" ? "underline" : ""}">Regions</a>
      </div>
      <div class="flex items-center space-x-4">
        <span class="text-gray-300 font-semibold">3/2/2024</span>
      </div>
    </div>
  </div>
</div>
