<template>
	<div class="system-menu-dialog-container">
		<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="60%">
			
				<el-tabs v-model="activeName" class="admin-tabs">
					<el-tab-pane label="Model" name="first">
						
						<Codemirror
						class="code"
						v-model="state.model"
						:style="{ height: '100%' }"
						:autofocus="true"
						:disabled="false"
						:extensions="extensions"
						/>

					</el-tab-pane>
					<el-tab-pane label="Service" name="second">	
						 
						<Codemirror
						class="code"
						v-model="state.service"
						:style="{ height: '100%' }"
						:autofocus="true"
						:disabled="false"
						:extensions="extensions"
						/>
						
					</el-tab-pane>

					<el-tab-pane label="Controller" name="three">	
						 
						<Codemirror
						class="code"
						v-model="state.controller"
						:style="{ height: '100%' }"
						:autofocus="true"
						:disabled="false"
						:extensions="extensions"
						/>
						 
						
					</el-tab-pane>

					<el-tab-pane label="Controllerapi" name="three2">	
						 
						 <Codemirror
						 class="code"
						 v-model="state.controllerapi"
						 :style="{ height: '100%' }"
						 :autofocus="true"
						 :disabled="false"
						 :extensions="extensions"
						 />
						  
						 
					 </el-tab-pane>

					<el-tab-pane label="Validate" name="four">	
						 
						<Codemirror
						class="code"
						v-model="state.validate"
						:style="{ height: '100%' }"
						:autofocus="true"
						:disabled="false"
						:extensions="extensions"
						/>
						
					</el-tab-pane>

					<el-tab-pane label="index.vue" name="five">	
						 
						<Codemirror
						class="code"
						v-model="state.index"
						:style="{ height: '100%' }"
						:autofocus="true"
						:disabled="false"
						:extensions="extensions"
						/>
						
					</el-tab-pane>

					<el-tab-pane label="edit.vue" name="six">	
						 
						<Codemirror
						class="code"
						v-model="state.edit"
						:style="{ height: '100%' }"
						:autofocus="true"
						:disabled="false"
						:extensions="extensions"
						/>
						
					</el-tab-pane>

					<el-tab-pane label="index.ts" name="seven">	
						 
						<Codemirror
						class="code"
						v-model="state.api"
						:style="{ height: '100%' }"
						:autofocus="true"
						:disabled="false"
						:extensions="extensions"
						/>
					</el-tab-pane>

					<el-tab-pane label="接口文档" name="seven2">	
						 
						 <Codemirror
						 class="code"
						 v-model="state.apitxt"
						 :style="{ height: '100%' }"
						 :autofocus="true"
						 :disabled="false"
						 :extensions="extensions"
						 />
					 </el-tab-pane>
		
				</el-tabs>


			
			<template #footer>
				<span class="dialog-footer">
					<el-button @click="onCancel" size="default">取 消</el-button>
					<el-button type="warning" @click="onDown" size="default">下载代码</el-button>
					<el-button type="primary" @click="onSubmit" size="default">{{ state.dialog.submitTxt }}</el-button>
				</span>
			</template>
		</el-dialog>
	</div>
</template>

<script setup lang="ts" name="toolAppForm">
import { reactive, onMounted, ref,watch ,unref,nextTick} from 'vue';
import { getcode,tocode,getcodezip } from '/@/api/cogen/index';
import {  ElMessage } from 'element-plus';
 
import { Codemirror } from "vue-codemirror";
import { javascript } from "@codemirror/lang-javascript";
import { oneDark } from "@codemirror/theme-one-dark";

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);

const extensions = [javascript(), oneDark];

// 定义变量内容
const activeName = ref('first');
const dialogFormRef = ref();
const state = reactive({
	row: [],
	model:'',
	service:'',
	controller:'',
	controllerapi:'',
	validate:'',
	index:'',
	edit:'',
	api:'',
	apitxt:'',
	dialog: {
		isShowDialog: false,
		type: '',
		table: '',
		submitTxt: '',
	},
	loading: false,
});

// 打开弹窗
const openDialog = ( row: any) => {
	state.row =row;
	// 实际请走接口
	getcode(row.table).then((response: any) => {
			state.model = response.data.modelfilepath;
			state.service = response.data.servicefilepath;
			state.controller = response.data.controllerfilepath;
			state.controllerapi = response.data.controllerapifilepath;
			state.validate= response.data.validatefilepath;
			state.index= response.data.templateindexpath;
			state.edit= response.data.templateeditpath;
			state.api= response.data.templateapipath;
			state.apitxt = response.data.templateapitxtpath;
		});
		
	state.dialog.title = '代码预览';
	state.dialog.submitTxt = '生成代码';
	state.dialog.isShowDialog = true;
};
// 关闭弹窗
const closeDialog = () => {
	state.dialog.isShowDialog = false;
};

// 取消
const onCancel = () => {
	closeDialog();
};
// 提交
const onSubmit = () => {
	state.loading = true;
	tocode(state.row.id).then((response: any) => {
		ElMessage.success('成功');
		state.loading = false;
		closeDialog(); // 关闭弹窗
	}).finally(() => {
		state.loading = false;
	});
	
};
const onDown = () => {
	state.loading = true;
	getcodezip(state.row.table).then((response: any) => {
		ElMessage.success('成功');
		state.loading = false;
		window.open(response.data, "_blank");
	}).finally(() => {
		state.loading = false;
	});
	
};

 
// 页面加载时
onMounted(() => {
	
});
 

// 暴露变量
defineExpose({
	openDialog,
});
</script>
