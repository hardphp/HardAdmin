<template>
	<div class="system-menu-dialog-container">
		<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="769px">
			<el-form ref="dialogFormRef" :model="state.ruleForm" :rules="state.ruleRules" size="default" label-width="80px">
				<el-row :gutter="35">
					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="角色名称" prop="title">
							<el-input v-model="state.ruleForm.title" placeholder="请输入角色名称" clearable></el-input>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="状态" prop="status">
							<el-radio-group v-model="state.ruleForm.status">
								<el-radio :label="1">正常</el-radio>
								<el-radio :label="0">禁用</el-radio>
							</el-radio-group>
						</el-form-item>
					</el-col>
					

					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="菜单权限" prop="rules">
							<el-tree :data="state.menuData" :props="state.menuProps" ref="menuRef" check-strictly node-key="id" :default-checked-keys="state.ruleForm.rules" show-checkbox class="menu-data-tree" />
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="数据权限" prop="types">
							<el-radio-group v-model="state.ruleForm.types">
								<el-radio :label="1">全部权限</el-radio>
								<el-radio :label="2">本部门权限</el-radio>
								<el-radio :label="3">本部门以及下属权限</el-radio>
								<el-radio :label="4">本人权限</el-radio>
								<el-radio :label="5">自定义权限</el-radio>
							</el-radio-group>
						</el-form-item>
					</el-col>

					<template v-if="state.ruleForm.types == 5 ">
					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="权限范围" prop="deptProps">
							<el-tree :data="state.deptData" :props="state.deptProps" ref="deptRef" default-expand-all check-strictly node-key="id" :default-checked-keys="state.ruleForm.depts" show-checkbox class="menu-data-tree" />
						</el-form-item>
					</el-col>
					</template>
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

<script setup lang="ts" name="systemRoleForm">
import { reactive, onMounted, ref ,unref,nextTick} from 'vue';
import { getinfo,save } from '/@/api/group/index';
import {  ElMessage } from 'element-plus';
import { getListAll } from '/@/api/menu/index';
import { getListAll as getListAllDept } from '/@/api/dept/index';
import { handleTree } from '/@/utils';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);


// 定义变量内容
const dialogFormRef = ref();
const menuRef = ref();
const deptRef = ref();
const state = reactive({
	ruleForm: {
		id:0,
		title: '', 
		status: 1, 
		types:0,
		rules:[],
		depts:[],
	},
	menuData: [] as TreeType[],
	deptData: [] as TreeType[],
	menuProps: {
		children: 'children',
		label: 'name',
	},
	deptProps: {
		children: 'children',
		label: 'dept_name',
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
});

// 所有菜单节点数据
const getMenuAllCheckedKeys = () => {
	const formWrap = unref(menuRef) as any;
	if (!formWrap) return;
	// 目前被选中的菜单节点
	let checkedKeys = formWrap.getCheckedKeys();
	// 半选中的菜单节点
	//let halfCheckedKeys = formWrap.getHalfCheckedKeys();
	//checkedKeys.unshift.apply(checkedKeys, halfCheckedKeys);
	return checkedKeys;
};

// 所有部门节点数据
const getDeptAllCheckedKeys = () => {
	const formWrap = unref(deptRef) as any;
	if (!formWrap) return;
	// 目前被选中的菜单节点
	let checkedKeys = formWrap.getCheckedKeys();
	// 半选中的菜单节点
	//let halfCheckedKeys = formWrap.getHalfCheckedKeys();
	//checkedKeys.unshift.apply(checkedKeys, halfCheckedKeys);
	return checkedKeys;
};

// 打开弹窗
const openDialog = (type: string, row?: any) => {
	if (type === 'edit') {
		// 实际请走接口
		getinfo(row.id).then((response: any) => {
			state.ruleForm.id = response.data.id;
			state.ruleForm.title = response.data.title;
			state.ruleForm.status = response.data.status;
			state.ruleForm.types = response.data.types;
			state.ruleForm.rules = response.data.rules.split(',');
			state.ruleForm.depts = response.data.depts.split(',');
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
	// 查询角色
	getListAll().then((response: any) => {
		state.menuData = handleTree(response.data.data, 'id', 'parent_id', 'children');
	});
	// 查询角色
	getListAllDept().then((response: any) => {
		state.deptData = handleTree(response.data.data, 'id', 'parent_id', 'children');
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
			state.ruleForm.rules = getMenuAllCheckedKeys()
			state.ruleForm.depts = getDeptAllCheckedKeys()

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
	state.ruleForm.status = 1;
	state.ruleForm.types = 0;
	state.ruleForm.rules = [];
	state.ruleForm.depts = [];
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>
