import request from '/@/utils/request';

//获取分页部门列表
export function getList(params: object) {
	return request({
		url: '/admin/dept/index',
		method: 'post',
		data: params,
	});
}

//获取全部部门列表
export function getListAll(params: any) {
	return request({
		url: '/admin/dept/getlists',
		method: 'post',
		data: params,
	});
}

//获取全部列表
export function getListsIdName(params: any) {
	return request({
		url: '/admin/dept/getListsIdName',
		method: 'post',
		data: params,
	});
}
  
//获取部门详情
export function getinfo(id: String) {
	return request({
		url: '/admin/dept/getinfo',
		method: 'post',
		data: { id },
	});
}
  
//保存部门
export function save(params: object) {
	return request({
		url: '/admin/dept/save',
		method: 'post',
		data: params,
	});
}

//删除部门
export function del(id: String) {
	return request({
		url: '/admin/dept/del',
		method: 'post',
		data: { id },
	});
}
//改变字段值
export function change(id:any, field:any, value:any) {
	const data = {
		val: id,
		field: field,
		value: value
	}
	return request({
		url: '/admin/dept/change',
		method: 'post',
		data
	})
}
  