<template>
	<div class="system-menu-dialog-container">
		<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="769px">
			<el-form ref="dialogFormRef" :model="state.ruleForm" :rules="state.ruleRules" size="default" label-width="80px">
				<el-row :gutter="35">
					<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="上级菜单" prop="parent_id">
							<el-cascader
								:options="state.menuData"
								:props="{ checkStrictly: true, value: 'id', label: 'name' }"
								placeholder="请选择上级菜单"
								clearable
								class="w100"
								v-model="state.ruleForm.parent_id"
							>
								<template #default="{ node, data }">
									<span>{{ data.name }}</span>
									<span v-if="!node.isLeaf"> ({{ data.children.length }}) </span>
								</template>
							</el-cascader>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="24" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="菜单类型" prop="menu_type">
							<el-radio-group v-model="state.ruleForm.menu_type">
								<el-radio label="menu">菜单</el-radio>
								<el-radio label="btn">按钮</el-radio>
							</el-radio-group>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="菜单状态" prop="status">
							<el-radio-group v-model="state.ruleForm.status">
								<el-radio :label="1">正常</el-radio>
								<el-radio :label="0">禁用</el-radio>
							</el-radio-group>
						</el-form-item>
					</el-col>
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="菜单名称" prop="name">
							<el-input v-model="state.ruleForm.name" placeholder="请输入菜单名称" clearable></el-input>
						</el-form-item>
					</el-col>

					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="权限标识" prop="permission">
							<el-input v-model="state.ruleForm.permission" placeholder="请输入菜单名称" clearable></el-input>
						</el-form-item>
					</el-col>
 
					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="菜单图标" prop="icon">
							<IconSelector placeholder="请输入菜单图标" v-model="state.ruleForm.icon" />
						</el-form-item>
					</el-col>
					

					<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="菜单排序" prop="sorts">
							<el-input-number v-model="state.ruleForm.sorts" controls-position="right" placeholder="请输入排序" class="w100" />
						</el-form-item>
					</el-col>
					
					<template v-if="state.ruleForm.menu_type === 'menu'">

						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="路由路径" prop="path">
								<el-input v-model="state.ruleForm.path" placeholder="路由中的 path 值" clearable></el-input>
							</el-form-item>
						</el-col>

						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="组件路径" prop="component">
								<el-input v-model="state.ruleForm.component" placeholder="组件路径" clearable></el-input>
							</el-form-item>
						</el-col>

						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="是否隐藏" prop="is_hide">
								<el-radio-group v-model="state.ruleForm.is_hide">
									<el-radio :label="1">隐藏</el-radio>
									<el-radio :label="0">不隐藏</el-radio>
								</el-radio-group>
							</el-form-item>
						</el-col>
						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="页面缓存" prop="is_keep_alive">
								<el-radio-group v-model="state.ruleForm.is_keep_alive">
									<el-radio :label="1">缓存</el-radio>
									<el-radio :label="0">不缓存</el-radio>
								</el-radio-group>
							</el-form-item>
						</el-col>
						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="是否固定" prop="is_affix">
								<el-radio-group v-model="state.ruleForm.is_affix">
									<el-radio :label="1">固定</el-radio>
									<el-radio :label="0">不固定</el-radio>
								</el-radio-group>
							</el-form-item>
						</el-col>
						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="是否内嵌" prop="is_iframe">
								<el-radio-group v-model="state.ruleForm.is_iframe" @change="onSelectIframeChange">
									<el-radio :label="1">是</el-radio>
									<el-radio :label="0">否</el-radio>
								</el-radio-group>
							</el-form-item>
						</el-col>
						<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
							<el-form-item label="是否外链" prop="is_link">
								<el-radio-group v-model="state.ruleForm.is_link" :disabled="state.ruleForm.is_iframe">
									<el-radio :label="1">是</el-radio>
									<el-radio :label="0">否</el-radio>
								</el-radio-group>
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

<script setup lang="ts" name="systemMenuForm">
import { defineAsyncComponent, reactive, onMounted, ref ,unref,nextTick} from 'vue';
import { getListAll,getinfo,save } from '/@/api/menu/index';
import { ElMessageBox, ElMessage } from 'element-plus';
import { handleTree } from '/@/utils';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);

