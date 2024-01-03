
# 安装依赖
npm install

# 运行项目
npm run dev

# 打包发布
npm run build


# 目录结构
```
├── admin
	├── public
	├── src 
	│	├── api (接口定义)
	│	├── assets (静态资源)
	│	├── components (存放公用全局组件)
	│	├── layout (存放框架布局视图)
	│	├── router (存放路由信息)
	│	├── stores (存放组件的状态 pinia)
	│	├── theme (存放框架样式)
	│	├── types (ts 类型定义文件)
	│	├── utils (存放工具类函数)
	│	└── views (存放页面视图)
	│
	├── .env (全局默认配置文件)
	├── .eslintignore (eslint忽略配置)
	├── .eslintrc.js (eslint配置)
	├── .gitignore (git提交忽略配置)
	├── .prettierrc.js (prettier代码格式化配置)
	├── CHANGELOG.md (框架更新日志)
	├── index.html (用户页面访问入口)
	├── LICENSE (开源许可证)
	├── package-lock.json (npm锁定安装时的包的版本号)
	├── package.json (包的依赖管理配置文件)
	├── README.md (框架介绍文件)
	├── tsconfig.json (ts配置文件)
	└── vite.config.ts (vite配置文件)
    ```