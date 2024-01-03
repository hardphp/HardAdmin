import request from '/@/utils/request';


//获取分页列表
export function getList(params: object) {
	return request({
		url: '/admin/groups/index',
		method: 'post',
		data: params,
	});
}

//获取全部列表
export function getListAll() {
	return request({
		url: '/admin/groups/getlists',
		method: 'post',
	});
}

//获取全部列表
export function getListsIdName(params: any) {
	return request({
		url: '/admin/groups/getListsIdName',
		method: 'post',
		data: params,
	});
}
  
//获取详情
export function getinfo(id: String) {
	return request({
		url: '/admin/groups/getinfo',
		method: 'post',
		data: { id },
	});
}
  
//保存
export function save(params: object) {
	return request({
		url: '/admin/groups/save',
		method: 'post',
		data: params,
	});
}

//删除
export function del(id: String) {
	return request({
		url: '/admin/groups/del',
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
		url: '/admin/groups/change',
		method: 'post',
		data
	})
}
  