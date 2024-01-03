<template>
	<div class="system-menu-dialog-container">
		<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="80%">
			<el-form ref="dialogFormRef" :model="state.ruleForm" :rules="state.ruleRules" size="default" label-width="100px">
				<el-tabs v-model="activeName" class="admin-tabs">
					<el-tab-pane label="基础信息" name="first">
				
						<el-row :gutter="35">
							
							 
							<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
								<el-form-item label="数据表" prop="table">
									<el-select v-model="state.ruleForm.table"  placeholder="请选择" clearable filterable class="mb20" >
										<el-option  v-for="item in state.tablesData" :key="item" :label="item" :value="item" ></el-option>
									</el-select>
									<el-button type="primary" text @click="getFields()" size="default">查询</el-button>
								</el-form-item>
							</el-col>

							<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
								<el-form-item label="菜单名称" prop="comment">
									<el-input v-model="state.ruleForm.comment" placeholder="请输入菜单名称" clearable></el-input>
								</el-form-item>
							</el-col>
							
							<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
								<el-form-item label="输出字段" prop="show_field">
									<el-select v-model="state.ruleForm.show_field" multiple placeholder="请选择" filterable clearable class="mb20" style="width: 100%">
										<el-option  v-for="item in state.fieldData" :key="item.field" :label="item.comment" :value="item.field" ></el-option>
									</el-select>
								</el-form-item>
							</el-col>

							<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
								<el-form-item label="搜索字段" prop="search">
									<el-select v-model="state.ruleForm.search" multiple placeholder="请选择" filterable clearable class="mb20" style="width: 100%">
										<el-option  v-for="item in state.fieldData" :key="item.field" :label="item.comment" :value="item.field" ></el-option>
									</el-select>
								</el-form-item>
							</el-col>

							<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
								<el-form-item label="列表字段" prop="lists">
									<el-select v-model="state.ruleForm.lists" multiple placeholder="请选择" filterable clearable class="mb20" style="width: 100%">
										<el-option  v-for="item in state.fieldData" :key="item.field" :label="item.comment" :value="item.field" ></el-option>
									</el-select>
								</el-form-item>
							</el-col>

							<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
								<el-form-item label="表单字段" prop="form">
									<el-select v-model="state.ruleForm.form" multiple placeholder="请选择" filterable clearable class="mb20" style="width: 100%">
										<el-option  v-for="item in state.fieldData" :key="item.field" :label="item.comment" :value="item.field" ></el-option>
									</el-select>
								</el-form-item>
							</el-col>
 
							<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
								<el-form-item label="必填字段" prop="form_require">
									<el-select v-model="state.ruleForm.form_require" multiple placeholder="请选择" filterable clearable class="mb20" style="width: 100%">
										<el-option  v-for="item in state.fieldData" :key="item.field" :label="item.comment" :value="item.field" ></el-option>
									</el-select>
								</el-form-item>
							</el-col>

							<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
								<el-form-item label="检索字段" prop="name">
									<el-select v-model="state.ruleForm.name" placeholder="请选择" filterable clearable class="mb20" style="width: 100%">
										<el-option  v-for="item in state.fieldData" :key="item.field" :label="item.comment" :value="item.field" ></el-option>
									</el-select>
								</el-form-item>
							</el-col>

							<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
								<el-form-item label="后台数据权限" prop="isauth">
									<el-radio-group v-model="state.ruleForm.isauth">
										<el-radio :label="1">是</el-radio>
										<el-radio :label="0">否</el-radio>
									</el-radio-group>
								</el-form-item>
							</el-col>

							<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
								<el-form-item label="前端登录" prop="islogin">
									<el-radio-group v-model="state.ruleForm.islogin">
										<el-radio :label="1">是</el-radio>
										<el-radio :label="0">否</el-radio>
									</el-radio-group>
								</el-form-item>
							</el-col>

							<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
								<el-form-item label="前端用户" prop="userid">
									<el-select v-model="state.ruleForm.userid" placeholder="请选择" filterable clearable class="mb20" style="width: 100%">
										<el-option  v-for="item in state.fieldData" :key="item.field" :label="item.comment" :value="item.field" ></el-option>
									</el-select>
								</el-form-item>
							</el-col>

		
						</el-row>

					</el-tab-pane>
					<el-tab-pane label="详细信息" name="second">	
						
						<el-table :data="state.ruleForm.field_rule" v-loading="state.loading" style="width: 100%">
							<el-table-column label="字段" prop="field" width="100" ></el-table-column>
							<el-table-column label="名称" prop="comment">
								<template #default="scope">
									<el-input v-model="scope.row.comment" placeholder="请输入字段名称" clearable></el-input>
								</template>
							</el-table-column>
							<el-table-column label="类型" prop="type"></el-table-column>
							<el-table-column label="查询" prop="query">
								<template #default="scope">
									<el-select v-model="scope.row.query"  placeholder="请选择" filterable clearable  style="width: 100%">
										<el-option  v-for="item in state.query" :key="item" :label="item" :value="item" ></el-option>
									</el-select>
								</template>
							</el-table-column>
							<el-table-column label="展示" prop="show">
								<template #default="scope">
									<el-select v-model="scope.row.show"  placeholder="请选择" filterable clearable  style="width: 100%">
										<el-option  v-for="item in state.show" :key="item" :label="item" :value="item" ></el-option>
									</el-select>
								</template>
							</el-table-column>
							<el-table-column label="字典" prop="radio">
								<template #default="scope">
									<el-input v-model="scope.row.radio" placeholder="数据字典JSON" clearable></el-input>
								</template>
							</el-table-column>
							 
							<el-table-column label="关联表键值" prop="idkey">
								<template #default="scope">
									<el-cascader
									:options="state.tablesFieldData"
									:props="{ checkStrictly: true, value: 'id', label: 'name' }"
									placeholder="请选择"
									clearable
									class="w100"
									v-model="scope.row.idkey"
								>
									<template #default="{ node, data }">
										<span>{{ data.name }}</span>
										<span v-if="!node.isLeaf"> ({{ data.children.length }}) </span>
									</template>
								</el-cascader>


								</template>
							</el-table-column>

							<el-table-column label="关联表字段" prop="option">
								<template #default="scope">
									<el-cascader
									:options="state.tablesFieldData"
									:props="{ checkStrictly: true, value: 'id', label: 'name' }"
									placeholder="请选择"
									clearable
									class="w100"
									v-model="scope.row.option"
								>
									<template #default="{ node, data }">
										<span>{{ data.name }}</span>
										<span v-if="!node.isLeaf"> ({{ data.children.length }}) </span>
									</template>
								</el-cascader>


								</template>
							</el-table-column>
							
						</el-table>
						
						
					</el-tab-pane>
		
				</el-tabs>


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
import { reactive, onMounted, ref,watch ,unref,nextTick} from 'vue';
import { getinfo,save,gettables,gettablefields,getFieldRule,gettablechild } from '/@/api/cogen/index';
import {  ElMessage } from 'element-plus';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['refresh']);


