<template>
	<div class="system-menu-dialog-container">
		<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="769px">
			<el-form ref="dialogFormRef" :model="state.ruleForm" :rules="state.ruleRules" size="default" label-width="80px">
				<el-row :gutter="35">
					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="上级部门" prop="parent_id">
							<el-cascader
								:options="state.menuData"
								:props="{ checkStrictly: true, value: 'id', label: 'dept_name' }"
								placeholder="请选择上级部门"
								clearable
								class="w100"
								v-model="state.ruleForm.parent_id"
							>
								<template #default="{ node, data }">
									<span>{{ data.dept_name }}</span>
									<span v-if="!node.isLeaf"> ({{ data.children.length }}) </span>
								</template>
							</el-cascader>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="部门状态" prop="status">
							<el-radio-group v-model="state.ruleForm.status">
								<el-radio :label="1">正常</el-radio>
								<el-radio :label="0">禁用</el-radio>
							</el-radio-group>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="部门名称" prop="dept_name">
							<el-input v-model="state.ruleForm.dept_name" placeholder="请输入部门名称" clearable></el-input>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="负责人" prop="leader">
							<el-input v-model="state.ruleForm.leader" placeholder="请输入部门负责人" clearable></el-input>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="手机号" prop="phone">
							<el-input v-model="state.ruleForm.phone" placeholder="请输入部门手机号" clearable></el-input>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="邮箱" prop="email">
							<el-input v-model="state.ruleForm.email" placeholder="请输入部门邮箱" clearable></el-input>
						</el-form-item>
					</el-col>
   
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="部门排序" prop="sorts">
							<el-input-number v-model="state.ruleForm.sorts" controls-position="right" placeholder="请输入排序" class="w100" />
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

<script setup lang="ts" name="systemMenuForm">
import { defineAsyncComponent, reactive, onMounted, ref ,unref,nextTick} from 'vue';
import { getListAll,getinfo,save } from '/@/api/dept/index';
import { ElMessageBox, ElMessage } from 'element-plus';
import { handleTree } from '/@/utils';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);


// 定义变量内容
const dialogFormRef = ref();
const state = reactive({
	ruleForm: {
		id:0,
		parent_id: 0, // 上级部门
		dept_name: '', // 部门名称
		leader: '',  
		phone: '', 
		email:'',
		sorts:100,// 部门排序
		status:1,
	},
	menuData: [] , // 上级部门数据
	dialog: {
		isShowDialog: false,
		type: '',
		title: '',
		submitTxt: '',
	},
	// 表单校验
	ruleRules: {
		dept_name: [{ required: true, message: '部门名称不能为空', trigger: 'blur' }],
	},
	loading: false,
});

// 打开弹窗
const openDialog = (type: string, row?: any) => {
	if (type === 'edit') {
		// 实际请走接口
		getinfo(row.id).then((response: any) => {
			state.ruleForm.id = response.data.id;
			state.ruleForm.email = response.data.email;
			state.ruleForm.phone = response.data.phone;
			state.ruleForm.parent_id = response.data.parent_id;
			state.ruleForm.leader = response.data.leader;
			state.ruleForm.sorts = response.data.sorts;
			state.ruleForm.status = response.data.status;
			state.ruleForm.dept_name = response.data.dept_name;
		});
		
		state.dialog.title = '修改部门';
		state.dialog.submitTxt = '修 改';
	} else {
		state.dialog.title = '新增部门';
		state.dialog.submitTxt = '新 增';
		// 清空表单，此项需加表单验证才能使用
		nextTick(() => {
			dialogFormRef.value.resetFields();
			initForm();
		});
	}
	state.dialog.type = type;
	state.dialog.isShowDialog = true;
	// 查询部门下拉树结构
	getListAll().then((response: any) => {
		state.menuData = handleTree(response.data.data, 'id', 'parent_id', 'children');
	});
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
			if(state.ruleForm.parent_id != 0 &&  typeof(state.ruleForm.parent_id) == 'object'){
				state.ruleForm.parent_id = state.ruleForm.parent_id.pop();
			}
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
	state.ruleForm.phone = '';
	state.ruleForm.parent_id = 0;
	state.ruleForm.leader = '';
	state.ruleForm.sorts = 100;
	state.ruleForm.status = 1;
	state.ruleForm.dept_name = '';
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>
