<template>
	<div class="table-admin-container layout-padding">
		<div class="table-admin-padding layout-padding-view layout-padding-auto">
			<TableSearch :search="state.tableData.search" :isAdd="state.tableData.config.isAdd" @search="onSearch" @add="onTableAddRow"/>
			<Table
				ref="tableRef"
				v-bind="state.tableData"
				class="table-admin"
				@updateRow="onTableUpdateRow"
				@delRow="onTableDelRow"
				@pageChange="onTablePageChange"
				@sortHeader="onSortHeader"
			/>
		</div>
		<EditDialog  ref="editRef"  @refresh="getTableData()" />
	</div>
</template>

<script setup lang="ts" name="{%tableName%}Lists">
import { defineAsyncComponent, reactive, ref, onMounted } from 'vue';
import { ElMessage } from 'element-plus';
import { getList,getListAll,del,change } from '/@/api/{%tableName%}/index';
{%dictDataApi%}
import { handleTree } from '/@/utils';

// 引入组件
const Table = defineAsyncComponent(() => import('/@/components/table/index.vue'));
const TableSearch = defineAsyncComponent(() => import('/@/components/table/search.vue'));
const EditDialog = defineAsyncComponent(() => import('/@/views/cogen/{%tableName%}/form/edit.vue'));

// 定义变量内容
const tableRef = ref<RefType>();
const editRef = ref();
const state = reactive<TableDemoState>({
	tableData: {
		// 列表数据（必传）
		data: [],
		// 表头内容（必传，注意格式）
		header: {%header%},
		// 配置项（必传）
		config: {%config%},
		// 搜索表单，动态生成（传空数组时，将不显示搜索，注意格式）
		search: {%search%},
		// 搜索参数（不用传，用于分页、搜索时传给后台的值，`getTableData` 中使用）
		param: {%param%},
		//显示分页
		showpage:{%showpage%},
		// 打印标题
		printName: '数据打印',
		//列字典
		dictData:{%dictData%},
	},
	
});

// 初始化列表数据
const getTableData =  () => {
	state.tableData.config.loading = true;
	state.tableData.data = [];
	{%getList%}(state.tableData.param).then((response: any) => {
		state.tableData.data = {%responsedata%};
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
/** 修改按钮操作 */
const onTableUpdateRow = (row: any) => {
	editRef.value.openDialog('edit',row);
};


// 页面加载时
onMounted(() => {
	getTableData();
	// 关联查询
	{%dictDataPost%}
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
