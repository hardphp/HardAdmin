import request from '/@/utils/request';


//获取分页列表
export function getList(params: object) {
	return request({
		url: '/admin/app/index',
		method: 'post',
		data: params,
	});
}


//获取详情
export function getinfo(id: String) {
	return request({
		url: '/admin/app/getinfo',
		method: 'post',
		data: { id },
	});
}


//保存
export function save(params: object) {
	return request({
		url: '/admin/app/save',
		method: 'post',
		data: params,
	});
}

//删除
export function del(id: String) {
	return request({
		url: '/admin/app/del',
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
		url: '/admin/app/change',
		method: 'post',
		data
	})
}
  