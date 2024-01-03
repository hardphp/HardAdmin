import request from '/@/utils/request';


//获取分页列表
export function getList(params: object) {
	return request({
		url: '/admin/cogencgarticle/index',
		method: 'post',
		data: params,
	});
}

//获取全部菜单列表
export function getListAll(params: any) {
	return request({
		url: '/admin/cogencgarticle/getlists',
		method: 'post',
		data: params,
	});
}


//获取全部列表
export function getListsIdName(params: any) {
	return request({
		url: '/admin/cogencgarticle/getListsIdName',
		method: 'post',
		data: params,
	});
}

//获取详情
export function getinfo(id: String) {
	return request({
		url: '/admin/cogencgarticle/getinfo',
		method: 'post',
		data: { id },
	});
}

//保存
export function modify(params: object) {
	return request({
		url: '/admin/cogencgarticle/modify',
		method: 'post',
		data: params,
	});
}  
//保存
export function save(params: object) {
	return request({
		url: '/admin/cogencgarticle/save',
		method: 'post',
		data: params,
	});
}

//删除
export function del(id: String) {
	return request({
		url: '/admin/cogencgarticle/del',
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
		url: '/admin/cogencgarticle/change',
		method: 'post',
		data
	})
}
  