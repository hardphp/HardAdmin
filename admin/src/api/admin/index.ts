import request from '/@/utils/request';


//获取分页列表
export function getList(params: object) {
	return request({
		url: '/admin/admin/index',
		method: 'post',
		data: params,
	});
}

//获取全部菜单列表
export function getListAll(params: any) {
	return request({
		url: '/admin/admin/getlists',
		method: 'post',
		data: params,
	});
}


//获取全部列表
export function getListsIdName(params: any) {
	return request({
		url: '/admin/admin/getListsIdName',
		method: 'post',
		data: params,
	});
}

//获取详情
export function getinfo(id: String) {
	return request({
		url: '/admin/admin/getinfo',
		method: 'post',
		data: { id },
	});
}

//获取详情
export function getnowuser() {
	return request({
		url: '/admin/admin/getnowuser',
		method: 'post',
	});
}
//保存
export function modify(params: object) {
	return request({
		url: '/admin/admin/modify',
		method: 'post',
		data: params,
	});
}  
//保存
export function save(params: object) {
	return request({
		url: '/admin/admin/save',
		method: 'post',
		data: params,
	});
}

//删除
export function del(id: String) {
	return request({
		url: '/admin/admin/del',
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
		url: '/admin/admin/change',
		method: 'post',
		data
	})
}
  