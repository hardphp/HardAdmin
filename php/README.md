
## 程序开发说明，程序分三个层级，下层为上层服务，禁止跨层和平层调用
1、创建model文件
    关联数据表

2、创建service文件

这层 主要逻辑层，如果service 中的一个方法涉及的逻辑太多，就进行拆分多个小逻辑，在controller 进行 整合调用。在service  ，也可以使用model , 关联查询建议使用DB join 方便

3、创建controller 文件

参数接收判断， 整合调用多个service

## 错误码使用
错误定义在config/error.php 中，禁止代码直接使用错误信息

## 目录使用说明
```
php
├─app
│  ├─admin 后台应用
│  │  ├─controller    控制器
│  │  ├─middleware  中间件   
│  │  ├─route   路由  
│  ├─api 前端用户应用
│  │  ├─controller  控制器
│  │  ├─middleware 中间件
│  │  └─route  路由  
│  ├─cron 应用
│  │  └─controller  控制器 
│  ├─validate 验证器
│  ├─listener  
│  ├─middleware 全局中间件
│  ├─model 模型
│  ├─service 服务
│  ├─subscribe
│  ├─traits 公共封装
│  └─util 工具类
├─config 配置文件
├─extend 扩展
├─public
│  │  index.php 入口文件
│  └─backend 后台入口
├─route 路由
├─runtime 日志
├─vendor 依赖包
└─view
│  └─cogen 代码模板
```


