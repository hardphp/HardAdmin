<template>
	<div class="system-menu-dialog-container">
		<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="769px">
			<el-form ref="dialogFormRef" :model="state.ruleForm" :rules="state.ruleRules" size="default" label-width="80px">
				<el-row :gutter="35">

					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="手机号" prop="phone">
							<el-input v-model="state.ruleForm.phone" placeholder="请输入手机号" clearable></el-input>
						</el-form-item>
					</el-col>
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="姓名" prop="realname">
							<el-input v-model="state.ruleForm.realname" placeholder="请输入姓名" clearable></el-input>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="密码" prop="password">
							<el-input v-model="state.ruleForm.password" placeholder="请输入密码" clearable></el-input>
						</el-form-item>
					</el-col>
					
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="邮箱" prop="email">
							<el-input v-model="state.ruleForm.email" placeholder="请输入邮箱" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="生日" prop="birth">
							<el-input v-model="state.ruleForm.birth" placeholder="请输入生日" clearable></el-input>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="头像" prop="img">
							<Uploadimg v-model="state.ruleForm.img" :value="state.ruleForm.img"  @upload="onUpload" :msg="state.msg"/>
						</el-form-item>
					</el-col>
 
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="性别" prop="sex">
							<el-radio-group v-model="state.ruleForm.sex">
								<el-radio :label="1">男</el-radio>
								<el-radio :label="2">女</el-radio>
							</el-radio-group>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="状态" prop="is_enabled">
							<el-radio-group v-model="state.ruleForm.is_enabled">
								<el-radio :label="1">正常</el-radio>
								<el-radio :label="0">禁用</el-radio>
								<el-radio :label="2">待审核</el-radio>
							</el-radio-group>
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

<script setup lang="ts" name="systemUserForm">
import { reactive,defineAsyncComponent, onMounted, ref ,unref,nextTick} from 'vue';
import { getinfo,save } from '/@/api/user/index';
import {  ElMessage } from 'element-plus';

const Uploadimg = defineAsyncComponent(() => import('/@/components/Upload/singleImage.vue'));

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);

// 定义变量内容
const dialogFormRef = ref();
const state = reactive({
	ruleForm: {
		id:0,
		realname: '', 
		password: '', 
		email: '', 
		phone:'',
		img: '', 
		is_enabled: 1, 
		sex:1,
		birth:'',
	},
	dialog: {
		isShowDialog: false,
		type: '',
		title: '',
		submitTxt: '',
	},
	// 表单校验
	ruleRules: {
		realname: [{ required: true, message: '姓名不能为空', trigger: 'blur' }],
		phone: [{ required: true, message: '手机号不能为空', trigger: 'blur' }],
	},
	loading: false,
	msg:'最佳尺寸100*100',
});

const onUpload = (data) => {
	state.ruleForm.img = data;
};

// 打开弹窗
const openDialog = (type: string, row?: any) => {
	if (type === 'edit') {
		// 实际请走接口
		getinfo(row.id).then((response: any) => {
			state.ruleForm.id = response.data.id;
			state.ruleForm.email = response.data.email;
			state.ruleForm.realname = response.data.realname;
			state.ruleForm.phone = response.data.phone;
			state.ruleForm.img = response.data.img;
			state.ruleForm.is_enabled = response.data.is_enabled;
			state.ruleForm.sex = response.data.sex;
			state.ruleForm.birth = response.data.birth;
			
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
	state.ruleForm.email ='';
	state.ruleForm.realname = '';
	state.ruleForm.phone = '';
	state.ruleForm.img = '';
	state.ruleForm.is_enabled = 1;
	state.ruleForm.sex = 1;
	state.ruleForm.birth = 1;
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>
