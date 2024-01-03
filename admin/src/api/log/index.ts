import request from '/@/utils/request';


//获取分页列表
export function getList(params: object) {
	return request({
		url: '/admin/log/index',
		method: 'post',
		data: params,
	});
}