<template>
	<div class="table-admin-container layout-padding">
		<div class="table-admin-padding layout-padding-view layout-padding-auto">
			<TableSearch :search="state.tableData.search" :isAdd="state.tableData.config.isAdd" @search="onSearch" @add="onTableAddRow"/>
			<Table
				ref="tableRef"
				v-bind="state.tableData"
				class="table-admin"
				@updateRow="onTableUpdateRow"
				@threeRow="onThreeRow"
				@delRow="onTableDelRow"
				@pageChange="onTablePageChange"
				@sortHeader="onSortHeader"
			/>
		</div>
		<EditDialog  ref="editRef"  @refresh="getTableData()" />
		<CodeDialog  ref="codeRef" />
	</div>
</template>

<script setup lang="ts" name="toolCogen">
import { defineAsyncComponent, reactive, ref, onMounted } from 'vue';
import { ElMessage } from 'element-plus';
import { getList,del,change } from '/@/api/cogen/index';

// 引入组件
const Table = defineAsyncComponent(() => import('/@/components/table/index.vue'));
const TableSearch = defineAsyncComponent(() => import('/@/components/table/search.vue'));
const EditDialog = defineAsyncComponent(() => import('/@/views/tool/cogen/form/edit.vue'));
const CodeDialog = defineAsyncComponent(() => import('/@/views/tool/cogen/form/code.vue'));

// 定义变量内容
const tableRef = ref<RefType>();
const editRef = ref();
const codeRef = ref();
const state = reactive<TableDemoState>({
	tableData: {
		// 列表数据（必传）
		data: [],
		// 表头内容（必传，注意格式）
		header: [
			{ key: 'id', colWidth: '80', title: 'ID', type: 'text', isCheck: true },
			{ key: 'table', colWidth: '', title: '数据表', type: 'text', isCheck: true },
			{ key: 'comment', colWidth: '150', title: '表注释', type: 'text',  isCheck: true },
			{ key: 'update_time', colWidth: '200', title: '更新时间', type: 'text', isCheck: true },
			{ key: 'create_time', colWidth: '200', title: '创建时间', type: 'text', isCheck: true },
			
		],
		// 配置项（必传）
		config: {
			total: 0, // 列表总数
			loading: true, // loading 加载
			isBorder: false, // 是否显示表格边框
			isSerialNo: false, // 是否显示表格序号
			isSelection: true, // 是否显示表格多选
			isOperate: true, // 是否显示表格操作栏
			isAdd: 'admin:cogen:save', //新增标识
			isUpdate: 'admin:cogen:save', //修改标识
			isDelete: 'admin:cogen:del', //删除标识
			isThree: '代码',//第三按钮

		},
		// 搜索表单，动态生成（传空数组时，将不显示搜索，注意格式）
		search: [
			{ label: '数据表', prop: 'table', placeholder: '请输入名称', required: false, type: 'input' },
		],
		// 搜索参数（不用传，用于分页、搜索时传给后台的值，`getTableData` 中使用）
		param: {
			page: 1,
			psize: 10,
		},
		// 打印标题
		printName: '数据打印',
		//列字典
		dictData:{
		},
	},
	
});

// 初始化列表数据
const getTableData =  () => {
	state.tableData.config.loading = true;
	state.tableData.data = [];
	getList(state.tableData.param).then((response: any) => {
		state.tableData.data = response.data.data;
		state.tableData.config.total = response.data.total;
		state.tableData.config.loading = false;
	});
};

// 搜索点击时表单回调
const onSearch = (data: EmptyObjectType) => {
	state.tableData.param = Object.assign({}, state.tableData.param, { ...data });
	tableRef.value.pageReset();
};
// 删除当前项回调
const onTableDelRow = (row: EmptyObjectType) => {
	return del(row.id).then(() => {
		getTableData();
		ElMessage.success(`删除${row.id}成功！`);
	});
};
// 分页改变时回调
const onTablePageChange = (page: TableDemoPageType) => {
	state.tableData.param.page = page.page;
	state.tableData.param.psize = page.psize;
	getTableData();
};
// 拖动显示列排序回调
const onSortHeader = (data: TableHeaderType[]) => {
	state.tableData.header = data;
};

/** 新增按钮操作 */
const onTableAddRow = () => {
	editRef.value.openDialog('add');
};
/** 第三操作 */
const onThreeRow = (row: any) => {
	codeRef.value.openDialog(row);
};

/** 修改按钮操作 */
const onTableUpdateRow = (row: any) => {
	editRef.value.openDialog('edit',row);
};


// 页面加载时
onMounted(() => {
	getTableData();
});
</script>

<style scoped lang="scss">
.table-admin-container {
	.table-admin-padding {
		padding: 15px;
		.table-admin {
			flex: 1;
			overflow: hidden;
		}
	}
}
</style>
