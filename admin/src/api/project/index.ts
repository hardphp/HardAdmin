import request from '/@/utils/request';

//获取统计数据
export function getmydata() {
	return request({
		url: '/admin/statistics/index',
		method: 'post',
	});
}
