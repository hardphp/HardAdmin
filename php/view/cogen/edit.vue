<template>
	<div class="system-menu-dialog-container">
		<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="900px">
			<el-form ref="dialogFormRef" :model="state.ruleForm" :rules="state.ruleRules" size="default" label-width="80px">
				 {%formInput%}
			</el-form>
			<template #footer>
				<span class="dialog-footer">
					<el-button @click="onCancel" size="default">取 消</el-button>
					<el-button type="primary" @click="onSubmit" size="default">{{ state.dialog.submitTxt }}</el-button>
				</span>
			</template>
		</el-dialog>
	</div>
</template>

<script setup lang="ts" name="{%tableName%}Form">
import { reactive, defineAsyncComponent,onMounted, ref ,unref,nextTick} from 'vue';
import { getinfo,save } from '/@/api/{%tableName%}/index';
import {  ElMessage } from 'element-plus';
{%selectDataApi%}

// 引入组件
const Editor = defineAsyncComponent(() => import('/@/components/editor/index.vue'));
const Uploadimg = defineAsyncComponent(() => import('/@/components/Upload/singleImage.vue'));
const Uploadvedio = defineAsyncComponent(() => import('/@/components/Upload/vedio.vue'));

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);


// 定义变量内容
const activeName = ref('first');
const dialogFormRef = ref();
const state = reactive({
	ruleForm: {%ruleForm%},
	{%selectData%}
	dialog: {
		isShowDialog: false,
		type: '',
		title: '',
		submitTxt: '',
	},
	// 表单校验
	ruleRules: {%ruleRules%},
	loading: false,
	msg:'最佳尺寸100*100',
});


const onUpload = (data) => {
	state.ruleForm.img = data;
};

const onUploadvedio = (data) => {
	state.ruleForm.video = data;
};

// 打开弹窗
const openDialog = (type: string, row?: any) => {
	if (type === 'edit') {
		// 实际请走接口
		getinfo(row.id).then((response: any) => {
			{%setRuleForm%}
		});
		
		state.dialog.title = '修改';
		state.dialog.submitTxt = '修 改';
	} else {
		state.dialog.title = '新增';
		state.dialog.submitTxt = '新 增';
		// 清空表单，此项需加表单验证才能使用
		nextTick(() => {
			dialogFormRef.value.resetFields();
			initForm();
		});
	}
	state.dialog.type = type;
	state.dialog.isShowDialog = true;
	// 查询
	{%selectDataPost%}
};
// 关闭弹窗
const closeDialog = () => {
	initForm();
	state.dialog.isShowDialog = false;
};

// 取消
const onCancel = () => {
	closeDialog();
};
// 提交
const onSubmit = () => {

	const formWrap = unref(dialogFormRef) as any;
	if (!formWrap) return;
	formWrap.validate((valid: boolean) => {
		if (valid) {
			state.loading = true;
			save(state.ruleForm)
				.then(() => {
					ElMessage.success('保存成功');
					state.loading = false;
					closeDialog(); // 关闭弹窗
					emit('refresh');
				})
				.finally(() => {
					state.loading = false;
				});
		}
	})
};
// 页面加载时
onMounted(() => {
	
});


// 表单初始化，方法：`resetFields()` 无法使用
const initForm = () => {
	{%initRuleForm%}
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>
