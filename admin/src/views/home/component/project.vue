<template>
	<div class="home-container layout-pd">
		<el-row :gutter="15" class="home-card-one mb15">
			<el-col
				:xs="24"
				:sm="12"
				:md="12"
				:lg="6"
				:xl="6"
				v-for="(v, k) in state.homeOne"
				:key="k"
				:class="{ 'home-media home-media-lg': k > 1, 'home-media-sm': k === 1 }"
			>
				<div class="home-card-item flex">
					<div class="flex-margin flex w100" :class="` home-one-animation${k}`">
						<div class="flex-auto">
							<span class="font30" :style="{ color: '#f30a78' }">{{ v.num1 }}</span>
							<!-- <span class="ml5 font16" :style="{ color: '#24be58' }">/{{ v.num2 }}</span> -->
							<div class="mt10">{{ v.num3 }}</div>
						</div>
						<div class="home-card-item-icon flex" :style="{ background: `var(--next-color-success-lighter)` }">
							<i class="flex-margin font32 iconfont icon-zaosheng" :style="{ color: `var(--el-color-warning)` }"></i>
						</div>
					</div>
				</div>
			</el-col>
		</el-row>
		<el-row :gutter="15" class="home-card-three">
			<el-col :xs="24" :sm="10" :md="10" :lg="8" :xl="8">
				<div class="home-card-item">
					<div class="home-card-item-title">数据概览</div>
					<div class="home-monitor">
						<div class="flex-warp">
							<div class="flex-warp-item" v-for="(v, k) in state.homeThree" :key="k">
								<div class="flex-warp-item-box" :class="`home-animation${k}`">
									<div class="flex-margin">
										<i class="iconfont icon-zaosheng" :style="{ color: '#F72B3F' }"></i>
										<span class="pl5">{{ v.label }}</span>
										<div class="mt10">{{ v.value }}</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</el-col>
			<el-col :xs="24" :sm="14" :md="14" :lg="16" :xl="16" class="home-media">
				<div class="home-card-item">
					<div style="height: 100%" ref="homeLineRef"></div>
				</div>
			</el-col>
		</el-row>
	</div>
</template>

<script setup lang="ts" name="homeproject">
import { reactive, onMounted, ref, watch, nextTick, onActivated, markRaw } from 'vue';
import * as echarts from 'echarts';
import { storeToRefs } from 'pinia';
import { useThemeConfig } from '/@/stores/themeConfig';
import { useTagsViewRoutes } from '/@/stores/tagsViewRoutes';
import { getmydata } from '/@/api/project/index';


// 定义变量内容
const homeLineRef = ref();
const storesTagsViewRoutes = useTagsViewRoutes();
const storesThemeConfig = useThemeConfig();
const { themeConfig } = storeToRefs(storesThemeConfig);
const { isTagsViewCurrenFull } = storeToRefs(storesTagsViewRoutes);
const state = reactive({
	global: {
		homeChartOne: null,
		dispose: [null, '', undefined],
	} as any,
	homeOne: [
		{
			num1: '0',
			num2: '0',
			num3: '栏目数量',
		},
		{
			num1: '0',
			num2: '0',
			num3: '文章数量',
		},
		{
			num1: '0',
			num2: '0',
			num3: '用户数量',
		},
		{
			num1: '0',
			num2: '0',
			num3: '报名数量',
		},
	],
	homeThree: [
		{
			label: '活动数量',
			value: '0',
		},
		{
			label: '课程数量',
			value: '0',
		},
		{
			label: '链接数量',
			value: '0',
		},
		{
			label: '学习人数',
			value: '0',
		},
	],
	myCharts: [] as EmptyArrayType,
	daydata:[],//日期
	timedata:[],//每日数据
	charts: {
		theme: '',
		bgColor: '',
		color: '#303133',
	},
});
// 折线图
const initLineChart = () => {
	if (!state.global.dispose.some((b: any) => b === state.global.homeChartOne)) state.global.homeChartOne.dispose();
	state.global.homeChartOne = markRaw(echarts.init(homeLineRef.value, state.charts.theme));
	const option = {
		backgroundColor: state.charts.bgColor,
		title: {
			text: '会员新增',
			x: 'left',
			textStyle: { fontSize: '15', color: state.charts.color },
		},
		grid: { top: 70, right: 20, bottom: 30, left: 30 },
		tooltip: { trigger: 'axis' },
		legend: { data: ['会员数量'], right: 0 },
		xAxis: {
			data: state.daydata,
		},
		yAxis: [
			{
				type: 'value',
				name: '每日',
				splitLine: { show: true, lineStyle: { type: 'dashed', color: '#f5f5f5' } },
			},
		],
		series: [
			{
				name: '会员数量',
				type: 'line',
				symbolSize: 6,
				symbol: 'circle',
				smooth: true,
				data: state.timedata,
				lineStyle: { color: '#f30a78' },
				itemStyle: { color: '#f30a78', borderColor: '#f30a78' },
				areaStyle: {
					color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
						{ offset: 0, color: '#f30a78b3' },
						{ offset: 1, color: '#f30a7803' },
					]),
				},
			},
			
		],
	};
	state.global.homeChartOne.setOption(option);
	state.myCharts.push(state.global.homeChartOne);
};