// 引入组件
const IconSelector = defineAsyncComponent(() => import('/@/components/iconSelector/index.vue'));

// 定义变量内容
const dialogFormRef = ref();
const state = reactive({
	ruleForm: {
		id:0,
		parent_id: 0, // 上级菜单
		menu_type: 'menu', // 菜单类型
		name: '', // 菜单名称
		path: '', // 组件路径
		icon: '', // 菜单图标
		component:'layout/routerView/parent',
		permission:'模块:控制器:方法',
		sorts:100,// 菜单排序
		status:1,
		is_hide: 0, // 是否隐藏
		is_keep_alive: 1, // 是否缓存
		is_affix: 0, // 是否固定
		is_link: 0, // 外链/内嵌时链接地址（http:xxx.com），开启外链条件，`1、isLink: 链接地址不为空`
		is_iframe: 0, // 是否内嵌，开启条件，`1、isIframe:true 2、isLink：链接地址不为空`
	},
	menuData: [] , // 上级菜单数据
	dialog: {
		isShowDialog: false,
		type: '',
		title: '',
		submitTxt: '',
	},
	// 表单校验
	ruleRules: {
		name: [{ required: true, message: '菜单名称不能为空', trigger: 'blur' }],
		permission: [{ required: true, message: '权限标识', trigger: 'blur' }],
	},
	loading: false,
});

// 打开弹窗
const openDialog = (type: string, row?: any) => {
	if (type === 'edit') {
		// 实际请走接口
		getinfo(row.id).then((response: any) => {
			state.ruleForm.id = response.data.id;
			state.ruleForm.component = response.data.component;
			state.ruleForm.icon = response.data.icon;
			state.ruleForm.is_affix = response.data.is_affix;
			state.ruleForm.is_hide = response.data.is_hide;
			state.ruleForm.is_iframe = response.data.is_iframe;
			state.ruleForm.is_keep_alive = response.data.is_keep_alive;
			state.ruleForm.is_link = response.data.is_link;
			state.ruleForm.menu_type = response.data.menu_type;
			state.ruleForm.parent_id = response.data.parent_id;
			state.ruleForm.path = response.data.path;
			state.ruleForm.sorts = response.data.sorts;
			state.ruleForm.status = response.data.status;
			state.ruleForm.name = response.data.name;
			state.ruleForm.permission = response.data.permission
		});
		
		state.dialog.title = '修改菜单';
		state.dialog.submitTxt = '修 改';
	} else {
		state.dialog.title = '新增菜单';
		state.dialog.submitTxt = '新 增';
		// 清空表单，此项需加表单验证才能使用
		nextTick(() => {
			dialogFormRef.value.resetFields();
			initForm();
		});
	}
	state.dialog.type = type;
	state.dialog.isShowDialog = true;
	// 查询菜单下拉树结构
	getListAll().then((response: any) => {
		response.data.data.unshift({ id: 0, name: '顶级菜单' });
		state.menuData = handleTree(response.data.data, 'id', 'parent_id', 'children');
	});
};
// 关闭弹窗
const closeDialog = () => {
	initForm();
	state.dialog.isShowDialog = false;
};
// 是否内嵌下拉改变
const onSelectIframeChange = () => {
	if (state.ruleForm.is_iframe) state.ruleForm.is_link = 1;
	else state.ruleForm.is_link = 0;
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
	state.ruleForm.component = 'layout/routerView/parent';
	state.ruleForm.icon = '';
	state.ruleForm.is_affix = 0;
	state.ruleForm.is_hide = 0;
	state.ruleForm.is_iframe = 0;
	state.ruleForm.is_keep_alive = 1;
	state.ruleForm.is_link = 0;
	state.ruleForm.menu_type = 'menu';// 菜单类型;
	state.ruleForm.parent_id = 0;
	state.ruleForm.path = '';
	state.ruleForm.sorts = 100;
	state.ruleForm.status = 1;
	state.ruleForm.name = '';
	state.ruleForm.permission = '模块:控制器:方法'
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>
