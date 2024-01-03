import axios from 'axios';
import { ElMessage, ElMessageBox } from 'element-plus';
import { Session } from '/@/utils/storage';
import { getSignature } from '/@/utils';

// 配置新建一个 axios 实例
const service = axios.create({
	baseURL: import.meta.env.VITE_API_URL,
	timeout: 50000,
	headers: { 'Content-Type': 'application/json' },
});

// 添加请求拦截器
service.interceptors.request.use(
	(config) => {
		// 在发送请求之前做些什么 token
		config.headers['x-access-appid'] = 'admin'
		if (Session.get('token')) {
			config.headers!['x-access-token'] = `${Session.get('token')}`;
		}
		// signature
		if (config.method === 'post') {
			config.data = getSignature(config.data)
		} else if (config.method === 'get') {
			config.params = getSignature(config.params)
		}
		return config;
	},
	(error) => {
		// 对请求错误做些什么
		return Promise.reject(error);
	}
);

// 添加响应拦截器
service.interceptors.response.use(
	(response) => {
		// 对响应数据做点什么
		const res = response.data;
		// 业务逻辑错误
		if (res.status !== 1) {
			// token 过期了
			if (res.code === 11102 || res.code === 11103) {
				// to re-login
				Session.clear(); // 清除浏览器全部临时缓存
				window.location.href = '/'; // 去登录页
				ElMessageBox.alert('你已被登出，请重新登录', '提示', {})
					.then(() => {})
					.catch(() => {});
			} else if(res.msg){
				ElMessage.error(res.msg)
			}
			return Promise.reject(service.interceptors.response);
		} else {
			return response.data;
		}
	},
	(error) => {
		// 对响应错误做点什么
		if (error.message.indexOf('timeout') != -1) {
			ElMessage.error('网络超时');
		} else if (error.message == 'Network Error') {
			ElMessage.error('网络连接错误');
		} else {
			if (error) {
				console.log(error.response)
				//ElMessage.error(error.response.msg);
			}else{
				ElMessage.error('接口路径找不到');
			}
		}
		return Promise.reject(error);
	}
);

// 导出 axios 实例
export default service;