//请求数据
const getData = () => {
	// 实际请走接口
	getmydata().then((response: any) => {
		state.homeOne = response.data.homeOne;
		state.homeThree = response.data.homeThree;
		state.daydata = response.data.daydata;
		state.timedata = response.data.timedata;
	});
};


// 批量设置 echarts resize
const initEchartsResizeFun = () => {
	nextTick(() => {
		for (let i = 0; i < state.myCharts.length; i++) {
			setTimeout(() => {
				state.myCharts[i].resize();
			}, i * 1000);
		}
	});
};
// 批量设置 echarts resize
const initEchartsResize = () => {
	window.addEventListener('resize', initEchartsResizeFun);
};
// 页面加载时
onMounted(() => {
	getData();
	initEchartsResize();
});
// 由于页面缓存原因，keep-alive
onActivated(() => {
	initEchartsResizeFun();
});
// 监听 pinia 中的 tagsview 开启全屏变化，重新 resize 图表，防止不出现/大小不变等
watch(
	() => isTagsViewCurrenFull.value,
	() => {
		initEchartsResizeFun();
	}
);
// 监听 pinia 中是否开启深色主题
watch(
	() => themeConfig.value.isIsDark,
	(isIsDark) => {
		nextTick(() => {
			state.charts.theme = isIsDark ? 'dark' : '';
			state.charts.bgColor = isIsDark ? 'transparent' : '';
			state.charts.color = isIsDark ? '#dadada' : '#303133';
			setTimeout(() => {
				initLineChart();
			}, 500);
		});
	},
	{
		deep: true,
		immediate: true,
	}
);
</script>

<style scoped lang="scss">
$homeNavLengh: 8;
.home-container {
	overflow: hidden;
	.home-card-one,
	.home-card-two,
	.home-card-three {
		.home-card-item {
			width: 100%;
			height: 130px;
			border-radius: 4px;
			transition: all ease 0.3s;
			padding: 20px;
			overflow: hidden;
			background: var(--el-color-white);
			color: var(--el-text-color-primary);
			border: 1px solid var(--next-border-color-light);
			&:hover {
				box-shadow: 0 2px 12px var(--next-color-dark-hover);
				transition: all ease 0.3s;
			}
			&-icon {
				width: 70px;
				height: 70px;
				border-radius: 100%;
				flex-shrink: 1;
				i {
					color: var(--el-text-color-placeholder);
				}
			}
			&-title {
				font-size: 15px;
				font-weight: bold;
				height: 30px;
			}
		}
	}
	.home-card-one {
		@for $i from 0 through 3 {
			.home-one-animation#{$i} {
				opacity: 0;
				animation-name: error-num;
				animation-duration: 0.5s;
				animation-fill-mode: forwards;
				animation-delay: calc($i/4) + s;
			}
		}
	}
	.home-card-two,
	.home-card-three {
		.home-card-item {
			height: 400px;
			width: 100%;
			overflow: hidden;
			.home-monitor {
				height: 100%;
				.flex-warp-item {
					width: 25%;
					height: 111px;
					display: flex;
					.flex-warp-item-box {
						margin: auto;
						text-align: center;
						color: var(--el-text-color-primary);
						display: flex;
						border-radius: 5px;
						background: var(--next-bg-color);
						cursor: pointer;
						transition: all 0.3s ease;
						&:hover {
							background: var(--el-color-primary-light-9);
							transition: all 0.3s ease;
						}
					}
					@for $i from 0 through $homeNavLengh {
						.home-animation#{$i} {
							opacity: 0;
							animation-name: error-num;
							animation-duration: 0.5s;
							animation-fill-mode: forwards;
							animation-delay: calc($i/10) + s;
						}
					}
				}
			}
		}
	}
}
</style>