// 定义变量内容
const activeName = ref('first');
const dialogFormRef = ref();
const state = reactive({
	ruleForm: {
		id:0,
		table: '', 
		comment: '', 
		search: '', 
		lists: '', 
		form: '', 
		show_field: [], 
		name: '', 
		islogin:0,
		userid:'',
		form_require: '', 
		field_rule :[],
	},
	fieldData: [] , 
	tablesData:[],
	tablesFieldData:[],
	query:['=','<>','>','>=','<','<=','like'],
	show:['text','textarea','number','radio','select','image','video','file','datetime','date','editor'],
	option:[],
	dialog: {
		isShowDialog: false,
		type: '',
		table: '',
		submitTxt: '',
	},
	// 表单校验
	ruleRules: {
		table: [{ required: true, message: '数据表不能为空', trigger: 'blur' }],
		comment: [{ required: true, message: '表注释不能为空', trigger: 'blur' }],
		search: [{ required: true, message: '搜索字段不能为空', trigger: 'blur' }],
		lists: [{ required: true, message: '列表字段不能为空', trigger: 'blur' }],
		form: [{ required: true, message: '表单字段不能为空', trigger: 'blur' }],
		show_field: [{ required: true, message: '输出字段不能为空', trigger: 'blur' }],
		name: [{ required: true, message: '必填字段不能为空', trigger: 'blur' }],
		form_require: [{ required: true, message: '检索字段不能为空', trigger: 'blur' }],
	},
	loading: false,
	lock:false,
});

