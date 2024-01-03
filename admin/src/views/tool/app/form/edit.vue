<template>
	<div class="system-menu-dialog-container">
		<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="769px">
			<el-form ref="dialogFormRef" :model="state.ruleForm" :rules="state.ruleRules" size="default" label-width="80px">
				<el-row :gutter="35">
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="名称" prop="title">
							<el-input v-model="state.ruleForm.title" placeholder="请输入账号" clearable></el-input>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="appid" prop="title">
							<el-input v-model="state.ruleForm.appid" placeholder="请输入appid" clearable></el-input>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="状态" prop="is_enabled">
							<el-radio-group v-model="state.ruleForm.is_enabled">
								<el-radio :label="1">正常</el-radio>
								<el-radio :label="0">禁用</el-radio>
							</el-radio-group>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="验签" prop="is_sign">
							<el-radio-group v-model="state.ruleForm.is_sign">
								<el-radio :label="1">是</el-radio>
								<el-radio :label="0">否</el-radio>
							</el-radio-group>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="白名单" prop="sign_white_url">
							<el-input v-model="state.ruleForm.sign_white_url" type="textarea" placeholder="请输入签名白名单，格式json字符串" clearable></el-input>
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
import { reactive, onMounted, ref ,unref,nextTick} from 'vue';
import { getinfo,save } from '/@/api/app/index';
import {  ElMessage } from 'element-plus';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);


// 定义变量内容
const dialogFormRef = ref();
const state = reactive({
	ruleForm: {
		id:0,
		title: '', 
		appid: '', 
		is_sign: '', 
		sign_white_url:'',
		is_enabled: 1, 
	},
	groupData: [] , 
	dialog: {
		isShowDialog: false,
		type: '',
		title: '',
		submitTxt: '',
	},
	// 表单校验
	ruleRules: {
		title: [{ required: true, message: '账号不能为空', trigger: 'blur' }],
		appid: [{ required: true, message: 'appid不能为空', trigger: 'blur' }],
	},
	loading: false,
});

// 打开弹窗
const openDialog = (type: string, row?: any) => {
	if (type === 'edit') {
		// 实际请走接口
		getinfo(row.id).then((response: any) => {
			state.ruleForm.id = response.data.id;
			state.ruleForm.appid = response.data.appid;
			state.ruleForm.title = response.data.title;
			state.ruleForm.is_sign = response.data.is_sign;
			state.ruleForm.sign_white_url = response.data.sign_white_url;
			state.ruleForm.is_enabled = response.data.is_enabled;
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
	state.ruleForm.appid = '';
	state.ruleForm.is_sign = 1;
	state.ruleForm.sign_white_url = '';
	state.ruleForm.is_enabled = 1;
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>
