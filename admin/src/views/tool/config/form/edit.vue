<template>
	<div class="system-menu-dialog-container">
		<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="769px">
			<el-form ref="dialogFormRef" :model="state.ruleForm" :rules="state.ruleRules" size="default" label-width="80px">
				<el-row :gutter="35">
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="名称" prop="title">
							<el-input v-model="state.ruleForm.title" placeholder="请输入名称" clearable></el-input>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="排序" prop="sorts">
							<el-input-number v-model="state.ruleForm.sorts" placeholder="请输入排序" controls-position="right"/>
						</el-form-item>
					</el-col>

					 
					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20" v-if="state.ruleForm.types == 1">
						<el-form-item label="取值" prop="value">
							<el-input v-model="state.ruleForm.value" type="textarea" placeholder="" clearable></el-input>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20" v-if="state.ruleForm.types == 2">
						<el-form-item label="图片" prop="value">
							<Uploadimg v-model="state.ruleForm.value" :value="state.ruleForm.value"  @upload="onUpload" :msg="state.msg"/>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20" v-if="state.ruleForm.types == 3">
						<el-form-item label="详情" prop="value">
							<Editor v-model:get-html="state.ruleForm.value"  />
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20" v-if="state.ruleForm.types == 4">
						<el-form-item label="视频" prop="value">
							<Uploadvedio v-model="state.ruleForm.value" :value="state.ruleForm.value"  @uploadvedio="onUploadvedio"/>
						</el-form-item>
					</el-col>

				</el-row>
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

<script setup lang="ts" name="toolAppForm">
import { reactive, defineAsyncComponent,onMounted, ref ,unref,nextTick} from 'vue';
import { getinfo,save } from '/@/api/config/index';
import {  ElMessage } from 'element-plus';

// 引入组件
const Editor = defineAsyncComponent(() => import('/@/components/editor/index.vue'));
const Uploadimg = defineAsyncComponent(() => import('/@/components/Upload/singleImage.vue'));
const Uploadvedio = defineAsyncComponent(() => import('/@/components/Upload/vedio.vue'));

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);


// 定义变量内容
const dialogFormRef = ref();
const state = reactive({
	ruleForm: {
		id:0,
		title: '', 
		sorts: 100, 
		value: '', 
		types:1,
	},
	 
	dialog: {
		isShowDialog: false,
		type: '',
		title: '',
		submitTxt: '',
	},
	// 表单校验
	ruleRules: {
		title: [{ required: true, message: '名称不能为空', trigger: 'blur' }],
	},
	loading: false,
	msg:'最佳尺寸',
});

const onUpload = (data) => {
	state.ruleForm.value = data;
};

const onUploadvedio = (data) => {
	state.ruleForm.value = data;
};

// 打开弹窗
const openDialog = (type: string, row?: any) => {
	if (type === 'edit') {
		// 实际请走接口
		getinfo(row.id).then((response: any) => {
			state.ruleForm.id = response.data.id;
			state.ruleForm.sorts = response.data.sorts;
			state.ruleForm.title = response.data.title;
			state.ruleForm.value = response.data.value;
			state.ruleForm.types = response.data.types;
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
	state.ruleForm.id = 0;
	state.ruleForm.title = '';
	state.ruleForm.sorts = 100;
	state.ruleForm.value = '';
	state.ruleForm.types = 1;
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>
