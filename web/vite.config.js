import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [sveltekit()],
	server: {
		fs: {
			// Set the root directory to the directory containing the file you want to serve
			allow: ['/']
		},
	},
});

