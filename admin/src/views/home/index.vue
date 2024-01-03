<template>
	<div class="home-container layout-pd">
		<div> <Project/> </div>
	</div>
</template>

<script setup lang="ts" name="home">
import { reactive, onMounted ,defineAsyncComponent} from 'vue';

const Project = defineAsyncComponent(() => import('/@/views/home/component/project.vue'));

// 页面加载时
onMounted(() => {
	
});
</script>

<style scoped lang="scss">
.home-container {
	overflow: hidden;

}
</style>
