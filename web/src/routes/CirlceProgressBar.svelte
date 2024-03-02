<script>
	export let percent
	const angle = 360 * percent

	let color

	if(0 <= angle && angle < (1/3)*360){
		color = "#F94B4B";
	}
	else if ((1/3)*360 <= angle && angle < (2/3)*360){
		color = "#F4B71A";
	}
	else{
		color = "#24DD14";
	}
	
	// Adapt the logic according to the approach
	const background = `radial-gradient(#2A2A2A 62%, transparent 63%),
	conic-gradient(transparent 0deg ${angle}deg, #454545 ${angle}deg 360deg),
    ${color}`;
	
	$: cssVarStyles = `--background:${background}`
</script>

<style>
#progress-circle {
  background: var(--background);
  border-radius: 50%;
  width: 6dvw;
  height: 6dvw;
}
</style>

<div id="progress-circle" style="{cssVarStyles}"></div>