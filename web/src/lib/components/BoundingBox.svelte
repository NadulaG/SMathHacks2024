<script>
// @ts-nocheck

    export let quality;
    export let width;
    export let height;
    export let positionX;
    export let positionY;

	let color

	if(0 <= quality && quality < (1/3)){
		color = "#F94B4B";
	}
	else if ((1/3) <= quality && quality < (2/3)){
		color = "#F4B71A";
	}
	else{
		color = "#24DD14";
	}

</script>

<div class="box" style="width: {width}px; height: {height}px; left: {positionX*100}%; top: {positionY*100}%; transform: translate(-50%, -50%); border-color: {color}; background-color: {color}20"></div>

<style>
    .box {
        border-radius: 12px;
        border-width: 4px;
        border-style: solid;
        position: absolute;
    }
</style>