// 打开弹窗
const openDialog = (type: string, row?: any) => {
	if (type === 'edit') {
		// 实际请走接口
		getinfo(row.id).then((response: any) => {
			state.ruleForm.id = response.data.id;
			state.ruleForm.comment = response.data.comment;
			state.ruleForm.table = response.data.table;
			state.ruleForm.search= response.data.search;
			state.ruleForm.lists= response.data.lists;
			state.ruleForm.form= response.data.form;
			state.ruleForm.show_field= response.data.show_field;
			state.ruleForm.name= response.data.name;
			state.ruleForm.islogin = response.data.islogin;
			state.ruleForm.isauth = response.data.isauth;
			state.ruleForm.userid = response.data.userid;
			state.ruleForm.form_require= response.data.form_require;
			state.ruleForm.field_rule = response.data.field_rule;

			gettablefields(state.ruleForm.table).then((response) => {
				if(response.status == 1){
					state.fieldData = response.data;
				}
			})	


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
	getTable();
	gettablechilds();
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
	if (!formWrap) {
		return;
	}
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

// 获取表格信息
const getTable = () => {
	gettables().then((response) => {
		if(response.status == 1){
			state.tablesData = response.data;
		}
	})
 
};

// 获取表格信息
const gettablechilds = () => {
	gettablechild().then((response) => {
		if(response.status == 1){
			state.tablesFieldData = response.data;
		}
	})
 
};

// 获取表格信息
const getFields = () => {
	if(!state.ruleForm.table) {
		ElMessage.success('请先选择数据表');
		return false;
	}
	gettablefields(state.ruleForm.table).then((response) => {
		if(response.status == 1){
			state.fieldData = response.data.data;
			state.ruleForm.comment = response.data.comment;
			state.ruleForm.show_field = state.fieldData.map(row => row['field']);  
			state.ruleForm.lists = state.ruleForm.show_field;
			state.ruleForm.form= state.fieldData.map(row => {
				if(row['field'] != 'create_time' && row['field'] != 'update_time'){
					return row['field'];
				}else{
					return '';
				}
				
			});
			state.ruleForm.form = state.ruleForm.form.filter(field => field != '');

			state.ruleForm.search= state.fieldData.map(row => {
				if(row['field'].includes('title') || row['field'].includes('name')){
					return row['field'];
				}else{
					return '';
				}
			});
			 
			state.ruleForm.search = state.ruleForm.search.filter(field => field != '');

			state.ruleForm.form_require= state.fieldData.map(row => {
				if(row['field'].includes('title') || row['field'].includes('name') || (row['field'].includes('id') && row['field'] != 'id')){
					return row['field'];
				}else{
					return '';
				}
			});
			 
			state.ruleForm.form_require = state.ruleForm.form_require.filter(field => field != '');

			
			 
		}
	})
	getFieldRule(state.ruleForm.table).then((response: any) => {
		state.ruleForm.field_rule = response.data;
	});

	 
	state.ruleForm.name= '';
	state.ruleForm.islogin = 0;
	state.ruleForm.isauth = 0;
	state.ruleForm.userid = '';

};
 
// 页面加载时
onMounted(() => {
	
});


// 表单初始化，方法：`resetFields()` 无法使用
const initForm = () => {
	state.ruleForm.id = 0;
	state.ruleForm.table = '';
	state.ruleForm.comment = '';
	state.ruleForm.search= '';
	state.ruleForm.lists= '';
	state.ruleForm.form= '';
	state.ruleForm.show_field= [];
	state.ruleForm.name= '';
	state.ruleForm.form_require= '';
	state.ruleForm.field_rule= '';
	state.fieldData = '';
};

// 暴露变量
defineExpose({
	openDialog,
});
</script>
