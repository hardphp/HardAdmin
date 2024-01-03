import request from '/@/utils/request';

/**
 * 后端控制菜单
 * 后端控制路由
 * @method getMenuAdmin 获取后端动态路由菜单
 */
export function useMenuApi() {
	return {
		getAdminMenu: (params?: object) => {
			return request({
				url: '/admin/admin/getusermenu',
				method: 'post',
				params,
			});
		}
	};
}

//获取分页菜单列表
export function getList(params: object) {
	return request({
		url: '/admin/rules/index',
		method: 'post',
		data: params,
	});
}

//获取全部菜单列表
export function getListAll(params: any) {
	return request({
		url: '/admin/rules/getlists',
		method: 'post',
		data: params,
	});
}
  
//获取菜单详情
export function getinfo(id: String) {
	return request({
		url: '/admin/rules/getinfo',
		method: 'post',
		data: { id },
	});
}
  
//保存菜单
export function save(params: object) {
	return request({
		url: '/admin/rules/save',
		method: 'post',
		data: params,
	});
}

//删除菜单
export function del(id: String) {
	return request({
		url: '/admin/rules/del',
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
		url: '/admin/rules/change',
		method: 'post',
		data
	})
}
  