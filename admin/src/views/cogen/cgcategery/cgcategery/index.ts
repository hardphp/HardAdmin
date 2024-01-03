import request from '/@/utils/request';


//获取分页列表
export function getList(params: object) {
	return request({
		url: '/admin/cogencgcategery/index',
		method: 'post',
		data: params,
	});
}

//获取全部菜单列表
export function getListAll(params: any) {
	return request({
		url: '/admin/cogencgcategery/getlists',
		method: 'post',
		data: params,
	});
}


//获取全部列表
export function getListsIdName(params: any) {
	return request({
		url: '/admin/cogencgcategery/getListsIdName',
		method: 'post',
		data: params,
	});
}

//获取详情
export function getinfo(id: String) {
	return request({
		url: '/admin/cogencgcategery/getinfo',
		method: 'post',
		data: { id },
	});
}

//保存
export function modify(params: object) {
	return request({
		url: '/admin/cogencgcategery/modify',
		method: 'post',
		data: params,
	});
}  
//保存
export function save(params: object) {
	return request({
		url: '/admin/cogencgcategery/save',
		method: 'post',
		data: params,
	});
}

//删除
export function del(id: String) {
	return request({
		url: '/admin/cogencgcategery/del',
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
		url: '/admin/cogencgcategery/change',
		method: 'post',
		data
	})
}
  