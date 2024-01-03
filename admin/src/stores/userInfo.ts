import { defineStore } from 'pinia';
import { Session } from '/@/utils/storage';
import Cookies from 'js-cookie';
import { Local } from '/@/utils/storage';
/**
 * 用户信息
 * @methods setUserInfos 设置用户信息
 */
export const useUserInfo = defineStore('userInfo', {
	state: (): UserInfosState => ({
		userInfos: {
			username: '',
			photo: '',
			time: 0,
			auths: [],
			authBtnList: [],
			gid:0,
		},
	}),
	actions: {
		async setUserInfos() {
			// 存储用户信息到浏览器缓存
			if (Local.get('userInfo')) {
				this.userInfos = JSON.parse(Local.get('userInfo'));
			}
		}
	},
});
