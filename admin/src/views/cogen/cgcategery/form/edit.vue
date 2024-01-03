<template>
	<div class="system-menu-dialog-container">
		<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="900px">
			<el-form ref="dialogFormRef" :model="state.ruleForm" :rules="state.ruleRules" size="default" label-width="80px">
				 <el-row :gutter="35">
<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="栏目" prop="cid">
							<el-select v-model="state.ruleForm.cid" placeholder="请选择" clearable class="mb20">
								<el-option  v-for="item in state.cg_columnname" :key="item.id" :label="item.name" :value="item.id" ></el-option>
							</el-select>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="名称" prop="name">
							<el-input v-model="state.ruleForm.name" placeholder="请输入名称" clearable></el-input>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="排序" prop="sorts">
							<el-input v-model="state.ruleForm.sorts" placeholder="请输入排序" type="number" clearable></el-input>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="状态" prop="status">
							<el-radio-group v-model="state.ruleForm.status">
                        		<el-radio :label="0">禁用</el-radio>
                        		<el-radio :label="1">正常</el-radio>
                        	</el-radio-group>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="描述" prop="content">
							<el-input v-model="state.ruleForm.content" placeholder="请输入描述" type="textarea" :rows="2" clearable></el-input>
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

<script setup lang="ts" name="cgcategeryForm">
import { reactive, defineAsyncComponent,onMounted, ref ,unref,nextTick} from 'vue';
import { getinfo,save } from '/@/api/cgcategery/index';
import {  ElMessage } from 'element-plus';
import { getListAll as getcgcolumnname } from '/@/api/cgcolumn/index';


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
	ruleForm: {
    id:'',
    cid:'',
    name:'',
    content:'',
    status:'',
    sorts:'',
  },
	cg_columnname:[],

	dialog: {
		isShowDialog: false,
		type: '',
		title: '',
		submitTxt: '',
	},
	// 表单校验
	ruleRules:  { 
    cid: [{ required: true, message: 'cid不能为空', trigger: 'blur' }],
    name: [{ required: true, message: 'name不能为空', trigger: 'blur' }],
  },
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
			state.ruleForm.id = response.data.id;
      state.ruleForm.cid = response.data.cid;
      state.ruleForm.name = response.data.name;
      state.ruleForm.content = response.data.content;
      state.ruleForm.status = response.data.status;
      state.ruleForm.sorts = response.data.sorts;

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
	getcgcolumnname({fileds:['id','name']}).then((response: any) => {
		state.cg_columnname = response.data.data;
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
	state.ruleForm.id = '';
  state.ruleForm.cid = '';
  state.ruleForm.name = '';
  state.ruleForm.content = '';
  state.ruleForm.status = '';
  state.ruleForm.sorts = '';

};

// 暴露变量
defineExpose({
	openDialog,
});
</script>
