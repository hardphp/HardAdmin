import request from '/@/utils/request';


//获取分页列表
export function getList(params: object) {
	return request({
		url: '/admin/cogen/index',
		method: 'post',
		data: params,
	});
}


//获取详情
export function getinfo(id: String) {
	return request({
		url: '/admin/cogen/getinfo',
		method: 'post',
		data: { id },
	});
}


//保存
export function save(params: object) {
	return request({
		url: '/admin/cogen/save',
		method: 'post',
		data: params,
	});
}

//删除
export function del(id: String) {
	return request({
		url: '/admin/cogen/del',
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
		url: '/admin/cogen/change',
		method: 'post',
		data
	})
}

//获取数据表
export function gettables() {
	return request({
		url: '/admin/cogen/gettables',
		method: 'post',
	});
}


//获取数据表字段
export function gettablechild(table: String) {
	return request({
		url: '/admin/cogen/gettablechild',
		method: 'post',
		data: { table },
	});
}

//获取数据表字段
export function gettablefields(table: String) {
	return request({
		url: '/admin/cogen/gettablefields',
		method: 'post',
		data: { table },
	});
}

//获取分页列表
export function getFieldRule(table: String) {
	return request({
		url: '/admin/cogen/getfieldrule',
		method: 'post',
		data: { table },
	});
}
  
//获取代码
export function getcode(table: String) {
	return request({
		url: '/admin/cogen/getcode',
		method: 'post',
		data: { table },
	});
}

//生成代码
export function tocode(id: String) {
	return request({
		url: '/admin/cogen/tocode',
		method: 'post',
		data: { id },
	});
}

//获取代码
export function getcodezip(table: String) {
	return request({
		url: '/admin/cogen/getcodezip',
		method: 'post',
		data: { table },
	});
}