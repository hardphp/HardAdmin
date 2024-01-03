<template>
	<el-form size="large" class="login-content-form" ref="loginFormRef" :model="loginForm" :rules="loginRules">
		<el-form-item class="login-animation1" prop="username">
			<el-input text :placeholder="$t('message.account.accountPlaceholder1')" v-model="loginForm.username" clearable autocomplete="off">
				<template #prefix>
					<el-icon class="el-input__icon"><ele-User /></el-icon>
				</template>
			</el-input>
		</el-form-item>
		<el-form-item class="login-animation2" prop="password">
			<el-input
				:type="isShowPassword ? 'text' : 'password'"
				:placeholder="$t('message.account.accountPlaceholder2')"
				v-model="loginForm.password"
				autocomplete="off"
			>
				<template #prefix>
					<el-icon class="el-input__icon"><ele-Unlock /></el-icon>
				</template>
				<template #suffix>
					<i
						class="iconfont el-input__icon login-content-password"
						:class="isShowPassword ? 'icon-yincangmima' : 'icon-xianshimima'"
						@click="isShowPassword = !isShowPassword"
					>
					</i>
				</template>
			</el-input>
		</el-form-item>
		<el-form-item class="login-animation3" prop="code">
			<el-col :span="15">
				<el-input
					text
					maxlength="4"
					:placeholder="$t('message.account.accountPlaceholder3')"
					v-model="loginForm.code"
					clearable
					autocomplete="off"
				>
					<template #prefix>
						<el-icon class="el-input__icon"><ele-Position /></el-icon>
					</template>
				</el-input>
			</el-col>
			<el-col :span="1"></el-col>
			<el-col :span="8">
				<el-button class="login-content-code" v-waves>
					<img @click="onUpdatecode" :src="loginForm.img"/>
				</el-button>
			</el-col>
		</el-form-item>
		<el-form-item class="login-animation4">
			<el-button type="primary" class="login-content-submit" round v-waves @click="onSignIn" :loading="loading.signIn">
				<span>{{ $t('message.account.accountBtnText') }}</span>
			</el-button>
		</el-form-item>
	</el-form>
</template>

<script setup lang="ts" name="loginAccount">
import { reactive, computed ,onMounted,ref} from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { ElMessage } from 'element-plus';
import { useI18n } from 'vue-i18n';
import Cookies from 'js-cookie';
import { initBackEndControlRoutes } from '/@/router/backEnd';
import { Session } from '/@/utils/storage';
import { formatAxis } from '/@/utils/formatTime';
import { NextLoading } from '/@/utils/loading';
import { login ,captcha} from '/@/api/login';
import { letterAvatar } from '/@/utils';
import { storeToRefs } from 'pinia';
import { useThemeConfig } from '/@/stores/themeConfig';
import md5 from 'js-md5'
import { Local } from '/@/utils/storage';
// 定义变量内容
const { t } = useI18n();
const route = useRoute();
const router = useRouter();
const storesThemeConfig = useThemeConfig();
const { themeConfig } = storeToRefs(storesThemeConfig);

const loginFormRef = ref();
const loginForm = reactive({
	username: '',
	password: '',
	code: '',
	key: '',
	img:'',
});

const loginRules = reactive({
	username: [
		{ required: true, message:  t('message.account.accountPlaceholder1'), trigger: 'blur' }
	],
	password: [
		{ required: true, message:  t('message.account.accountPlaceholder2'), trigger: 'blur' }
	],
	code: [
		{ required: true, message:  t('message.account.accountPlaceholder3'), trigger: 'blur' }
	]
})

const isShowPassword = ref(false)

const loading = reactive({
	signIn: false,
})

// 时间获取
const currentTime = computed(() => {
	return formatAxis(new Date());
});

//刷新验证码
const onUpdatecode = async () =>{
	captcha().then(async res=>{
		loginForm.img = res.data.img
        loginForm.key = res.data.key
	})
};

// 页面加载时
onMounted(() => {
	onUpdatecode();
});

// 登录
const onSignIn = async () => {

	loginFormRef.value.validate((valid: any) => {
		if (valid) {
			login({
				username:loginForm.username,
				password:loginForm.password,
				key:loginForm.key,
				code:loginForm.code
			}).then(async res=>{
				
				loading.signIn = true;
				// 用户信息数据
				const userInfos = {
					username: loginForm.username,
					photo: res.data.img || letterAvatar(res.data.username),
					time: new Date().getTime(),
					auths:  res.data.auths,
					authBtnList: res.data.auths,
					gid:res.data.gid,
				};
				// 存储 token 到浏览器缓存
				Session.set('token', res.data.user_token);
				// 存储用户信息到浏览器缓存
				Local.set('userInfo', JSON.stringify(userInfos));
				Cookies.set('username', loginForm.username);
				Cookies.set('lock', md5(loginForm.password));

				//设置当前用户水印
				themeConfig.value.wartermarkText = loginForm.username;

				// 添加完动态路由，再进行 router 跳转，否则可能报错 No match found for location with path "/"
				await initBackEndControlRoutes();

				// 执行完 initBackEndControlRoutes，再执行 signInSuccess
				signInSuccess();
			}).catch(() => {
				onUpdatecode();
            })
		}
	})	

};
 // 登录成功后的跳转
const signInSuccess = () => {
	// 初始化登录成功时间问候语
	let currentTimeInfo = currentTime.value;
	// 登录成功，跳到转首页
	// 如果是复制粘贴的路径，非首页/登录页，那么登录成功后重定向到对应的路径中
	if (route.query?.redirect) {
		router.push({
			path: <string>route.query?.redirect,
			query: Object.keys(<string>route.query?.params).length > 0 ? JSON.parse(<string>route.query?.params) : '',
		});
	} else {
		router.push('/');
	}
	// 登录成功提示
	// 关闭 loading
    loading.signIn = true;
	const signInText = t('message.signInText');
	ElMessage.success(`${currentTimeInfo}，${signInText}`);
	// 添加 loading，防止第一次进入界面时出现短暂空白
	NextLoading.start();
};

</script>

<style scoped lang="scss">
.login-content-form {
	margin-top: 20px;
	@for $i from 1 through 4 {
		.login-animation#{$i} {
			opacity: 0;
			animation-name: error-num;
			animation-duration: 0.5s;
			animation-fill-mode: forwards;
			animation-delay: calc($i/10) + s;
		}
	}
	.login-content-password {
		display: inline-block;
		width: 20px;
		cursor: pointer;
		&:hover {
			color: #909399;
		}
	}
	.login-content-code {
		width: 100%;
		padding: 0;
		font-weight: bold;
		letter-spacing: 5px;
		img{
			width: 100%;
			height: 100%;
		}
	}
	.login-content-submit {
		width: 100%;
		letter-spacing: 2px;
		font-weight: 300;
		margin-top: 15px;
	}
}
</style>
