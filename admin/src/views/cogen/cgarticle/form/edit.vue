<template>
	<div class="system-menu-dialog-container">
		<el-dialog :title="state.dialog.title" v-model="state.dialog.isShowDialog" width="900px">
			<el-form ref="dialogFormRef" :model="state.ruleForm" :rules="state.ruleRules" size="default" label-width="80px">
				 <el-tabs v-model="activeName" class="admin-tabs">
                <el-tab-pane label="基础信息" name="first">
                <el-row :gutter="35">
                    <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="部门id" prop="dept_id">
							<el-select v-model="state.ruleForm.dept_id" placeholder="请选择" clearable class="mb20">
								<el-option  v-for="item in state.deptdept_name" :key="item.id" :label="item.dept_name" :value="item.id" ></el-option>
							</el-select>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="栏目id" prop="cid">
							<el-select v-model="state.ruleForm.cid" placeholder="请选择" clearable class="mb20">
								<el-option  v-for="item in state.cg_columnname" :key="item.id" :label="item.name" :value="item.id" ></el-option>
							</el-select>
						</el-form-item>
					</el-col>
<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="标题" prop="title">
							<el-input v-model="state.ruleForm.title" placeholder="请输入标题" clearable></el-input>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="用户id" prop="userid">
							<el-input v-model="state.ruleForm.userid" placeholder="请输入用户id" clearable></el-input>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="分类" prop="cate">
							<el-input v-model="state.ruleForm.cate" placeholder="请输入分类" clearable></el-input>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="作者" prop="author">
							<el-input v-model="state.ruleForm.author" placeholder="请输入作者" clearable></el-input>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20" >
								<el-form-item label="发布时间" prop="add_time">
									<el-date-picker v-model="state.ruleForm.add_time"	type="datetime" value-format="YYYY-MM-DD HH:mm:ss" placeholder="请输入发布时间" size="default" />
								</el-form-item>
							</el-col>
                    <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20" >
								<el-form-item label="开始时间" prop="start_time">
									<el-date-picker v-model="state.ruleForm.start_time"	type="datetime" value-format="YYYY-MM-DD HH:mm:ss" placeholder="请输入开始时间" size="default" />
								</el-form-item>
							</el-col>
                    <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20" >
								<el-form-item label="结束时间" prop="end_time">
									<el-date-picker v-model="state.ruleForm.end_time"	type="datetime" value-format="YYYY-MM-DD HH:mm:ss" placeholder="请输入结束时间" size="default" />
								</el-form-item>
							</el-col>
                    <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="排序" prop="sorts">
							<el-input v-model="state.ruleForm.sorts" placeholder="请输入排序" type="number" clearable></el-input>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="访问量" prop="visit_num">
							<el-input v-model="state.ruleForm.visit_num" placeholder="请输入访问量" type="number" clearable></el-input>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="状态  0 禁用，1正常" prop="status">
							<el-radio-group v-model="state.ruleForm.status">
                        		<el-radio :label="0">禁用</el-radio>
                        		<el-radio :label="1">正常</el-radio>
                        	</el-radio-group>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="类型" prop="types">
							<el-radio-group v-model="state.ruleForm.types">
                        		<el-radio :label="1">列表</el-radio>
                        		<el-radio :label="2">单页</el-radio>
                        		<el-radio :label="3">链接</el-radio>
                        	</el-radio-group>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="图片" prop="img">
							<Uploadimg  v-model="state.ruleForm.img" :value="state.ruleForm.img"  @upload="onUpload" :msg="state.msg"/>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="视频" prop="video">
						    <el-input v-model="state.ruleForm.video" clearable placeholder="直接输入视频网址或者上传本地视频"/>
							<Uploadvedio  v-model="state.ruleForm.video" :value="state.ruleForm.video"  @uploadvedio="onUploadvedio"/>
						</el-form-item>
					</el-col>
                    <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="描述" prop="notes">
							<el-input v-model="state.ruleForm.notes" placeholder="请输入描述" type="textarea" :rows="2" clearable></el-input>
						</el-form-item>
					</el-col>
                </el-row>
                </el-tab-pane>
                <el-tab-pane label="详细信息" name="second">
                <el-row :gutter="35">
                    <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="详情" prop="hour">
							<Editor v-model:get-html="state.ruleForm.content"  />
						</el-form-item>
					</el-col>
                </el-row>
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

<script setup lang="ts" name="cgarticleForm">
import { reactive, defineAsyncComponent,onMounted, ref ,unref,nextTick} from 'vue';
import { getinfo,save } from '/@/api/cgarticle/index';
import {  ElMessage } from 'element-plus';
import { getListAll as getdeptdept_name } from '/@/api/dept/index';
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
    title:'',
    dept_id:'',
    userid:'',
    cid:'',
    cate:'',
    notes:'',
    content:'',
    status:'',
    sorts:'',
    types:'',
    img:'',
    visit_num:'',
    video:'',
    author:'',
    add_time:'',
    start_time:'',
    end_time:'',
  },
	deptdept_name:[],
cg_columnname:[],

	dialog: {
		isShowDialog: false,
		type: '',
		title: '',
		submitTxt: '',
	},
	// 表单校验
	ruleRules:  { 
    title: [{ required: true, message: 'title不能为空', trigger: 'blur' }],
    dept_id: [{ required: true, message: 'dept_id不能为空', trigger: 'blur' }],
    userid: [{ required: true, message: 'userid不能为空', trigger: 'blur' }],
    cid: [{ required: true, message: 'cid不能为空', trigger: 'blur' }],
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
      state.ruleForm.title = response.data.title;
      state.ruleForm.dept_id = response.data.dept_id;
      state.ruleForm.userid = response.data.userid;
      state.ruleForm.cid = response.data.cid;
      state.ruleForm.cate = response.data.cate;
      state.ruleForm.notes = response.data.notes;
      state.ruleForm.content = response.data.content;
      state.ruleForm.status = response.data.status;
      state.ruleForm.sorts = response.data.sorts;
      state.ruleForm.types = response.data.types;
      state.ruleForm.img = response.data.img;
      state.ruleForm.visit_num = response.data.visit_num;
      state.ruleForm.video = response.data.video;
      state.ruleForm.author = response.data.author;
      state.ruleForm.add_time = response.data.add_time;
      state.ruleForm.start_time = response.data.start_time;
      state.ruleForm.end_time = response.data.end_time;

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
	getdeptdept_name({fileds:['id','dept_name']}).then((response: any) => {
		state.deptdept_name = response.data.data;
	});
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
  state.ruleForm.title = '';
  state.ruleForm.dept_id = '';
  state.ruleForm.userid = '';
  state.ruleForm.cid = '';
  state.ruleForm.cate = '';
  state.ruleForm.notes = '';
  state.ruleForm.content = '';
  state.ruleForm.status = '';
  state.ruleForm.sorts = '';
  state.ruleForm.types = '';
  state.ruleForm.img = '';
  state.ruleForm.visit_num = '';
  state.ruleForm.video = '';
  state.ruleForm.author = '';
  state.ruleForm.add_time = '';
  state.ruleForm.start_time = '';
  state.ruleForm.end_time = '';

};

// 暴露变量
defineExpose({
	openDialog,
});
</script>
