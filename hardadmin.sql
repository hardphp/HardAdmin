/*
Navicat MySQL Data Transfer

Source Server         : test_hardphp_com
Source Server Version : 50741
Source Host           : 121.43.42.232:3306
Source Database       : test_hardphp_com

Target Server Type    : MYSQL
Target Server Version : 50741
File Encoding         : 65001

Date: 2024-01-02 17:40:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tp_admin
-- ----------------------------
DROP TABLE IF EXISTS `tp_admin`;
CREATE TABLE `tp_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `realname` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `phone` char(15) NOT NULL DEFAULT '' COMMENT '用户手机',
  `salary` int(10) DEFAULT '0' COMMENT '工资',
  `img` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `reg_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '注册IP',
  `login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `login_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态  0 禁用，1正常',
  `dept_id` int(10) NOT NULL DEFAULT '0' COMMENT '部门id',
  `group_id` int(10) NOT NULL DEFAULT '0' COMMENT '权限组',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='管理员用户表';

-- ----------------------------
-- Records of tp_admin
-- ----------------------------
INSERT INTO `tp_admin` VALUES ('1', 'admin', 'd93a5def7511da3d0f2d171d9c344e91', 'test@163.com', '超级管理员', '', '0', '', '127.0.0.1', '1704188358', '180.169.254.2', '1', '1', '1', '1540975213', '1704188358');
INSERT INTO `tp_admin` VALUES ('14', 'test', 'd93a5def7511da3d0f2d171d9c344e91', '', '', '', '0', '', '223.88.45.176', '1703792286', '223.104.68.248', '1', '2', '2', '1703050504', '1703792286');

-- ----------------------------
-- Table structure for tp_app
-- ----------------------------
DROP TABLE IF EXISTS `tp_app`;
CREATE TABLE `tp_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `title` varchar(150) NOT NULL DEFAULT '' COMMENT '名称',
  `appid` char(18) NOT NULL DEFAULT '' COMMENT '应用id',
  `app_salt` char(32) NOT NULL DEFAULT '' COMMENT '应用签名盐值',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户状态  0 禁用，1正常',
  `is_sign` tinyint(1) DEFAULT '1' COMMENT '1开始签名验证，0关闭',
  `sign_white_url` text COMMENT '控制器免签白名单',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `appid` (`appid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='app应用表';

-- ----------------------------
-- Records of tp_app
-- ----------------------------
INSERT INTO `tp_app` VALUES ('1', '管理员端', 'admin', '21232f297a57a5a743894a0e4a801fc', '1', '1', '[\"admin\\/upload\\/upimg\",\"admin\\/upload\\/upimgs\",\"admin\\/upload\\/upvedio\",\"admin\\/upload\\/upfile\"]', '1514962598', '1692699784');
INSERT INTO `tp_app` VALUES ('2', 'PC端', 'pc', '855a3b1b5f04a16bb093201a1e8c491', '1', '1', '', '1514962598', '1685197030');
INSERT INTO `tp_app` VALUES ('4', 'app端', 'app', 'fdb5023d58fdbb5299ce9d722312197', '1', '0', '', '1685197049', '1692773769');

-- ----------------------------
-- Table structure for tp_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `tp_auth_group`;
CREATE TABLE `tp_auth_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) DEFAULT '' COMMENT '用户组中文名称',
  `status` tinyint(1) DEFAULT '1' COMMENT '为1正常，为0禁用',
  `depts` text COMMENT '部门id， 多个规则","隔开',
  `rules` text COMMENT '用户组拥有的规则id， 多个规则","隔开',
  `update_time` int(10) unsigned DEFAULT '0' COMMENT '更新时间',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '创建时间',
  `types` tinyint(1) DEFAULT '0' COMMENT '权限类型 1=全部权限，2=本部们权限，3=本部门以及下属权限，4=本人权限，5=自定义权限',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='用户组表';

-- ----------------------------
-- Records of tp_auth_group
-- ----------------------------
INSERT INTO `tp_auth_group` VALUES ('1', '超级管理员组', '1', '', '1,2,3,4,5,54,64,65,6,17,18,19,7,21,22,23,66,274,315,316,317,76,77,78,79,80,91,101,102,111,112,113,114,93,95,98,99,100,117,309,310,311,312,313,314,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,336,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385', '1704121844', '1544881719', '1');
INSERT INTO `tp_auth_group` VALUES ('2', '运营管理组', '1', '', '1,2,3,4,64,65,17,7,21,66,274,76,77,78,91,101,102,111,112,113,114,93,95,98,99,100,117,313,314', '1703825737', '1649757461', '1');

-- ----------------------------
-- Table structure for tp_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `tp_auth_rule`;
CREATE TABLE `tp_auth_rule` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL COMMENT '菜单名称',
  `title` varchar(64) DEFAULT NULL COMMENT '副标题',
  `parent_id` int(11) DEFAULT '0' COMMENT '上级id',
  `sorts` int(4) DEFAULT '100' COMMENT '正序排序',
  `icon` varchar(128) DEFAULT NULL COMMENT '图标',
  `path` varchar(128) DEFAULT NULL COMMENT '路由路径',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `is_iframe` tinyint(1) DEFAULT NULL,
  `is_link` tinyint(1) DEFAULT '0',
  `menu_type` varchar(20) DEFAULT NULL COMMENT '菜单类型：menu , btn',
  `is_hide` tinyint(1) DEFAULT NULL,
  `is_keep_alive` tinyint(1) DEFAULT NULL,
  `is_affix` tinyint(1) DEFAULT NULL,
  `permission` varchar(200) DEFAULT NULL,
  `status` tinyint(191) DEFAULT '1' COMMENT '0=禁用，1=正常',
  `remark` varchar(191) DEFAULT NULL,
  `create_time` int(10) DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=386 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='菜单规则表';

-- ----------------------------
-- Records of tp_auth_rule
-- ----------------------------
INSERT INTO `tp_auth_rule` VALUES ('1', '首页', '', '0', '1', 'iconfont icon-yunxiazai_o', '/home', '/home/index', '0', '0', 'menu', '0', '1', '1', 'admin:project:getmydata', '1', '', '2147483647', '1685676174');
INSERT INTO `tp_auth_rule` VALUES ('2', '系统设置', '', '0', '1', 'iconfont icon-xitongshezhi', '/system', '/layout/routerView/parent', '0', '0', 'menu', '0', '1', '0', '', '1', '', '2147483647', '2147483647');
INSERT INTO `tp_auth_rule` VALUES ('3', '用户管理', '', '2', '1', 'ele-User', '/system/user', '/system/user/index', '0', '0', 'menu', '0', '1', '0', 'admin:admin:index', '1', '', '2147483647', '1681451395');
INSERT INTO `tp_auth_rule` VALUES ('4', '查看用户详情', '', '3', '1', '', '', '', '0', '0', 'btn', '0', '0', '0', 'admin:admin:getinfo', '1', '', '2147483647', '1681451637');
INSERT INTO `tp_auth_rule` VALUES ('5', '新增/修改用户', '', '3', '1', '', '', '', '0', '0', 'btn', '0', '0', '0', 'admin:admin:save', '1', '', '2147483647', '1681452949');
INSERT INTO `tp_auth_rule` VALUES ('6', '角色管理', '', '2', '1', 'ele-UserFilled', '/system/role', '/system/role/index', '0', '0', 'menu', '0', '1', '0', 'admin:groups:index', '1', '', '2147483647', '1681451878');
INSERT INTO `tp_auth_rule` VALUES ('7', '菜单管理', '', '2', '2', 'iconfont icon-juxingkaobei', '/system/menu', '/system/menu/index', '0', '0', 'menu', '0', '1', '0', 'admin:rules:index', '1', '', '2147483647', '1681451975');
INSERT INTO `tp_auth_rule` VALUES ('17', '查看角色详情', '', '6', '1', '', '', '', '0', '0', 'btn', '0', '0', '0', 'admin:groups:getinfo', '1', '', '2147483647', '1681451860');
INSERT INTO `tp_auth_rule` VALUES ('18', '删除角色', '', '6', '1', '', '', '', '0', '0', 'btn', '0', '0', '0', 'admin:groups:del', '1', '', '2147483647', '1681451906');
INSERT INTO `tp_auth_rule` VALUES ('19', '新增/修改角色', '', '6', '1', '', '', '', '0', '0', 'btn', '0', '0', '0', 'admin:groups:save', '1', '', '2147483647', '1681451936');
INSERT INTO `tp_auth_rule` VALUES ('95', '用户列表', null, '93', '100', 'iconfont icon-bolangneng', '/user/lists', '/user/lists/index', '0', '0', 'menu', '0', '1', '0', '模块:控制器:方法', '1', null, '1685677890', '1685677890');
INSERT INTO `tp_auth_rule` VALUES ('21', '查看菜单详情', '', '7', '1', '', '', '', '0', '0', 'btn', '0', '0', '0', 'admin:rules:getinfo', '1', '', '2147483647', '1681452017');
INSERT INTO `tp_auth_rule` VALUES ('22', '新增/修改菜单', '', '7', '1', '', '', '', '0', '0', 'btn', '0', '0', '0', 'admin:rules:save', '1', '', '2147483647', '1681452050');
INSERT INTO `tp_auth_rule` VALUES ('23', '删除菜单', '', '7', '1', '', '', '', '0', '0', 'btn', '0', '0', '0', 'admin:rules:del', '1', '', '2147483647', '1681452072');
INSERT INTO `tp_auth_rule` VALUES ('76', '工具管理', null, '0', '100', 'iconfont icon-caidan', '/tool', 'layout/routerView/parent', '0', '0', 'menu', '0', '1', '0', '', '1', null, '1685191165', '1685193701');
INSERT INTO `tp_auth_rule` VALUES ('77', '密钥管理', null, '76', '100', 'iconfont icon-diqiu1', '/tool/app', '/tool/app/index', '0', '0', 'menu', '0', '1', '0', 'admin:app:index', '1', null, '1685193754', '1685193754');
INSERT INTO `tp_auth_rule` VALUES ('78', '查看密钥详情', null, '77', '100', 'iconfont icon-huanjingxingqiu', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:app:getinfo', '1', null, '1685193850', '1685193850');
INSERT INTO `tp_auth_rule` VALUES ('79', '删除密钥', null, '77', '100', 'iconfont icon-zhongyingwenqiehuan', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:app:del', '1', null, '1685193904', '1685193904');
INSERT INTO `tp_auth_rule` VALUES ('80', '新增/修改密钥', null, '77', '100', 'iconfont icon-ico', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:app:save', '1', null, '1685193964', '1685193964');
INSERT INTO `tp_auth_rule` VALUES ('315', '新增/编辑部门', null, '274', '100', '', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:dept:save', '1', null, '1703826047', '1703826047');
INSERT INTO `tp_auth_rule` VALUES ('316', '部门详情', null, '274', '100', '', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:dept:getinfo', '1', null, '1703826083', '1703826083');
INSERT INTO `tp_auth_rule` VALUES ('317', '删除部门', null, '274', '100', '', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:dept:del', '1', null, '1703826097', '1703826122');
INSERT INTO `tp_auth_rule` VALUES ('54', '删除用户', null, '3', '100', '', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:admin:del', '1', null, '1681451722', '1681451764');
INSERT INTO `tp_auth_rule` VALUES ('370', '文章分类管理', 'CgCategery', '117', '100', 'iconfont icon-zhongduancanshu', '/cogen/cgcategery', '/cogen/cgcategery/index', '0', '0', 'menu', '0', '1', '0', 'admin:cogencgcategery:index', '1', null, '1704120058', null);
INSERT INTO `tp_auth_rule` VALUES ('371', '查看文章分类详情', 'CgCategery', '370', '100', 'iconfont icon-zhongduancanshu', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:cogencgcategery:getinfo', '1', null, '1704120058', null);
INSERT INTO `tp_auth_rule` VALUES ('380', '新增/修改文章栏目', 'CgColumn', '378', '100', 'iconfont icon-zhongduancanshu', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:cogencgcolumn:save', '1', null, '1704121438', null);
INSERT INTO `tp_auth_rule` VALUES ('381', '删除文章栏目', 'CgColumn', '378', '100', 'iconfont icon-zhongduancanshu', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:cogencgcolumn:del', '1', null, '1704121438', null);
INSERT INTO `tp_auth_rule` VALUES ('378', '文章栏目管理', 'CgColumn', '117', '100', 'iconfont icon-zhongduancanshu', '/cogen/cgcolumn', '/cogen/cgcolumn/index', '0', '0', 'menu', '0', '1', '0', 'admin:cogencgcolumn:index', '1', null, '1704121438', null);
INSERT INTO `tp_auth_rule` VALUES ('379', '查看文章栏目详情', 'CgColumn', '378', '100', 'iconfont icon-zhongduancanshu', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:cogencgcolumn:getinfo', '1', null, '1704121438', null);
INSERT INTO `tp_auth_rule` VALUES ('64', '修改个人资料', null, '3', '100', '', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:admin:modify', '1', null, '1681453063', '1681453073');
INSERT INTO `tp_auth_rule` VALUES ('65', '用户登录', null, '3', '100', '', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:login:index', '1', null, '1681453110', '1681453110');
INSERT INTO `tp_auth_rule` VALUES ('66', '操作日志', null, '2', '100', 'iconfont icon--chaifenlie', '/system/log', '/system/log/index', '0', '0', 'menu', '0', '1', '0', 'admin:log:index', '1', null, '1681461986', '1681461986');
INSERT INTO `tp_auth_rule` VALUES ('91', '配置管理', null, '76', '100', 'iconfont icon-wenducanshu-05', '/tool/config', '/tool/config/index', '0', '0', 'menu', '0', '1', '0', '模块:控制器:方法', '1', null, '1685677479', '1685677753');
INSERT INTO `tp_auth_rule` VALUES ('93', '用户管理', null, '0', '100', 'iconfont icon-gerenzhongxin', '/user', 'layout/routerView/parent', '0', '0', 'menu', '0', '1', '0', '', '1', null, '1685677660', '1685677660');
INSERT INTO `tp_auth_rule` VALUES ('98', '新增/修改用户', null, '95', '100', 'iconfont icon-AIshiyanshi', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:user:save', '1', null, '1685773869', '1685773869');
INSERT INTO `tp_auth_rule` VALUES ('99', '查看用户详情', null, '95', '100', 'iconfont icon-xianshimima', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:user:getinfo', '1', null, '1685773917', '1685773917');
INSERT INTO `tp_auth_rule` VALUES ('100', '删除用户', null, '95', '100', 'iconfont icon-xianshimima', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:user:del', '1', null, '1685773940', '1685773940');
INSERT INTO `tp_auth_rule` VALUES ('101', '查看详情', null, '91', '100', 'iconfont icon-wenducanshu-05', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:system:getinfo', '1', null, '1686191258', '1686191258');
INSERT INTO `tp_auth_rule` VALUES ('102', '新增/修改配置', null, '91', '100', 'iconfont icon-zhongduancanshu', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:system:save', '1', null, '1686191310', '1686191310');
INSERT INTO `tp_auth_rule` VALUES ('373', '删除文章分类', 'CgCategery', '370', '100', 'iconfont icon-zhongduancanshu', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:cogencgcategery:del', '1', null, '1704120058', null);
INSERT INTO `tp_auth_rule` VALUES ('111', '代码生成', '', '76', '100', 'iconfont icon-diqiu1', '/tool/cogen', '/tool/cogen/index', '0', '0', 'menu', '0', '1', '0', 'admin:cogen:index', '1', '', '1685193754', '1685193754');
INSERT INTO `tp_auth_rule` VALUES ('112', '查看详情', '', '111', '100', 'iconfont icon-huanjingxingqiu', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:cogen:getinfo', '1', '', '1685193850', '1685193850');
INSERT INTO `tp_auth_rule` VALUES ('113', '删除', '', '111', '100', 'iconfont icon-zhongyingwenqiehuan', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:cogen:del', '1', '', '1685193904', '1685193904');
INSERT INTO `tp_auth_rule` VALUES ('114', '新增/修改', '', '111', '100', 'iconfont icon-ico', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:cogen:save', '1', '', '1685193964', '1685193964');
INSERT INTO `tp_auth_rule` VALUES ('117', '应用管理', null, '0', '100', 'iconfont icon-dongtai', '/cogen', 'layout/routerView/parent', '0', '0', 'menu', '0', '1', '0', '', '1', null, '1692602037', '1692602057');
INSERT INTO `tp_auth_rule` VALUES ('274', '部门管理', '', '2', '100', 'iconfont icon-zhongduancanshu', '/system/dept', '/system/dept/index', '0', '0', 'menu', '0', '1', '0', 'admin:dept:index', '1', null, '1692777560', '1703046664');
INSERT INTO `tp_auth_rule` VALUES ('314', '接口文档', null, '0', '100', 'iconfont icon-putong', '', 'layout/routerView/parent', '0', '1', 'menu', '0', '1', '0', 'http://test.hardphp.com/apidoc/?urls.primaryName=%E5%89%8D%E7%AB%AF%E6%96%87%E6%A1%A3#/', '1', '/iframesOne', '1703776298', '1703824501');
INSERT INTO `tp_auth_rule` VALUES ('313', '使用文档', null, '0', '100', 'iconfont icon-shouye_dongtaihui', '', 'layout/routerView/parent', '0', '1', 'menu', '0', '1', '0', 'http://test.hardphp.com/HardAdmin/', '1', null, '1703775933', '1703824491');
INSERT INTO `tp_auth_rule` VALUES ('372', '新增/修改文章分类', 'CgCategery', '370', '100', 'iconfont icon-zhongduancanshu', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:cogencgcategery:save', '1', null, '1704120058', null);
INSERT INTO `tp_auth_rule` VALUES ('385', '删除文章管理', 'CgArticle', '382', '100', 'iconfont icon-zhongduancanshu', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:cogencgarticle:del', '1', null, '1704121844', null);
INSERT INTO `tp_auth_rule` VALUES ('384', '新增/修改文章管理', 'CgArticle', '382', '100', 'iconfont icon-zhongduancanshu', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:cogencgarticle:save', '1', null, '1704121844', null);
INSERT INTO `tp_auth_rule` VALUES ('382', '文章管理管理', 'CgArticle', '117', '100', 'iconfont icon-zhongduancanshu', '/cogen/cgarticle', '/cogen/cgarticle/index', '0', '0', 'menu', '0', '1', '0', 'admin:cogencgarticle:index', '1', null, '1704121844', null);
INSERT INTO `tp_auth_rule` VALUES ('383', '查看文章管理详情', 'CgArticle', '382', '100', 'iconfont icon-zhongduancanshu', '', '', '0', '0', 'btn', '0', '1', '0', 'admin:cogencgarticle:getinfo', '1', null, '1704121844', null);

-- ----------------------------
-- Table structure for tp_cg_article
-- ----------------------------
DROP TABLE IF EXISTS `tp_cg_article`;
CREATE TABLE `tp_cg_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `title` varchar(150) NOT NULL DEFAULT '' COMMENT '标题',
  `dept_id` int(10) NOT NULL DEFAULT '0' COMMENT '部门id',
  `userid` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `cid` int(10) NOT NULL DEFAULT '0' COMMENT '栏目id',
  `cate` text NOT NULL COMMENT '分类属性，多选 ,分割',
  `notes` varchar(255) DEFAULT '' COMMENT '描述',
  `content` text COMMENT '详情',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态  0 禁用，1正常',
  `sorts` int(3) NOT NULL DEFAULT '100' COMMENT '排序',
  `types` tinyint(2) DEFAULT '1' COMMENT '1=列表，2=单页',
  `img` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `visit_num` int(5) DEFAULT '0' COMMENT '访问量',
  `video` varchar(255) NOT NULL DEFAULT '' COMMENT '视频',
  `author` varchar(200) DEFAULT '' COMMENT '作者',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布时间',
  `start_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='文章表';

-- ----------------------------
-- Records of tp_cg_article
-- ----------------------------
INSERT INTO `tp_cg_article` VALUES ('14', '文章测试标题', '2', '1', '2', '精彩活动', ' ', '123', '1', '100', '1', '', '0', '', '', '1685585436', '0', '0', '1685585436', '1685585436');
INSERT INTO `tp_cg_article` VALUES ('1', '文章测试标题', '2', '1', '2', '', ' ', '123', '1', '100', '1', '', '0', '', '超级管理员', '1685585436', '0', '0', '1685585436', '1686206606');
INSERT INTO `tp_cg_article` VALUES ('2', '文章测试标题', '2', '1', '2', '', ' ', '123', '1', '100', '1', '', '0', '', '超级管理员', '1685585436', '0', '0', '1685585436', '1686206598');
INSERT INTO `tp_cg_article` VALUES ('3', '文章测试标题', '2', '1', '2', '', ' ', '123', '1', '100', '1', '', '0', '', '超级管理员', '1685585436', '0', '0', '1685585436', '1686206591');
INSERT INTO `tp_cg_article` VALUES ('4', '文章测试标题', '2', '1', '2', '', ' ', '123', '1', '100', '1', '', '0', '', '超级管理员', '1685585436', '0', '0', '1685585436', '1686206583');
INSERT INTO `tp_cg_article` VALUES ('5', '文章测试标题', '2', '1', '2', '', ' ', '123', '1', '100', '1', '', '0', '', '超级管理员', '1685585436', '0', '0', '1685585436', '1686206767');
INSERT INTO `tp_cg_article` VALUES ('6', '文章测试标题', '3', '1', '2', '', ' ', '123', '1', '100', '1', '', '0', '', '超级管理员', '1685585436', '0', '0', '1685585436', '1686206778');
INSERT INTO `tp_cg_article` VALUES ('7', '文章测试标题', '3', '1', '3', '', ' ', '123', '1', '100', '2', '', '0', '', '超级管理员', '1685585436', '0', '0', '1685585436', '1686206827');
INSERT INTO `tp_cg_article` VALUES ('8', '文章测试标题', '3', '1', '3', '', '', '123', '1', '100', '2', 'http://www.hardphp.com/storage/images/20230721/2cced49c8f5ef298a15ab460561d222a.png', '0', '', '超级管理员', '1685585436', '0', '0', '1685585436', '1689924526');
INSERT INTO `tp_cg_article` VALUES ('9', '文章测试标题', '3', '14', '3', '精彩活动,往期回顾', ' ', '123', '1', '100', '2', '', '0', '', '', '1685585436', '0', '0', '1685585436', '1685585436');
INSERT INTO `tp_cg_article` VALUES ('10', '文章测试标题', '3', '1', '3', '', ' ', '123', '1', '100', '2', '', '0', '', '', '1685585436', '0', '0', '1685585436', '1685585436');
INSERT INTO `tp_cg_article` VALUES ('11', '文章测试标题', '3', '1', '3', '', ' ', '123', '1', '100', '2', '', '0', '', '超级管理员', '1685585436', '0', '0', '1685585436', '1686643218');
INSERT INTO `tp_cg_article` VALUES ('12', '文章测试标题', '3', '1', '2', '', ' ', '123', '1', '100', '2', '', '0', '', '超级管理员', '1685585436', '0', '0', '1685585436', '1686644076');
INSERT INTO `tp_cg_article` VALUES ('13', '文章测试标题', '3', '1', '2', '', ' ', '123', '1', '100', '1', '', '0', '', '超级管理员', '1685585436', '0', '0', '1685585436', '1686207154');
INSERT INTO `tp_cg_article` VALUES ('15', '文章测试标题', '3', '1', '2', '往期回顾', ' ', '123', '1', '100', '1', '', '0', '', '', '1685585436', '0', '0', '1685585436', '1685585436');
INSERT INTO `tp_cg_article` VALUES ('16', '文章测试标题', '1', '1', '2', '精彩活动', ' ', '123', '1', '100', '1', '', '0', '', '', '1685585436', '0', '0', '1685585436', '1685585436');
INSERT INTO `tp_cg_article` VALUES ('17', '文章测试标题', '1', '1', '2', '精彩活动', ' ', '123', '1', '100', '1', '', '0', '', '超级管理员', '1685585436', '1686499200', '1687881600', '1685585436', '1686208284');
INSERT INTO `tp_cg_article` VALUES ('18', '文章测试标题', '1', '1', '2', '首发新课', ' ', '123', '1', '100', '1', '', '0', '', '', '1685585436', '0', '0', '1685585436', '1685585436');
INSERT INTO `tp_cg_article` VALUES ('19', '文章测试标题', '1', '1', '2', '首发新课', '', '<p>1234</p>', '1', '100', '1', '', '0', '', '超级管理员', '1685585436', '0', '0', '1685585436', '1698994385');

-- ----------------------------
-- Table structure for tp_cg_banner
-- ----------------------------
DROP TABLE IF EXISTS `tp_cg_banner`;
CREATE TABLE `tp_cg_banner` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态  0 禁用，1正常',
  `sorts` int(3) NOT NULL DEFAULT '100' COMMENT '排序',
  `types` tinyint(2) DEFAULT '1' COMMENT '位置，1=首页',
  `url` varchar(255) DEFAULT '' COMMENT '网址',
  `img` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `vedio` varchar(255) DEFAULT '' COMMENT '视频',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='banner表';

-- ----------------------------
-- Records of tp_cg_banner
-- ----------------------------
INSERT INTO `tp_cg_banner` VALUES ('1', '1', '1', '100', '1', '1', 'http://www.hardphp.com/storage/images/20230822/232133ead56d119ced2e2fbf4e17b752.jpg', '1', '<p>1</p>', '0', '1692669955');

-- ----------------------------
-- Table structure for tp_cg_categery
-- ----------------------------
DROP TABLE IF EXISTS `tp_cg_categery`;
CREATE TABLE `tp_cg_categery` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cid` int(10) NOT NULL DEFAULT '0' COMMENT '栏目id',
  `name` varchar(150) NOT NULL DEFAULT '' COMMENT '名称',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态  0 禁用，1正常',
  `sorts` int(3) NOT NULL DEFAULT '100' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='文章分类表';

-- ----------------------------
-- Records of tp_cg_categery
-- ----------------------------
INSERT INTO `tp_cg_categery` VALUES ('2', '8', '首发新课', '', '1', '100', '0', '0');
INSERT INTO `tp_cg_categery` VALUES ('3', '8', '热门推荐', '', '1', '100', '0', '0');
INSERT INTO `tp_cg_categery` VALUES ('4', '7', '精彩活动', '', '1', '100', '0', '0');
INSERT INTO `tp_cg_categery` VALUES ('5', '7', '往期回顾', '', '1', '100', '0', '0');

-- ----------------------------
-- Table structure for tp_cg_city
-- ----------------------------
DROP TABLE IF EXISTS `tp_cg_city`;
CREATE TABLE `tp_cg_city` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) NOT NULL COMMENT '名称',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否启用',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '时间',
  `sorts` int(5) DEFAULT '100' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='城市表';

-- ----------------------------
-- Records of tp_cg_city
-- ----------------------------

-- ----------------------------
-- Table structure for tp_cg_column
-- ----------------------------
DROP TABLE IF EXISTS `tp_cg_column`;
CREATE TABLE `tp_cg_column` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(150) NOT NULL DEFAULT '' COMMENT '栏目名称',
  `ename` varchar(255) DEFAULT NULL COMMENT '英文名称',
  `seo_title` varchar(150) NOT NULL DEFAULT '' COMMENT 'seo关键词',
  `seo_dec` varchar(255) NOT NULL DEFAULT '' COMMENT 'seo描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态  0 禁用，1正常',
  `sorts` int(3) NOT NULL DEFAULT '100' COMMENT '排序',
  `imgs` text COMMENT 'banner图 多张用，隔开',
  `imgs2` text COMMENT 'banner图 多张用，隔开',
  `url` varchar(255) DEFAULT NULL COMMENT '跳转地址',
  `types` tinyint(2) DEFAULT '1' COMMENT '1=列表，2=单页，3=链接',
  `pid` bigint(20) DEFAULT '0' COMMENT '上级id',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COMMENT='文章栏目表';

-- ----------------------------
-- Records of tp_cg_column
-- ----------------------------
INSERT INTO `tp_cg_column` VALUES ('1', '首页', '', '首页', '首页', '1', '1', '', '', '', '3', '0', '', '1514962598', '1686556314');
INSERT INTO `tp_cg_column` VALUES ('9', '我们', '', '', '', '1', '100', '', '', '', '2', '1', '', '1686206331', '1686557312');
INSERT INTO `tp_cg_column` VALUES ('2', '历史', '', '历史', '历史', '1', '2', '', '', '', '1', '0', '', '1579444834', '1686556296');
INSERT INTO `tp_cg_column` VALUES ('3', '123', '', '123', '123', '1', '3', '', '', '', '2', '0', '', '1579444868', '1686638220');
INSERT INTO `tp_cg_column` VALUES ('4', '456', '', '456', '456', '1', '4', '', '', '', '1', '0', '', '1579444885', '1686642452');
INSERT INTO `tp_cg_column` VALUES ('5', '789', '', '789', '789', '1', '5', '', '', '', '2', '0', '', '1579444966', '1686644302');
INSERT INTO `tp_cg_column` VALUES ('6', '147', '', '147', '147', '1', '6', '', '', '', '2', '0', '', '1579444998', '1686644649');
INSERT INTO `tp_cg_column` VALUES ('7', '活动', '', '精彩活动', '精彩活动', '1', '7', '', '', '', '1', '0', '', '1579445009', '1686645327');
INSERT INTO `tp_cg_column` VALUES ('8', '课堂', '', '课堂', '课堂', '1', '8', '', '', '', '1', '0', '', '1579444946', '1686733897');

-- ----------------------------
-- Table structure for tp_cg_links
-- ----------------------------
DROP TABLE IF EXISTS `tp_cg_links`;
CREATE TABLE `tp_cg_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态  0 禁用，1正常',
  `sorts` int(3) NOT NULL DEFAULT '100' COMMENT '排序',
  `img` varchar(255) NOT NULL DEFAULT '' COMMENT '图片',
  `url` varchar(255) DEFAULT '',
  `types` varchar(255) DEFAULT '' COMMENT '分类',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='banner表';

-- ----------------------------
-- Records of tp_cg_links
-- ----------------------------

-- ----------------------------
-- Table structure for tp_cogen
-- ----------------------------
DROP TABLE IF EXISTS `tp_cogen`;
CREATE TABLE `tp_cogen` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table` varchar(50) DEFAULT NULL COMMENT '数据表名称',
  `comment` varchar(100) DEFAULT NULL COMMENT '数据表注释',
  `search` text COMMENT '列表搜索字段',
  `lists` text COMMENT '列表字段',
  `form` text COMMENT '表单字段',
  `show_field` text COMMENT '输出字段',
  `name` varchar(50) DEFAULT NULL COMMENT '检索字段',
  `form_require` text COMMENT '必填字段',
  `field_rule` text COMMENT '表字段规则',
  `userid` varchar(50) DEFAULT '' COMMENT '前端用户id字段',
  `isauth` tinyint(1) DEFAULT '0' COMMENT '后台是否验证数据权限',
  `islogin` tinyint(1) DEFAULT '0' COMMENT '前端api 是否登录',
  `create_time` int(10) DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `table` (`table`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='代码生成记录';

-- ----------------------------
-- Records of tp_cogen
-- ----------------------------
INSERT INTO `tp_cogen` VALUES ('9', 'cg_column', '文章栏目', '[\"name\"]', '[\"id\",\"name\",\"status\",\"sorts\",\"types\",\"update_time\"]', '[\"id\",\"name\",\"ename\",\"seo_title\",\"seo_dec\",\"status\",\"sorts\",\"imgs\",\"imgs2\",\"url\",\"types\",\"pid\",\"icon\"]', '[\"id\",\"name\",\"ename\",\"seo_title\",\"seo_dec\",\"status\",\"sorts\",\"imgs\",\"imgs2\",\"url\",\"types\",\"pid\",\"icon\",\"create_time\",\"update_time\"]', 'name', '[\"name\",\"pid\"]', '[{\"field\":\"id\",\"type\":\"bigint(20) unsigned\",\"comment\":\"ID\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"name\",\"type\":\"varchar(150)\",\"comment\":\"\\u680f\\u76ee\\u540d\\u79f0\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"ename\",\"type\":\"varchar(255)\",\"comment\":\"\\u82f1\\u6587\\u540d\\u79f0\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"seo_title\",\"type\":\"varchar(150)\",\"comment\":\"seo\\u5173\\u952e\\u8bcd\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"seo_dec\",\"type\":\"varchar(255)\",\"comment\":\"seo\\u63cf\\u8ff0\",\"query\":\"\",\"show\":\"textarea\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"status\",\"type\":\"tinyint(1)\",\"comment\":\"\\u72b6\\u6001\",\"query\":\"=\",\"show\":\"radio\",\"radio\":\"{\\\"0\\\":\\\"\\u7981\\u7528\\\",\\\"1\\\":\\\"\\u6b63\\u5e38\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"sorts\",\"type\":\"int(3)\",\"comment\":\"\\u6392\\u5e8f\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"imgs\",\"type\":\"text\",\"comment\":\"banner\\u56fe\",\"query\":\"\",\"show\":\"image\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"imgs2\",\"type\":\"text\",\"comment\":\"banner\\u56fe\",\"query\":\"\",\"show\":\"image\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"url\",\"type\":\"varchar(255)\",\"comment\":\"\\u7f51\\u5740\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"types\",\"type\":\"tinyint(2)\",\"comment\":\"\\u7c7b\\u578b\",\"query\":\"\",\"show\":\"radio\",\"radio\":\"{\\\"1\\\":\\\"\\u5217\\u8868\\\",\\\"2\\\":\\\"\\u5355\\u9875\\\",\\\"3\\\":\\\"\\u94fe\\u63a5\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"pid\",\"type\":\"bigint(20)\",\"comment\":\"\\u4e0a\\u7ea7id\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"cg_column\",\"name\"],\"idkey\":[\"cg_column\",\"id\"]},{\"field\":\"icon\",\"type\":\"varchar(255)\",\"comment\":\"\\u56fe\\u6807\",\"query\":\"\",\"show\":\"image\",\"radio\":[],\"select\":\"\",\"option\":[]}]', '', '0', '0', '1703832261', '1703832346');
INSERT INTO `tp_cogen` VALUES ('6', 'cg_categery', '文章分类', '[\"name\"]', '[\"id\",\"cid\",\"name\",\"status\",\"sorts\",\"update_time\"]', '[\"id\",\"cid\",\"name\",\"content\",\"status\",\"sorts\"]', '[\"id\",\"cid\",\"name\",\"content\",\"status\",\"sorts\",\"create_time\",\"update_time\"]', 'cid', '[\"cid\",\"name\"]', '[{\"field\":\"id\",\"type\":\"int(10) unsigned\",\"comment\":\"ID\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"cid\",\"type\":\"int(10)\",\"comment\":\"\\u680f\\u76ee\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"cg_column\",\"name\"],\"idkey\":[\"cg_column\",\"id\"]},{\"field\":\"name\",\"type\":\"varchar(150)\",\"comment\":\"\\u540d\\u79f0\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"content\",\"type\":\"varchar(255)\",\"comment\":\"\\u63cf\\u8ff0\",\"query\":\"\",\"show\":\"textarea\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"status\",\"type\":\"tinyint(1)\",\"comment\":\"\\u72b6\\u6001\",\"query\":\"=\",\"show\":\"radio\",\"radio\":\"{\\\"0\\\":\\\"\\u7981\\u7528\\\",\\\"1\\\":\\\"\\u6b63\\u5e38\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"sorts\",\"type\":\"int(3)\",\"comment\":\"\\u6392\\u5e8f\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]}]', '', '0', '0', '1698995044', '1704119083');
INSERT INTO `tp_cogen` VALUES ('8', 'cg_article', '文章管理', '[\"title\"]', '[\"title\",\"dept_id\",\"userid\",\"cid\",\"status\",\"sorts\",\"types\",\"img\",\"visit_num\",\"add_time\"]', '[\"id\",\"title\",\"dept_id\",\"userid\",\"cid\",\"cate\",\"notes\",\"content\",\"status\",\"sorts\",\"types\",\"img\",\"visit_num\",\"video\",\"author\",\"add_time\",\"start_time\",\"end_time\"]', '[\"id\",\"title\",\"dept_id\",\"userid\",\"cid\",\"cate\",\"notes\",\"content\",\"status\",\"sorts\",\"types\",\"img\",\"visit_num\",\"video\",\"author\",\"add_time\",\"start_time\",\"end_time\",\"create_time\",\"update_time\"]', 'cid', '[\"title\",\"dept_id\",\"userid\",\"cid\"]', '[{\"field\":\"id\",\"type\":\"int(10) unsigned\",\"comment\":\"ID\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"title\",\"type\":\"varchar(150)\",\"comment\":\"\\u6807\\u9898\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"dept_id\",\"type\":\"int(10)\",\"comment\":\"\\u90e8\\u95e8id\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"dept\",\"dept_name\"],\"idkey\":[\"dept\",\"id\"]},{\"field\":\"userid\",\"type\":\"int(10)\",\"comment\":\"\\u7528\\u6237id\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"cid\",\"type\":\"int(10)\",\"comment\":\"\\u680f\\u76eeid\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"cg_column\",\"name\"],\"idkey\":[\"cg_column\",\"id\"]},{\"field\":\"cate\",\"type\":\"text\",\"comment\":\"\\u5206\\u7c7b\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"notes\",\"type\":\"varchar(255)\",\"comment\":\"\\u63cf\\u8ff0\",\"query\":\"\",\"show\":\"textarea\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"content\",\"type\":\"text\",\"comment\":\"\\u8be6\\u60c5\",\"query\":\"\",\"show\":\"editor\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"status\",\"type\":\"tinyint(1)\",\"comment\":\"\\u72b6\\u6001  0 \\u7981\\u7528\\uff0c1\\u6b63\\u5e38\",\"query\":\"\",\"show\":\"radio\",\"radio\":\"{\\\"0\\\":\\\"\\u7981\\u7528\\\",\\\"1\\\":\\\"\\u6b63\\u5e38\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"sorts\",\"type\":\"int(3)\",\"comment\":\"\\u6392\\u5e8f\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"types\",\"type\":\"tinyint(2)\",\"comment\":\"\\u7c7b\\u578b\",\"query\":\"\",\"show\":\"radio\",\"radio\":\"{\\\"1\\\":\\\"\\u5217\\u8868\\\",\\\"2\\\":\\\"\\u5355\\u9875\\\",\\\"3\\\":\\\"\\u94fe\\u63a5\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"img\",\"type\":\"varchar(255)\",\"comment\":\"\\u56fe\\u7247\",\"query\":\"\",\"show\":\"image\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"visit_num\",\"type\":\"int(5)\",\"comment\":\"\\u8bbf\\u95ee\\u91cf\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"video\",\"type\":\"varchar(255)\",\"comment\":\"\\u89c6\\u9891\",\"query\":\"\",\"show\":\"video\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"author\",\"type\":\"varchar(200)\",\"comment\":\"\\u4f5c\\u8005\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"add_time\",\"type\":\"int(10) unsigned\",\"comment\":\"\\u53d1\\u5e03\\u65f6\\u95f4\",\"query\":\"\",\"show\":\"datetime\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"start_time\",\"type\":\"int(10) unsigned\",\"comment\":\"\\u5f00\\u59cb\\u65f6\\u95f4\",\"query\":\"\",\"show\":\"datetime\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"end_time\",\"type\":\"int(10) unsigned\",\"comment\":\"\\u7ed3\\u675f\\u65f6\\u95f4\",\"query\":\"\",\"show\":\"datetime\",\"radio\":[],\"select\":\"\",\"option\":[]}]', '', '1', '0', '1703773628', '1703834901');

-- ----------------------------
-- Table structure for tp_dept
-- ----------------------------
DROP TABLE IF EXISTS `tp_dept`;
CREATE TABLE `tp_dept` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `sorts` int(4) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` tinyint(3) unsigned DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

-- ----------------------------
-- Records of tp_dept
-- ----------------------------
INSERT INTO `tp_dept` VALUES ('1', '0', '擎安科技', '100', '', '', '', '1', '1703047956', '1703047697');
INSERT INTO `tp_dept` VALUES ('2', '1', '销售部', '100', '', '', '', '1', '1703047856', '1703047856');
INSERT INTO `tp_dept` VALUES ('3', '1', '技术部', '100', '', '', '', '1', '1703047872', '1703047872');

-- ----------------------------
-- Table structure for tp_done_log
-- ----------------------------
DROP TABLE IF EXISTS `tp_done_log`;
CREATE TABLE `tp_done_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `roles` varchar(50) NOT NULL DEFAULT '' COMMENT '角色',
  `title` varchar(255) DEFAULT NULL COMMENT '操作内容',
  `done_ip` varchar(20) NOT NULL DEFAULT '0' COMMENT '操作IP',
  `permission` varchar(255) DEFAULT NULL COMMENT '操作权限',
  `data` text,
  `done_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=318 DEFAULT CHARSET=utf8 COMMENT='操作日志';

-- ----------------------------
-- Records of tp_done_log
-- ----------------------------
INSERT INTO `tp_done_log` VALUES ('1', '1', 'admin', '超级管理员组', '用户管理', '39.149.247.210', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703824455', '1703824455', '1703824455');
INSERT INTO `tp_done_log` VALUES ('2', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703824458', '1703824458', '1703824458');
INSERT INTO `tp_done_log` VALUES ('3', '1', 'admin', '超级管理员组', '操作日志', '39.149.247.210', 'admin:log:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703824461', '1703824461', '1703824461');
INSERT INTO `tp_done_log` VALUES ('4', '1', 'admin', '超级管理员组', '查看菜单详情', '39.149.247.210', 'admin:rules:getinfo', '{\"id\":313,\"signature\":\"3a6f5c60bdd812ed0f3dacc616aafa4e\"}', '1703824486', '1703824486', '1703824486');
INSERT INTO `tp_done_log` VALUES ('5', '1', 'admin', '超级管理员组', '新增/修改菜单', '39.149.247.210', 'admin:rules:save', '{\"id\":313,\"parent_id\":0,\"menu_type\":\"menu\",\"name\":\"\\u4f7f\\u7528\\u6587\\u6863\",\"path\":\"\",\"icon\":\"iconfont icon-shouye_dongtaihui\",\"component\":\"layout\\/routerView\\/parent\",\"permission\":\"http:\\/\\/test.hardphp.com\\/HardAdmin\\/\",\"sorts\":100,\"status\":1,\"is_hide\":0,\"is_keep_alive\":1,\"is_affix\":0,\"is_link\":1,\"is_iframe\":0,\"signature\":\"680bddb0489d1edda23dc99d69debf1a\"}', '1703824491', '1703824491', '1703824491');
INSERT INTO `tp_done_log` VALUES ('6', '1', 'admin', '超级管理员组', '查看菜单详情', '39.149.247.210', 'admin:rules:getinfo', '{\"id\":314,\"signature\":\"2ba6fb3d1f1ae41d6f4abdd6ee60338b\"}', '1703824496', '1703824496', '1703824496');
INSERT INTO `tp_done_log` VALUES ('7', '1', 'admin', '超级管理员组', '新增/修改菜单', '39.149.247.210', 'admin:rules:save', '{\"id\":314,\"parent_id\":0,\"menu_type\":\"menu\",\"name\":\"\\u63a5\\u53e3\\u6587\\u6863\",\"path\":\"\",\"icon\":\"iconfont icon-putong\",\"component\":\"layout\\/routerView\\/parent\",\"permission\":\"http:\\/\\/test.hardphp.com\\/apidoc\\/?urls.primaryName=%E5%89%8D%E7%AB%AF%E6%96%87%E6%A1%A3#\\/\",\"sorts\":100,\"status\":1,\"is_hide\":0,\"is_keep_alive\":1,\"is_affix\":0,\"is_link\":1,\"is_iframe\":0,\"signature\":\"0941bce5f39070adfbecd52fe66a18ac\"}', '1703824501', '1703824501', '1703824501');
INSERT INTO `tp_done_log` VALUES ('8', '1', 'admin', '超级管理员组', '用户管理', '39.149.247.210', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825726', '1703825726', '1703825726');
INSERT INTO `tp_done_log` VALUES ('9', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825728', '1703825728', '1703825728');
INSERT INTO `tp_done_log` VALUES ('10', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825729', '1703825729', '1703825729');
INSERT INTO `tp_done_log` VALUES ('11', '1', 'admin', '超级管理员组', '查看角色详情', '39.149.247.210', 'admin:groups:getinfo', '{\"id\":1,\"signature\":\"4918c71c70d6d180a6dd4e4ad20d8f60\"}', '1703825731', '1703825731', '1703825731');
INSERT INTO `tp_done_log` VALUES ('12', '1', 'admin', '超级管理员组', '新增/修改角色', '39.149.247.210', 'admin:groups:save', '{\"id\":1,\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\u7ec4\",\"status\":1,\"types\":1,\"rules\":[1,2,3,4,5,54,64,65,6,17,18,19,7,21,22,23,66,274,76,77,78,79,80,91,101,102,111,112,113,114,93,95,98,99,100,117,309,310,311,312,313,314],\"signature\":\"978177e284d698a42e543b69233d1eeb\"}', '1703825733', '1703825733', '1703825733');
INSERT INTO `tp_done_log` VALUES ('13', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825734', '1703825734', '1703825734');
INSERT INTO `tp_done_log` VALUES ('14', '1', 'admin', '超级管理员组', '查看角色详情', '39.149.247.210', 'admin:groups:getinfo', '{\"id\":2,\"signature\":\"e84e07e66af3c61c2846c47344ae0774\"}', '1703825735', '1703825735', '1703825735');
INSERT INTO `tp_done_log` VALUES ('15', '1', 'admin', '超级管理员组', '新增/修改角色', '39.149.247.210', 'admin:groups:save', '{\"id\":2,\"title\":\"\\u8fd0\\u8425\\u7ba1\\u7406\\u7ec4\",\"status\":1,\"types\":1,\"rules\":[1,2,3,4,64,65,17,7,21,66,274,76,77,78,91,101,102,111,112,113,114,93,95,98,99,100,117,313,314],\"signature\":\"196230f22607ec88ef5ea236efb10172\"}', '1703825737', '1703825737', '1703825737');
INSERT INTO `tp_done_log` VALUES ('16', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825737', '1703825737', '1703825737');
INSERT INTO `tp_done_log` VALUES ('17', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825742', '1703825742', '1703825742');
INSERT INTO `tp_done_log` VALUES ('18', '1', 'admin', '超级管理员组', '密钥管理', '39.149.247.210', 'admin:app:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825777', '1703825777', '1703825777');
INSERT INTO `tp_done_log` VALUES ('19', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:system:getinfo', '{\"id\":8,\"signature\":\"d4e68380f7734f7c56f174c83251b1c5\"}', '1703825782', '1703825782', '1703825782');
INSERT INTO `tp_done_log` VALUES ('20', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825785', '1703825785', '1703825785');
INSERT INTO `tp_done_log` VALUES ('21', '1', 'admin', '超级管理员组', '删除', '39.149.247.210', 'admin:cogen:del', '{\"id\":4,\"signature\":\"e4a62c4b7baacec1d2d349b340e35589\"}', '1703825798', '1703825798', '1703825798');
INSERT INTO `tp_done_log` VALUES ('22', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825798', '1703825798', '1703825798');
INSERT INTO `tp_done_log` VALUES ('23', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":6,\"signature\":\"10fa7ad77c2bd697f1176a48fd66a459\"}', '1703825800', '1703825800', '1703825800');
INSERT INTO `tp_done_log` VALUES ('24', '1', 'admin', '超级管理员组', '密钥管理', '39.149.247.210', 'admin:app:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825817', '1703825817', '1703825817');
INSERT INTO `tp_done_log` VALUES ('25', '1', 'admin', '超级管理员组', '用户管理', '39.149.247.210', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825820', '1703825820', '1703825820');
INSERT INTO `tp_done_log` VALUES ('26', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825822', '1703825822', '1703825822');
INSERT INTO `tp_done_log` VALUES ('27', '1', 'admin', '超级管理员组', '操作日志', '39.149.247.210', 'admin:log:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825823', '1703825823', '1703825823');
INSERT INTO `tp_done_log` VALUES ('28', '1', 'admin', '超级管理员组', '用户管理', '39.149.247.210', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825842', '1703825842', '1703825842');
INSERT INTO `tp_done_log` VALUES ('29', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703825844', '1703825844', '1703825844');
INSERT INTO `tp_done_log` VALUES ('30', '1', 'admin', '超级管理员组', '查看角色详情', '39.149.247.210', 'admin:groups:getinfo', '{\"id\":1,\"signature\":\"4918c71c70d6d180a6dd4e4ad20d8f60\"}', '1703825846', '1703825846', '1703825846');
INSERT INTO `tp_done_log` VALUES ('31', '1', 'admin', '超级管理员组', '新增/修改菜单', '39.149.247.210', 'admin:rules:save', '{\"id\":0,\"parent_id\":274,\"menu_type\":\"btn\",\"name\":\"\\u65b0\\u589e\\/\\u7f16\\u8f91\\u90e8\\u95e8\",\"path\":\"\",\"icon\":\"\",\"component\":\"\",\"permission\":\"admin:dept:save\",\"sorts\":100,\"status\":1,\"is_hide\":0,\"is_keep_alive\":1,\"is_affix\":0,\"is_link\":0,\"is_iframe\":0,\"signature\":\"955dd5121dfff36282715663a2260ac2\"}', '1703826047', '1703826047', '1703826047');
INSERT INTO `tp_done_log` VALUES ('32', '1', 'admin', '超级管理员组', '新增/修改菜单', '39.149.247.210', 'admin:rules:save', '{\"id\":0,\"parent_id\":274,\"menu_type\":\"btn\",\"name\":\"\\u90e8\\u95e8\\u8be6\\u60c5\",\"path\":\"\",\"icon\":\"\",\"component\":\"\",\"permission\":\"admin:dept:getinfo\",\"sorts\":100,\"status\":1,\"is_hide\":0,\"is_keep_alive\":1,\"is_affix\":0,\"is_link\":0,\"is_iframe\":0,\"signature\":\"a50499b1af742d53a14f6dd196dab3f5\"}', '1703826083', '1703826083', '1703826083');
INSERT INTO `tp_done_log` VALUES ('33', '1', 'admin', '超级管理员组', '新增/修改菜单', '39.149.247.210', 'admin:rules:save', '{\"id\":0,\"parent_id\":0,\"menu_type\":\"btn\",\"name\":\"\\u5220\\u9664\\u90e8\\u95e8\",\"path\":\"\",\"icon\":\"\",\"component\":\"\",\"permission\":\"admin:dept:del\",\"sorts\":100,\"status\":1,\"is_hide\":0,\"is_keep_alive\":1,\"is_affix\":0,\"is_link\":0,\"is_iframe\":0,\"signature\":\"265e323126747726055b747ef4166af9\"}', '1703826097', '1703826097', '1703826097');
INSERT INTO `tp_done_log` VALUES ('34', '1', 'admin', '超级管理员组', '用户管理', '39.149.247.210', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826100', '1703826100', '1703826100');
INSERT INTO `tp_done_log` VALUES ('35', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826100', '1703826100', '1703826100');
INSERT INTO `tp_done_log` VALUES ('36', '1', 'admin', '超级管理员组', '查看角色详情', '39.149.247.210', 'admin:groups:getinfo', '{\"id\":1,\"signature\":\"4918c71c70d6d180a6dd4e4ad20d8f60\"}', '1703826101', '1703826101', '1703826101');
INSERT INTO `tp_done_log` VALUES ('37', '1', 'admin', '超级管理员组', '查看菜单详情', '39.149.247.210', 'admin:rules:getinfo', '{\"id\":317,\"signature\":\"a681a0d7d5832f423565bea254be4a32\"}', '1703826116', '1703826116', '1703826116');
INSERT INTO `tp_done_log` VALUES ('38', '1', 'admin', '超级管理员组', '新增/修改菜单', '39.149.247.210', 'admin:rules:save', '{\"id\":317,\"parent_id\":274,\"menu_type\":\"btn\",\"name\":\"\\u5220\\u9664\\u90e8\\u95e8\",\"path\":\"\",\"icon\":\"\",\"component\":\"\",\"permission\":\"admin:dept:del\",\"sorts\":100,\"status\":1,\"is_hide\":0,\"is_keep_alive\":1,\"is_affix\":0,\"is_link\":0,\"is_iframe\":0,\"signature\":\"12b2c4a8d04e0f8bece8c89c653127ca\"}', '1703826122', '1703826122', '1703826122');
INSERT INTO `tp_done_log` VALUES ('39', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826125', '1703826125', '1703826125');
INSERT INTO `tp_done_log` VALUES ('40', '1', 'admin', '超级管理员组', '查看角色详情', '39.149.247.210', 'admin:groups:getinfo', '{\"id\":1,\"signature\":\"4918c71c70d6d180a6dd4e4ad20d8f60\"}', '1703826127', '1703826127', '1703826127');
INSERT INTO `tp_done_log` VALUES ('41', '1', 'admin', '超级管理员组', '新增/修改角色', '39.149.247.210', 'admin:groups:save', '{\"id\":1,\"title\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\\u7ec4\",\"status\":1,\"types\":1,\"rules\":[1,2,3,4,5,54,64,65,6,17,18,19,7,21,22,23,66,274,315,316,317,76,77,78,79,80,91,101,102,111,112,113,114,93,95,98,99,100,117,309,310,311,312,313,314],\"signature\":\"6d36e7226ba6a149e099801f66280774\"}', '1703826134', '1703826134', '1703826134');
INSERT INTO `tp_done_log` VALUES ('42', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826134', '1703826134', '1703826134');
INSERT INTO `tp_done_log` VALUES ('43', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826151', '1703826151', '1703826151');
INSERT INTO `tp_done_log` VALUES ('44', '1', 'admin', '超级管理员组', '操作日志', '39.149.247.210', 'admin:log:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826349', '1703826349', '1703826349');
INSERT INTO `tp_done_log` VALUES ('45', '1', 'admin', '超级管理员组', '用户管理', '39.149.247.210', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826354', '1703826354', '1703826354');
INSERT INTO `tp_done_log` VALUES ('46', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826354', '1703826354', '1703826354');
INSERT INTO `tp_done_log` VALUES ('47', '1', 'admin', '超级管理员组', '用户管理', '39.149.247.210', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826535', '1703826535', '1703826535');
INSERT INTO `tp_done_log` VALUES ('48', '1', 'admin', '超级管理员组', '用户管理', '39.149.247.210', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826642', '1703826642', '1703826642');
INSERT INTO `tp_done_log` VALUES ('49', '1', 'admin', '超级管理员组', '用户管理', '39.149.247.210', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826681', '1703826681', '1703826681');
INSERT INTO `tp_done_log` VALUES ('50', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826684', '1703826684', '1703826684');
INSERT INTO `tp_done_log` VALUES ('51', '1', 'admin', '超级管理员组', '操作日志', '39.149.247.210', 'admin:log:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826684', '1703826684', '1703826684');
INSERT INTO `tp_done_log` VALUES ('52', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703826708', '1703826708', '1703826708');
INSERT INTO `tp_done_log` VALUES ('53', '1', 'admin', '超级管理员组', '新增/修改', '39.149.247.210', 'admin:cogen:save', '{\"id\":0,\"table\":\"cg_column\",\"comment\":\"\\u6587\\u7ae0\\u680f\\u76ee\",\"search\":[\"name\"],\"lists\":[\"id\",\"name\",\"status\",\"sorts\",\"types\",\"update_time\"],\"form\":[\"id\",\"name\",\"ename\",\"seo_title\",\"seo_dec\",\"status\",\"sorts\",\"imgs\",\"imgs2\",\"url\",\"types\",\"pid\",\"icon\"],\"show_field\":[\"id\",\"name\",\"ename\",\"seo_title\",\"seo_dec\",\"status\",\"sorts\",\"imgs\",\"imgs2\",\"url\",\"types\",\"pid\",\"icon\",\"create_time\",\"update_time\"],\"name\":\"name\",\"islogin\":0,\"userid\":\"\",\"form_require\":[\"name\",\"pid\"],\"field_rule\":[{\"field\":\"id\",\"type\":\"bigint(20) unsigned\",\"comment\":\"ID\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"name\",\"type\":\"varchar(150)\",\"comment\":\"\\u680f\\u76ee\\u540d\\u79f0\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"ename\",\"type\":\"varchar(255)\",\"comment\":\"\\u82f1\\u6587\\u540d\\u79f0\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"seo_title\",\"type\":\"varchar(150)\",\"comment\":\"seo\\u5173\\u952e\\u8bcd\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"seo_dec\",\"type\":\"varchar(255)\",\"comment\":\"seo\\u63cf\\u8ff0\",\"query\":\"\",\"show\":\"textarea\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"status\",\"type\":\"tinyint(1)\",\"comment\":\"\\u72b6\\u6001\",\"query\":\"=\",\"show\":\"radio\",\"radio\":\"{\\\"0\\\":\\\"\\u7981\\u7528\\\",\\\"1\\\":\\\"\\u6b63\\u5e38\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"sorts\",\"type\":\"int(3)\",\"comment\":\"\\u6392\\u5e8f\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"imgs\",\"type\":\"text\",\"comment\":\"banner\\u56fe\",\"query\":\"\",\"show\":\"image\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"imgs2\",\"type\":\"text\",\"comment\":\"banner\\u56fe\",\"query\":\"\",\"show\":\"image\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"url\",\"type\":\"varchar(255)\",\"comment\":\"\\u7f51\\u5740\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"types\",\"type\":\"tinyint(2)\",\"comment\":\"\\u7c7b\\u578b\",\"query\":\"\",\"show\":\"radio\",\"radio\":\"{\\\"1\\\":\\\"\\u5217\\u8868\\\",\\\"2\\\":\\\"\\u5355\\u9875\\\",\\\"3\\\":\\\"\\u94fe\\u63a5\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"pid\",\"type\":\"bigint(20)\",\"comment\":\"\\u4e0a\\u7ea7id\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[\"cg_column\",\"name\"],\"idkey\":[\"cg_column\",\"id\"]},{\"field\":\"icon\",\"type\":\"varchar(255)\",\"comment\":\"\\u56fe\\u6807\",\"query\":\"\",\"show\":\"image\",\"radio\":[],\"select\":\"\",\"option\":[]}],\"isauth\":0,\"signature\":\"cb8d2fcc73352d6fe42eb88fe8746010\"}', '1703832261', '1703832261', '1703832261');
INSERT INTO `tp_done_log` VALUES ('54', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703832261', '1703832261', '1703832261');
INSERT INTO `tp_done_log` VALUES ('55', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703832265', '1703832265', '1703832265');
INSERT INTO `tp_done_log` VALUES ('56', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":9,\"signature\":\"4a931b96e96b63f30315d40633864680\"}', '1703832332', '1703832332', '1703832332');
INSERT INTO `tp_done_log` VALUES ('57', '1', 'admin', '超级管理员组', '新增/修改', '39.149.247.210', 'admin:cogen:save', '{\"id\":9,\"table\":\"cg_column\",\"comment\":\"\\u6587\\u7ae0\\u680f\\u76ee\",\"search\":[\"name\"],\"lists\":[\"id\",\"name\",\"status\",\"sorts\",\"types\",\"update_time\"],\"form\":[\"id\",\"name\",\"ename\",\"seo_title\",\"seo_dec\",\"status\",\"sorts\",\"imgs\",\"imgs2\",\"url\",\"types\",\"pid\",\"icon\"],\"show_field\":[\"id\",\"name\",\"ename\",\"seo_title\",\"seo_dec\",\"status\",\"sorts\",\"imgs\",\"imgs2\",\"url\",\"types\",\"pid\",\"icon\",\"create_time\",\"update_time\"],\"name\":\"name\",\"islogin\":0,\"userid\":\"\",\"form_require\":[\"name\",\"pid\"],\"field_rule\":[{\"field\":\"id\",\"type\":\"bigint(20) unsigned\",\"comment\":\"ID\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"name\",\"type\":\"varchar(150)\",\"comment\":\"\\u680f\\u76ee\\u540d\\u79f0\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"ename\",\"type\":\"varchar(255)\",\"comment\":\"\\u82f1\\u6587\\u540d\\u79f0\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"seo_title\",\"type\":\"varchar(150)\",\"comment\":\"seo\\u5173\\u952e\\u8bcd\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"seo_dec\",\"type\":\"varchar(255)\",\"comment\":\"seo\\u63cf\\u8ff0\",\"query\":\"\",\"show\":\"textarea\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"status\",\"type\":\"tinyint(1)\",\"comment\":\"\\u72b6\\u6001\",\"query\":\"=\",\"show\":\"radio\",\"radio\":\"{\\\"0\\\":\\\"\\u7981\\u7528\\\",\\\"1\\\":\\\"\\u6b63\\u5e38\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"sorts\",\"type\":\"int(3)\",\"comment\":\"\\u6392\\u5e8f\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"imgs\",\"type\":\"text\",\"comment\":\"banner\\u56fe\",\"query\":\"\",\"show\":\"image\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"imgs2\",\"type\":\"text\",\"comment\":\"banner\\u56fe\",\"query\":\"\",\"show\":\"image\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"url\",\"type\":\"varchar(255)\",\"comment\":\"\\u7f51\\u5740\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"types\",\"type\":\"tinyint(2)\",\"comment\":\"\\u7c7b\\u578b\",\"query\":\"\",\"show\":\"radio\",\"radio\":\"{\\\"1\\\":\\\"\\u5217\\u8868\\\",\\\"2\\\":\\\"\\u5355\\u9875\\\",\\\"3\\\":\\\"\\u94fe\\u63a5\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"pid\",\"type\":\"bigint(20)\",\"comment\":\"\\u4e0a\\u7ea7id\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"cg_column\",\"name\"],\"idkey\":[\"cg_column\",\"id\"]},{\"field\":\"icon\",\"type\":\"varchar(255)\",\"comment\":\"\\u56fe\\u6807\",\"query\":\"\",\"show\":\"image\",\"radio\":[],\"select\":\"\",\"option\":[]}],\"isauth\":0,\"signature\":\"51f287a02cd1bd12a92fca30e0f56a74\"}', '1703832346', '1703832346', '1703832346');
INSERT INTO `tp_done_log` VALUES ('58', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703832346', '1703832346', '1703832346');
INSERT INTO `tp_done_log` VALUES ('59', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":6,\"signature\":\"10fa7ad77c2bd697f1176a48fd66a459\"}', '1703832430', '1703832430', '1703832430');
INSERT INTO `tp_done_log` VALUES ('60', '1', 'admin', '超级管理员组', '新增/修改', '39.149.247.210', 'admin:cogen:save', '{\"id\":6,\"table\":\"cg_categery\",\"comment\":\"\\u6587\\u7ae0\\u5206\\u7c7b\",\"search\":[\"name\"],\"lists\":[\"id\",\"cid\",\"name\",\"status\",\"sorts\",\"update_time\"],\"form\":[\"id\",\"cid\",\"name\",\"content\",\"status\",\"sorts\"],\"show_field\":[\"id\",\"cid\",\"name\",\"content\",\"status\",\"sorts\",\"create_time\",\"update_time\"],\"name\":\"cid\",\"islogin\":0,\"userid\":\"\",\"form_require\":[\"cid\",\"name\"],\"field_rule\":[{\"field\":\"id\",\"type\":\"int(10) unsigned\",\"comment\":\"ID\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"cid\",\"type\":\"int(10)\",\"comment\":\"\\u680f\\u76ee\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"cg_column\",\"name\"],\"idkey\":[\"cg_column\",\"id\"]},{\"field\":\"name\",\"type\":\"varchar(150)\",\"comment\":\"\\u540d\\u79f0\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"content\",\"type\":\"varchar(255)\",\"comment\":\"\\u63cf\\u8ff0\",\"query\":\"\",\"show\":\"textarea\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"status\",\"type\":\"tinyint(1)\",\"comment\":\"\\u72b6\\u6001\",\"query\":\"=\",\"show\":\"radio\",\"radio\":\"{\\\"0\\\":\\\"\\u7981\\u7528\\\",\\\"1\\\":\\\"\\u6b63\\u5e38\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"sorts\",\"type\":\"int(3)\",\"comment\":\"\\u6392\\u5e8f\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]}],\"isauth\":0,\"signature\":\"2c602f58948f5f167dc0447f0ddd71f7\"}', '1703832866', '1703832866', '1703832866');
INSERT INTO `tp_done_log` VALUES ('61', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703832866', '1703832866', '1703832866');
INSERT INTO `tp_done_log` VALUES ('62', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703832868', '1703832868', '1703832868');
INSERT INTO `tp_done_log` VALUES ('63', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":8,\"signature\":\"d4e68380f7734f7c56f174c83251b1c5\"}', '1703832895', '1703832895', '1703832895');
INSERT INTO `tp_done_log` VALUES ('64', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":8,\"signature\":\"d4e68380f7734f7c56f174c83251b1c5\"}', '1703832898', '1703832898', '1703832898');
INSERT INTO `tp_done_log` VALUES ('65', '1', 'admin', '超级管理员组', '新增/修改', '39.149.247.210', 'admin:cogen:save', '{\"id\":8,\"table\":\"cg_article\",\"comment\":\"\\u6587\\u7ae0\\u7ba1\\u7406\",\"search\":[\"title\"],\"lists\":[\"title\",\"dept_id\",\"userid\",\"cid\",\"status\",\"sorts\",\"types\",\"img\",\"visit_num\",\"add_time\"],\"form\":[\"id\",\"title\",\"dept_id\",\"userid\",\"cid\",\"cate\",\"notes\",\"content\",\"status\",\"sorts\",\"types\",\"img\",\"visit_num\",\"video\",\"author\",\"add_time\",\"start_time\",\"end_time\"],\"show_field\":[\"id\",\"title\",\"dept_id\",\"userid\",\"cid\",\"cate\",\"notes\",\"content\",\"status\",\"sorts\",\"types\",\"img\",\"visit_num\",\"video\",\"author\",\"add_time\",\"start_time\",\"end_time\",\"create_time\",\"update_time\"],\"name\":\"cid\",\"islogin\":0,\"userid\":\"\",\"form_require\":[\"title\",\"dept_id\",\"userid\",\"cid\"],\"field_rule\":[{\"field\":\"id\",\"type\":\"int(10) unsigned\",\"comment\":\"ID\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"title\",\"type\":\"varchar(150)\",\"comment\":\"\\u6807\\u9898\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"dept_id\",\"type\":\"int(10)\",\"comment\":\"\\u90e8\\u95e8id\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"dept\",\"dept_name\"],\"idkey\":[\"dept\",\"id\"]},{\"field\":\"userid\",\"type\":\"int(10)\",\"comment\":\"\\u7528\\u6237id\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"cid\",\"type\":\"int(10)\",\"comment\":\"\\u680f\\u76eeid\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"cg_column\",\"name\"],\"idkey\":[\"cg_column\"]},{\"field\":\"cate\",\"type\":\"text\",\"comment\":\"\\u5206\\u7c7b\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"notes\",\"type\":\"varchar(255)\",\"comment\":\"\\u63cf\\u8ff0\",\"query\":\"\",\"show\":\"textarea\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"content\",\"type\":\"text\",\"comment\":\"\\u8be6\\u60c5\",\"query\":\"\",\"show\":\"editor\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"status\",\"type\":\"tinyint(1)\",\"comment\":\"\\u72b6\\u6001  0 \\u7981\\u7528\\uff0c1\\u6b63\\u5e38\",\"query\":\"\",\"show\":\"radio\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"sorts\",\"type\":\"int(3)\",\"comment\":\"\\u6392\\u5e8f\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"types\",\"type\":\"tinyint(2)\",\"comment\":\"\\u7c7b\\u578b\",\"query\":\"\",\"show\":\"radio\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"img\",\"type\":\"varchar(255)\",\"comment\":\"\\u56fe\\u7247\",\"query\":\"\",\"show\":\"image\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"visit_num\",\"type\":\"int(5)\",\"comment\":\"\\u8bbf\\u95ee\\u91cf\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"video\",\"type\":\"varchar(255)\",\"comment\":\"\\u89c6\\u9891\",\"query\":\"\",\"show\":\"video\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"author\",\"type\":\"varchar(200)\",\"comment\":\"\\u4f5c\\u8005\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"add_time\",\"type\":\"int(10) unsigned\",\"comment\":\"\\u53d1\\u5e03\\u65f6\\u95f4\",\"query\":\"\",\"show\":\"datetime\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"start_time\",\"type\":\"int(10) unsigned\",\"comment\":\"\\u5f00\\u59cb\\u65f6\\u95f4\",\"query\":\"\",\"show\":\"datetime\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"end_time\",\"type\":\"int(10) unsigned\",\"comment\":\"\\u7ed3\\u675f\\u65f6\\u95f4\",\"query\":\"\",\"show\":\"datetime\",\"radio\":[],\"select\":\"\",\"option\":[]}],\"isauth\":1,\"signature\":\"c382016e4db0e52d174f59e5b4a0c7af\"}', '1703833706', '1703833706', '1703833706');
INSERT INTO `tp_done_log` VALUES ('66', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703833707', '1703833707', '1703833707');
INSERT INTO `tp_done_log` VALUES ('67', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":8,\"signature\":\"d4e68380f7734f7c56f174c83251b1c5\"}', '1703834037', '1703834037', '1703834037');
INSERT INTO `tp_done_log` VALUES ('68', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703834096', '1703834096', '1703834096');
INSERT INTO `tp_done_log` VALUES ('69', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703834114', '1703834114', '1703834114');
INSERT INTO `tp_done_log` VALUES ('70', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":8,\"signature\":\"d4e68380f7734f7c56f174c83251b1c5\"}', '1703834132', '1703834132', '1703834132');
INSERT INTO `tp_done_log` VALUES ('71', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703834688', '1703834688', '1703834688');
INSERT INTO `tp_done_log` VALUES ('72', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":8,\"signature\":\"d4e68380f7734f7c56f174c83251b1c5\"}', '1703834690', '1703834690', '1703834690');
INSERT INTO `tp_done_log` VALUES ('73', '1', 'admin', '超级管理员组', '新增/修改', '39.149.247.210', 'admin:cogen:save', '{\"id\":8,\"table\":\"cg_article\",\"comment\":\"\\u6587\\u7ae0\\u7ba1\\u7406\",\"search\":[\"title\"],\"lists\":[\"title\",\"dept_id\",\"userid\",\"cid\",\"status\",\"sorts\",\"types\",\"img\",\"visit_num\",\"add_time\"],\"form\":[\"id\",\"title\",\"dept_id\",\"userid\",\"cid\",\"cate\",\"notes\",\"content\",\"status\",\"sorts\",\"types\",\"img\",\"visit_num\",\"video\",\"author\",\"add_time\",\"start_time\",\"end_time\"],\"show_field\":[\"id\",\"title\",\"dept_id\",\"userid\",\"cid\",\"cate\",\"notes\",\"content\",\"status\",\"sorts\",\"types\",\"img\",\"visit_num\",\"video\",\"author\",\"add_time\",\"start_time\",\"end_time\",\"create_time\",\"update_time\"],\"name\":\"cid\",\"islogin\":0,\"userid\":\"\",\"form_require\":[\"title\",\"dept_id\",\"userid\",\"cid\"],\"field_rule\":[{\"field\":\"id\",\"type\":\"int(10) unsigned\",\"comment\":\"ID\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"title\",\"type\":\"varchar(150)\",\"comment\":\"\\u6807\\u9898\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"dept_id\",\"type\":\"int(10)\",\"comment\":\"\\u90e8\\u95e8id\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"dept\",\"dept_name\"],\"idkey\":[\"dept\",\"id\"]},{\"field\":\"userid\",\"type\":\"int(10)\",\"comment\":\"\\u7528\\u6237id\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"cid\",\"type\":\"int(10)\",\"comment\":\"\\u680f\\u76eeid\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"cg_column\",\"name\"],\"idkey\":[\"cg_column\"]},{\"field\":\"cate\",\"type\":\"text\",\"comment\":\"\\u5206\\u7c7b\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"notes\",\"type\":\"varchar(255)\",\"comment\":\"\\u63cf\\u8ff0\",\"query\":\"\",\"show\":\"textarea\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"content\",\"type\":\"text\",\"comment\":\"\\u8be6\\u60c5\",\"query\":\"\",\"show\":\"editor\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"status\",\"type\":\"tinyint(1)\",\"comment\":\"\\u72b6\\u6001  0 \\u7981\\u7528\\uff0c1\\u6b63\\u5e38\",\"query\":\"\",\"show\":\"radio\",\"radio\":\"{\\\"0\\\":\\\"\\u7981\\u7528\\\",\\\"1\\\":\\\"\\u6b63\\u5e38\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"sorts\",\"type\":\"int(3)\",\"comment\":\"\\u6392\\u5e8f\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"types\",\"type\":\"tinyint(2)\",\"comment\":\"\\u7c7b\\u578b\",\"query\":\"\",\"show\":\"radio\",\"radio\":\"{\\\"1\\\":\\\"\\u5217\\u8868\\\",\\\"2\\\":\\\"\\u5355\\u9875\\\",\\\"3\\\":\\\"\\u94fe\\u63a5\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"img\",\"type\":\"varchar(255)\",\"comment\":\"\\u56fe\\u7247\",\"query\":\"\",\"show\":\"image\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"visit_num\",\"type\":\"int(5)\",\"comment\":\"\\u8bbf\\u95ee\\u91cf\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"video\",\"type\":\"varchar(255)\",\"comment\":\"\\u89c6\\u9891\",\"query\":\"\",\"show\":\"video\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"author\",\"type\":\"varchar(200)\",\"comment\":\"\\u4f5c\\u8005\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"add_time\",\"type\":\"int(10) unsigned\",\"comment\":\"\\u53d1\\u5e03\\u65f6\\u95f4\",\"query\":\"\",\"show\":\"datetime\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"start_time\",\"type\":\"int(10) unsigned\",\"comment\":\"\\u5f00\\u59cb\\u65f6\\u95f4\",\"query\":\"\",\"show\":\"datetime\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"end_time\",\"type\":\"int(10) unsigned\",\"comment\":\"\\u7ed3\\u675f\\u65f6\\u95f4\",\"query\":\"\",\"show\":\"datetime\",\"radio\":[],\"select\":\"\",\"option\":[]}],\"isauth\":1,\"signature\":\"ecd1ef2c3b31ea2eef45fa27d221aa5c\"}', '1703834730', '1703834730', '1703834730');
INSERT INTO `tp_done_log` VALUES ('74', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703834731', '1703834731', '1703834731');
INSERT INTO `tp_done_log` VALUES ('75', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703834732', '1703834732', '1703834732');
INSERT INTO `tp_done_log` VALUES ('76', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703834734', '1703834734', '1703834734');
INSERT INTO `tp_done_log` VALUES ('77', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":8,\"signature\":\"d4e68380f7734f7c56f174c83251b1c5\"}', '1703834874', '1703834874', '1703834874');
INSERT INTO `tp_done_log` VALUES ('78', '1', 'admin', '超级管理员组', '新增/修改', '39.149.247.210', 'admin:cogen:save', '{\"id\":8,\"table\":\"cg_article\",\"comment\":\"\\u6587\\u7ae0\\u7ba1\\u7406\",\"search\":[\"title\"],\"lists\":[\"title\",\"dept_id\",\"userid\",\"cid\",\"status\",\"sorts\",\"types\",\"img\",\"visit_num\",\"add_time\"],\"form\":[\"id\",\"title\",\"dept_id\",\"userid\",\"cid\",\"cate\",\"notes\",\"content\",\"status\",\"sorts\",\"types\",\"img\",\"visit_num\",\"video\",\"author\",\"add_time\",\"start_time\",\"end_time\"],\"show_field\":[\"id\",\"title\",\"dept_id\",\"userid\",\"cid\",\"cate\",\"notes\",\"content\",\"status\",\"sorts\",\"types\",\"img\",\"visit_num\",\"video\",\"author\",\"add_time\",\"start_time\",\"end_time\",\"create_time\",\"update_time\"],\"name\":\"cid\",\"islogin\":0,\"userid\":\"\",\"form_require\":[\"title\",\"dept_id\",\"userid\",\"cid\"],\"field_rule\":[{\"field\":\"id\",\"type\":\"int(10) unsigned\",\"comment\":\"ID\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"title\",\"type\":\"varchar(150)\",\"comment\":\"\\u6807\\u9898\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"dept_id\",\"type\":\"int(10)\",\"comment\":\"\\u90e8\\u95e8id\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"dept\",\"dept_name\"],\"idkey\":[\"dept\",\"id\"]},{\"field\":\"userid\",\"type\":\"int(10)\",\"comment\":\"\\u7528\\u6237id\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"cid\",\"type\":\"int(10)\",\"comment\":\"\\u680f\\u76eeid\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"cg_column\",\"name\"],\"idkey\":[\"cg_column\",\"id\"]},{\"field\":\"cate\",\"type\":\"text\",\"comment\":\"\\u5206\\u7c7b\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"notes\",\"type\":\"varchar(255)\",\"comment\":\"\\u63cf\\u8ff0\",\"query\":\"\",\"show\":\"textarea\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"content\",\"type\":\"text\",\"comment\":\"\\u8be6\\u60c5\",\"query\":\"\",\"show\":\"editor\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"status\",\"type\":\"tinyint(1)\",\"comment\":\"\\u72b6\\u6001  0 \\u7981\\u7528\\uff0c1\\u6b63\\u5e38\",\"query\":\"\",\"show\":\"radio\",\"radio\":\"{\\\"0\\\":\\\"\\u7981\\u7528\\\",\\\"1\\\":\\\"\\u6b63\\u5e38\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"sorts\",\"type\":\"int(3)\",\"comment\":\"\\u6392\\u5e8f\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"types\",\"type\":\"tinyint(2)\",\"comment\":\"\\u7c7b\\u578b\",\"query\":\"\",\"show\":\"radio\",\"radio\":\"{\\\"1\\\":\\\"\\u5217\\u8868\\\",\\\"2\\\":\\\"\\u5355\\u9875\\\",\\\"3\\\":\\\"\\u94fe\\u63a5\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"img\",\"type\":\"varchar(255)\",\"comment\":\"\\u56fe\\u7247\",\"query\":\"\",\"show\":\"image\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"visit_num\",\"type\":\"int(5)\",\"comment\":\"\\u8bbf\\u95ee\\u91cf\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"video\",\"type\":\"varchar(255)\",\"comment\":\"\\u89c6\\u9891\",\"query\":\"\",\"show\":\"video\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"author\",\"type\":\"varchar(200)\",\"comment\":\"\\u4f5c\\u8005\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"add_time\",\"type\":\"int(10) unsigned\",\"comment\":\"\\u53d1\\u5e03\\u65f6\\u95f4\",\"query\":\"\",\"show\":\"datetime\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"start_time\",\"type\":\"int(10) unsigned\",\"comment\":\"\\u5f00\\u59cb\\u65f6\\u95f4\",\"query\":\"\",\"show\":\"datetime\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"end_time\",\"type\":\"int(10) unsigned\",\"comment\":\"\\u7ed3\\u675f\\u65f6\\u95f4\",\"query\":\"\",\"show\":\"datetime\",\"radio\":[],\"select\":\"\",\"option\":[]}],\"isauth\":1,\"signature\":\"c4fc5037c6341410012a6eb10e91ec74\"}', '1703834901', '1703834901', '1703834901');
INSERT INTO `tp_done_log` VALUES ('79', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703834902', '1703834902', '1703834902');
INSERT INTO `tp_done_log` VALUES ('80', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703834988', '1703834988', '1703834988');
INSERT INTO `tp_done_log` VALUES ('81', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835050', '1703835050', '1703835050');
INSERT INTO `tp_done_log` VALUES ('82', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835056', '1703835056', '1703835056');
INSERT INTO `tp_done_log` VALUES ('83', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835126', '1703835126', '1703835126');
INSERT INTO `tp_done_log` VALUES ('84', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835144', '1703835144', '1703835144');
INSERT INTO `tp_done_log` VALUES ('85', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835163', '1703835163', '1703835163');
INSERT INTO `tp_done_log` VALUES ('86', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835165', '1703835165', '1703835165');
INSERT INTO `tp_done_log` VALUES ('87', '1', 'admin', '超级管理员组', '删除菜单', '39.149.247.210', 'admin:rules:del', '{\"id\":312,\"signature\":\"92363c8b9975ad771a6d0b07f268f0cb\"}', '1703835260', '1703835260', '1703835260');
INSERT INTO `tp_done_log` VALUES ('88', '1', 'admin', '超级管理员组', '删除菜单', '39.149.247.210', 'admin:rules:del', '{\"id\":310,\"signature\":\"b041472fa8696ea9e108e9690e95ea22\"}', '1703835276', '1703835276', '1703835276');
INSERT INTO `tp_done_log` VALUES ('89', '1', 'admin', '超级管理员组', '删除菜单', '39.149.247.210', 'admin:rules:del', '{\"id\":311,\"signature\":\"5c0600fa790ea99c0c006ad3bd1a71c0\"}', '1703835286', '1703835286', '1703835286');
INSERT INTO `tp_done_log` VALUES ('90', '1', 'admin', '超级管理员组', '删除菜单', '39.149.247.210', 'admin:rules:del', '{\"id\":309,\"signature\":\"33fea19f025ff473af7e118b64651a1f\"}', '1703835294', '1703835294', '1703835294');
INSERT INTO `tp_done_log` VALUES ('91', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835306', '1703835306', '1703835306');
INSERT INTO `tp_done_log` VALUES ('92', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835307', '1703835307', '1703835307');
INSERT INTO `tp_done_log` VALUES ('93', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835308', '1703835308', '1703835308');
INSERT INTO `tp_done_log` VALUES ('94', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835314', '1703835314', '1703835314');
INSERT INTO `tp_done_log` VALUES ('95', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835320', '1703835320', '1703835320');
INSERT INTO `tp_done_log` VALUES ('96', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835329', '1703835329', '1703835329');
INSERT INTO `tp_done_log` VALUES ('97', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835349', '1703835349', '1703835349');
INSERT INTO `tp_done_log` VALUES ('98', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835410', '1703835410', '1703835410');
INSERT INTO `tp_done_log` VALUES ('99', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835429', '1703835429', '1703835429');
INSERT INTO `tp_done_log` VALUES ('100', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835581', '1703835581', '1703835581');
INSERT INTO `tp_done_log` VALUES ('101', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835602', '1703835602', '1703835602');
INSERT INTO `tp_done_log` VALUES ('102', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":2,\"psize\":10,\"signature\":\"8a0f0174bea8b7b5d535975f5f6ef69c\"}', '1703835616', '1703835616', '1703835616');
INSERT INTO `tp_done_log` VALUES ('103', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835617', '1703835617', '1703835617');
INSERT INTO `tp_done_log` VALUES ('104', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835649', '1703835649', '1703835649');
INSERT INTO `tp_done_log` VALUES ('105', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835678', '1703835678', '1703835678');
INSERT INTO `tp_done_log` VALUES ('106', '1', 'admin', '超级管理员组', '查看文章管理详情', '39.149.247.210', 'admin:cogencgarticle:getinfo', '{\"id\":20,\"signature\":\"d3a01e6c166efd456b79afa33819e7c6\"}', '1703835680', '1703835680', '1703835680');
INSERT INTO `tp_done_log` VALUES ('107', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835714', '1703835714', '1703835714');
INSERT INTO `tp_done_log` VALUES ('108', '1', 'admin', '超级管理员组', '查看文章分类详情', '39.149.247.210', 'admin:cogencgcategery:getinfo', '{\"id\":5,\"signature\":\"8a260f529b6b9d08d2687406daa5845b\"}', '1703835725', '1703835725', '1703835725');
INSERT INTO `tp_done_log` VALUES ('109', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835743', '1703835743', '1703835743');
INSERT INTO `tp_done_log` VALUES ('110', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835745', '1703835745', '1703835745');
INSERT INTO `tp_done_log` VALUES ('111', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835745', '1703835745', '1703835745');
INSERT INTO `tp_done_log` VALUES ('112', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835751', '1703835751', '1703835751');
INSERT INTO `tp_done_log` VALUES ('113', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835751', '1703835751', '1703835751');
INSERT INTO `tp_done_log` VALUES ('114', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835756', '1703835756', '1703835756');
INSERT INTO `tp_done_log` VALUES ('115', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835761', '1703835761', '1703835761');
INSERT INTO `tp_done_log` VALUES ('116', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835769', '1703835769', '1703835769');
INSERT INTO `tp_done_log` VALUES ('117', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835769', '1703835769', '1703835769');
INSERT INTO `tp_done_log` VALUES ('118', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835770', '1703835770', '1703835770');
INSERT INTO `tp_done_log` VALUES ('119', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835779', '1703835779', '1703835779');
INSERT INTO `tp_done_log` VALUES ('120', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835783', '1703835783', '1703835783');
INSERT INTO `tp_done_log` VALUES ('121', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703835887', '1703835887', '1703835887');
INSERT INTO `tp_done_log` VALUES ('122', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703864973', '1703864973', '1703864973');
INSERT INTO `tp_done_log` VALUES ('123', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703864977', '1703864977', '1703864977');
INSERT INTO `tp_done_log` VALUES ('124', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703864978', '1703864978', '1703864978');
INSERT INTO `tp_done_log` VALUES ('125', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703864979', '1703864979', '1703864979');
INSERT INTO `tp_done_log` VALUES ('126', '1', 'admin', '超级管理员组', '密钥管理', '39.149.247.210', 'admin:app:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703864982', '1703864982', '1703864982');
INSERT INTO `tp_done_log` VALUES ('127', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703864984', '1703864984', '1703864984');
INSERT INTO `tp_done_log` VALUES ('128', '1', 'admin', '超级管理员组', '用户管理', '39.149.247.210', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703864988', '1703864988', '1703864988');
INSERT INTO `tp_done_log` VALUES ('129', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703864989', '1703864989', '1703864989');
INSERT INTO `tp_done_log` VALUES ('130', '1', 'admin', '超级管理员组', '操作日志', '39.149.247.210', 'admin:log:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703864992', '1703864992', '1703864992');
INSERT INTO `tp_done_log` VALUES ('131', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703864997', '1703864997', '1703864997');
INSERT INTO `tp_done_log` VALUES ('132', '1', 'admin', '超级管理员组', '操作日志', '39.149.247.210', 'admin:log:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703865023', '1703865023', '1703865023');
INSERT INTO `tp_done_log` VALUES ('133', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703865030', '1703865030', '1703865030');
INSERT INTO `tp_done_log` VALUES ('134', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703865102', '1703865102', '1703865102');
INSERT INTO `tp_done_log` VALUES ('135', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":9,\"signature\":\"4a931b96e96b63f30315d40633864680\"}', '1703865104', '1703865104', '1703865104');
INSERT INTO `tp_done_log` VALUES ('136', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":8,\"signature\":\"d4e68380f7734f7c56f174c83251b1c5\"}', '1703865148', '1703865148', '1703865148');
INSERT INTO `tp_done_log` VALUES ('137', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1703865153', '1703865153', '1703865153');
INSERT INTO `tp_done_log` VALUES ('138', '1', 'admin', '超级管理员组', '查看文章栏目详情', '39.149.247.210', 'admin:cogencgcolumn:getinfo', '{\"id\":9,\"signature\":\"4a931b96e96b63f30315d40633864680\"}', '1703865154', '1703865154', '1703865154');
INSERT INTO `tp_done_log` VALUES ('139', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112808', '1704112808', '1704112808');
INSERT INTO `tp_done_log` VALUES ('140', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112810', '1704112810', '1704112810');
INSERT INTO `tp_done_log` VALUES ('141', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112812', '1704112812', '1704112812');
INSERT INTO `tp_done_log` VALUES ('142', '1', 'admin', '超级管理员组', '密钥管理', '39.149.247.210', 'admin:app:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112819', '1704112819', '1704112819');
INSERT INTO `tp_done_log` VALUES ('143', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112821', '1704112821', '1704112821');
INSERT INTO `tp_done_log` VALUES ('144', '1', 'admin', '超级管理员组', '用户管理', '39.149.247.210', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112822', '1704112822', '1704112822');
INSERT INTO `tp_done_log` VALUES ('145', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112823', '1704112823', '1704112823');
INSERT INTO `tp_done_log` VALUES ('146', '1', 'admin', '超级管理员组', '用户管理', '39.149.247.210', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112825', '1704112825', '1704112825');
INSERT INTO `tp_done_log` VALUES ('147', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112826', '1704112826', '1704112826');
INSERT INTO `tp_done_log` VALUES ('148', '1', 'admin', '超级管理员组', '操作日志', '39.149.247.210', 'admin:log:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112827', '1704112827', '1704112827');
INSERT INTO `tp_done_log` VALUES ('149', '1', 'admin', '超级管理员组', '部门详情', '39.149.247.210', 'admin:dept:getinfo', '{\"id\":1,\"signature\":\"4918c71c70d6d180a6dd4e4ad20d8f60\"}', '1704112832', '1704112832', '1704112832');
INSERT INTO `tp_done_log` VALUES ('150', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112839', '1704112839', '1704112839');
INSERT INTO `tp_done_log` VALUES ('151', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112843', '1704112843', '1704112843');
INSERT INTO `tp_done_log` VALUES ('152', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112848', '1704112848', '1704112848');
INSERT INTO `tp_done_log` VALUES ('153', '1', 'admin', '超级管理员组', '查看文章管理详情', '39.149.247.210', 'admin:cogencgarticle:getinfo', '{\"id\":20,\"signature\":\"d3a01e6c166efd456b79afa33819e7c6\"}', '1704112849', '1704112849', '1704112849');
INSERT INTO `tp_done_log` VALUES ('154', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112950', '1704112950', '1704112950');
INSERT INTO `tp_done_log` VALUES ('155', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112958', '1704112958', '1704112958');
INSERT INTO `tp_done_log` VALUES ('156', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704112960', '1704112960', '1704112960');
INSERT INTO `tp_done_log` VALUES ('157', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113154', '1704113154', '1704113154');
INSERT INTO `tp_done_log` VALUES ('158', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113196', '1704113196', '1704113196');
INSERT INTO `tp_done_log` VALUES ('159', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113208', '1704113208', '1704113208');
INSERT INTO `tp_done_log` VALUES ('160', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113217', '1704113217', '1704113217');
INSERT INTO `tp_done_log` VALUES ('161', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113229', '1704113229', '1704113229');
INSERT INTO `tp_done_log` VALUES ('162', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113237', '1704113237', '1704113237');
INSERT INTO `tp_done_log` VALUES ('163', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113258', '1704113258', '1704113258');
INSERT INTO `tp_done_log` VALUES ('164', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113280', '1704113280', '1704113280');
INSERT INTO `tp_done_log` VALUES ('165', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113381', '1704113381', '1704113381');
INSERT INTO `tp_done_log` VALUES ('166', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113394', '1704113394', '1704113394');
INSERT INTO `tp_done_log` VALUES ('167', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113478', '1704113478', '1704113478');
INSERT INTO `tp_done_log` VALUES ('168', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113531', '1704113531', '1704113531');
INSERT INTO `tp_done_log` VALUES ('169', '1', 'admin', '超级管理员组', '查看文章管理详情', '39.149.247.210', 'admin:cogencgarticle:getinfo', '{\"id\":20,\"signature\":\"d3a01e6c166efd456b79afa33819e7c6\"}', '1704113565', '1704113565', '1704113565');
INSERT INTO `tp_done_log` VALUES ('170', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113570', '1704113570', '1704113570');
INSERT INTO `tp_done_log` VALUES ('171', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113570', '1704113570', '1704113570');
INSERT INTO `tp_done_log` VALUES ('172', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113637', '1704113637', '1704113637');
INSERT INTO `tp_done_log` VALUES ('173', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":9,\"signature\":\"4a931b96e96b63f30315d40633864680\"}', '1704113642', '1704113642', '1704113642');
INSERT INTO `tp_done_log` VALUES ('174', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":6,\"signature\":\"10fa7ad77c2bd697f1176a48fd66a459\"}', '1704113650', '1704113650', '1704113650');
INSERT INTO `tp_done_log` VALUES ('175', '1', 'admin', '超级管理员组', '新增/修改', '39.149.247.210', 'admin:cogen:save', '{\"id\":6,\"table\":\"cg_categery\",\"comment\":\"\\u6587\\u7ae0\\u5206\\u7c7b\",\"search\":[\"name\"],\"lists\":[\"id\",\"cid\",\"name\",\"status\",\"sorts\",\"update_time\"],\"form\":[\"id\",\"cid\",\"name\",\"content\",\"status\",\"sorts\"],\"show_field\":[\"id\",\"cid\",\"name\",\"content\",\"status\",\"sorts\",\"create_time\",\"update_time\"],\"name\":\"cid\",\"islogin\":0,\"userid\":\"\",\"form_require\":[\"cid\",\"name\"],\"field_rule\":[{\"field\":\"id\",\"type\":\"int(10) unsigned\",\"comment\":\"ID\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"cid\",\"type\":\"int(10)\",\"comment\":\"\\u680f\\u76ee\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"cg_column\",\"name\"],\"idkey\":[\"cg_column\",\"id\"]},{\"field\":\"name\",\"type\":\"varchar(150)\",\"comment\":\"\\u540d\\u79f0\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"content\",\"type\":\"varchar(255)\",\"comment\":\"\\u63cf\\u8ff0\",\"query\":\"\",\"show\":\"textarea\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"status\",\"type\":\"tinyint(1)\",\"comment\":\"\\u72b6\\u6001\",\"query\":\"=\",\"show\":\"radio\",\"radio\":\"\",\"select\":\"\",\"option\":[]},{\"field\":\"sorts\",\"type\":\"int(3)\",\"comment\":\"\\u6392\\u5e8f\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]}],\"isauth\":0,\"signature\":\"98ad0689f9c0c12acf4eceb696839d88\"}', '1704113657', '1704113657', '1704113657');
INSERT INTO `tp_done_log` VALUES ('176', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704113657', '1704113657', '1704113657');
INSERT INTO `tp_done_log` VALUES ('177', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704114037', '1704114037', '1704114037');
INSERT INTO `tp_done_log` VALUES ('178', '1', 'admin', '超级管理员组', '查看文章栏目详情', '39.149.247.210', 'admin:cogencgcolumn:getinfo', '{\"id\":9,\"signature\":\"4a931b96e96b63f30315d40633864680\"}', '1704114039', '1704114039', '1704114039');
INSERT INTO `tp_done_log` VALUES ('179', '1', 'admin', '超级管理员组', '查看文章栏目详情', '39.149.247.210', 'admin:cogencgcolumn:getinfo', '{\"id\":6,\"signature\":\"10fa7ad77c2bd697f1176a48fd66a459\"}', '1704114063', '1704114063', '1704114063');
INSERT INTO `tp_done_log` VALUES ('180', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704117116', '1704117116', '1704117116');
INSERT INTO `tp_done_log` VALUES ('181', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704117166', '1704117166', '1704117166');
INSERT INTO `tp_done_log` VALUES ('182', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704117191', '1704117191', '1704117191');
INSERT INTO `tp_done_log` VALUES ('183', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704117193', '1704117193', '1704117193');
INSERT INTO `tp_done_log` VALUES ('184', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704117197', '1704117197', '1704117197');
INSERT INTO `tp_done_log` VALUES ('185', '1', 'admin', '超级管理员组', '查看文章管理详情', '39.149.247.210', 'admin:cogencgarticle:getinfo', '{\"id\":20,\"signature\":\"d3a01e6c166efd456b79afa33819e7c6\"}', '1704117199', '1704117199', '1704117199');
INSERT INTO `tp_done_log` VALUES ('186', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704117683', '1704117683', '1704117683');
INSERT INTO `tp_done_log` VALUES ('187', '1', 'admin', '超级管理员组', '文章栏目管理', '39.149.247.210', 'admin:cogencgcolumn:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704117709', '1704117709', '1704117709');
INSERT INTO `tp_done_log` VALUES ('188', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704117721', '1704117721', '1704117721');
INSERT INTO `tp_done_log` VALUES ('189', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704119057', '1704119057', '1704119057');
INSERT INTO `tp_done_log` VALUES ('190', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704119062', '1704119062', '1704119062');
INSERT INTO `tp_done_log` VALUES ('191', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":6,\"signature\":\"10fa7ad77c2bd697f1176a48fd66a459\"}', '1704119065', '1704119065', '1704119065');
INSERT INTO `tp_done_log` VALUES ('192', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":9,\"signature\":\"4a931b96e96b63f30315d40633864680\"}', '1704119072', '1704119072', '1704119072');
INSERT INTO `tp_done_log` VALUES ('193', '1', 'admin', '超级管理员组', '查看详情', '39.149.247.210', 'admin:cogen:getinfo', '{\"id\":6,\"signature\":\"10fa7ad77c2bd697f1176a48fd66a459\"}', '1704119078', '1704119078', '1704119078');
INSERT INTO `tp_done_log` VALUES ('194', '1', 'admin', '超级管理员组', '新增/修改', '39.149.247.210', 'admin:cogen:save', '{\"id\":6,\"table\":\"cg_categery\",\"comment\":\"\\u6587\\u7ae0\\u5206\\u7c7b\",\"search\":[\"name\"],\"lists\":[\"id\",\"cid\",\"name\",\"status\",\"sorts\",\"update_time\"],\"form\":[\"id\",\"cid\",\"name\",\"content\",\"status\",\"sorts\"],\"show_field\":[\"id\",\"cid\",\"name\",\"content\",\"status\",\"sorts\",\"create_time\",\"update_time\"],\"name\":\"cid\",\"islogin\":0,\"userid\":\"\",\"form_require\":[\"cid\",\"name\"],\"field_rule\":[{\"field\":\"id\",\"type\":\"int(10) unsigned\",\"comment\":\"ID\",\"query\":\"\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"cid\",\"type\":\"int(10)\",\"comment\":\"\\u680f\\u76ee\",\"query\":\"\",\"show\":\"select\",\"radio\":[],\"select\":\"\",\"option\":[\"cg_column\",\"name\"],\"idkey\":[\"cg_column\",\"id\"]},{\"field\":\"name\",\"type\":\"varchar(150)\",\"comment\":\"\\u540d\\u79f0\",\"query\":\"like\",\"show\":\"text\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"content\",\"type\":\"varchar(255)\",\"comment\":\"\\u63cf\\u8ff0\",\"query\":\"\",\"show\":\"textarea\",\"radio\":[],\"select\":\"\",\"option\":[]},{\"field\":\"status\",\"type\":\"tinyint(1)\",\"comment\":\"\\u72b6\\u6001\",\"query\":\"=\",\"show\":\"radio\",\"radio\":\"{\\\"0\\\":\\\"\\u7981\\u7528\\\",\\\"1\\\":\\\"\\u6b63\\u5e38\\\"}\",\"select\":\"\",\"option\":[]},{\"field\":\"sorts\",\"type\":\"int(3)\",\"comment\":\"\\u6392\\u5e8f\",\"query\":\"\",\"show\":\"number\",\"radio\":[],\"select\":\"\",\"option\":[]}],\"isauth\":0,\"signature\":\"2c602f58948f5f167dc0447f0ddd71f7\"}', '1704119083', '1704119083', '1704119083');
INSERT INTO `tp_done_log` VALUES ('195', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704119083', '1704119083', '1704119083');
INSERT INTO `tp_done_log` VALUES ('196', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704119085', '1704119085', '1704119085');
INSERT INTO `tp_done_log` VALUES ('197', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704119197', '1704119197', '1704119197');
INSERT INTO `tp_done_log` VALUES ('198', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704119356', '1704119356', '1704119356');
INSERT INTO `tp_done_log` VALUES ('199', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704119887', '1704119887', '1704119887');
INSERT INTO `tp_done_log` VALUES ('200', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704119952', '1704119952', '1704119952');
INSERT INTO `tp_done_log` VALUES ('201', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704120047', '1704120047', '1704120047');
INSERT INTO `tp_done_log` VALUES ('202', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704120165', '1704120165', '1704120165');
INSERT INTO `tp_done_log` VALUES ('203', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704120168', '1704120168', '1704120168');
INSERT INTO `tp_done_log` VALUES ('204', '1', 'admin', '超级管理员组', '查看文章分类详情', '39.149.247.210', 'admin:cogencgcategery:getinfo', '{\"id\":5,\"signature\":\"8a260f529b6b9d08d2687406daa5845b\"}', '1704120172', '1704120172', '1704120172');
INSERT INTO `tp_done_log` VALUES ('205', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704120181', '1704120181', '1704120181');
INSERT INTO `tp_done_log` VALUES ('206', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704120194', '1704120194', '1704120194');
INSERT INTO `tp_done_log` VALUES ('207', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704120197', '1704120197', '1704120197');
INSERT INTO `tp_done_log` VALUES ('208', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704120200', '1704120200', '1704120200');
INSERT INTO `tp_done_log` VALUES ('209', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704120204', '1704120204', '1704120204');
INSERT INTO `tp_done_log` VALUES ('210', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704120407', '1704120407', '1704120407');
INSERT INTO `tp_done_log` VALUES ('211', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704120429', '1704120429', '1704120429');
INSERT INTO `tp_done_log` VALUES ('212', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704120935', '1704120935', '1704120935');
INSERT INTO `tp_done_log` VALUES ('213', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121004', '1704121004', '1704121004');
INSERT INTO `tp_done_log` VALUES ('214', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121008', '1704121008', '1704121008');
INSERT INTO `tp_done_log` VALUES ('215', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121067', '1704121067', '1704121067');
INSERT INTO `tp_done_log` VALUES ('216', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121196', '1704121196', '1704121196');
INSERT INTO `tp_done_log` VALUES ('217', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121245', '1704121245', '1704121245');
INSERT INTO `tp_done_log` VALUES ('218', '1', 'admin', '超级管理员组', '查看文章分类详情', '39.149.247.210', 'admin:cogencgcategery:getinfo', '{\"id\":5,\"signature\":\"8a260f529b6b9d08d2687406daa5845b\"}', '1704121247', '1704121247', '1704121247');
INSERT INTO `tp_done_log` VALUES ('219', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121262', '1704121262', '1704121262');
INSERT INTO `tp_done_log` VALUES ('220', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121279', '1704121279', '1704121279');
INSERT INTO `tp_done_log` VALUES ('221', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121348', '1704121348', '1704121348');
INSERT INTO `tp_done_log` VALUES ('222', '1', 'admin', '超级管理员组', '查看文章栏目详情', '39.149.247.210', 'admin:cogencgcolumn:getinfo', '{\"id\":1,\"signature\":\"4918c71c70d6d180a6dd4e4ad20d8f60\"}', '1704121352', '1704121352', '1704121352');
INSERT INTO `tp_done_log` VALUES ('223', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121432', '1704121432', '1704121432');
INSERT INTO `tp_done_log` VALUES ('224', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121463', '1704121463', '1704121463');
INSERT INTO `tp_done_log` VALUES ('225', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121480', '1704121480', '1704121480');
INSERT INTO `tp_done_log` VALUES ('226', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121487', '1704121487', '1704121487');
INSERT INTO `tp_done_log` VALUES ('227', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121489', '1704121489', '1704121489');
INSERT INTO `tp_done_log` VALUES ('228', '1', 'admin', '超级管理员组', '查看文章栏目详情', '39.149.247.210', 'admin:cogencgcolumn:getinfo', '{\"id\":1,\"signature\":\"4918c71c70d6d180a6dd4e4ad20d8f60\"}', '1704121492', '1704121492', '1704121492');
INSERT INTO `tp_done_log` VALUES ('229', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121501', '1704121501', '1704121501');
INSERT INTO `tp_done_log` VALUES ('230', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121504', '1704121504', '1704121504');
INSERT INTO `tp_done_log` VALUES ('231', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121516', '1704121516', '1704121516');
INSERT INTO `tp_done_log` VALUES ('232', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121639', '1704121639', '1704121639');
INSERT INTO `tp_done_log` VALUES ('233', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121840', '1704121840', '1704121840');
INSERT INTO `tp_done_log` VALUES ('234', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121891', '1704121891', '1704121891');
INSERT INTO `tp_done_log` VALUES ('235', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121899', '1704121899', '1704121899');
INSERT INTO `tp_done_log` VALUES ('236', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":2,\"psize\":10,\"signature\":\"8a0f0174bea8b7b5d535975f5f6ef69c\"}', '1704121906', '1704121906', '1704121906');
INSERT INTO `tp_done_log` VALUES ('237', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704121907', '1704121907', '1704121907');
INSERT INTO `tp_done_log` VALUES ('238', '1', 'admin', '超级管理员组', '查看文章栏目详情', '39.149.247.210', 'admin:cogencgcolumn:getinfo', '{\"id\":2,\"signature\":\"e84e07e66af3c61c2846c47344ae0774\"}', '1704121940', '1704121940', '1704121940');
INSERT INTO `tp_done_log` VALUES ('239', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122196', '1704122196', '1704122196');
INSERT INTO `tp_done_log` VALUES ('240', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122199', '1704122199', '1704122199');
INSERT INTO `tp_done_log` VALUES ('241', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122236', '1704122236', '1704122236');
INSERT INTO `tp_done_log` VALUES ('242', '1', 'admin', '超级管理员组', '操作日志', '39.149.247.210', 'admin:log:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122283', '1704122283', '1704122283');
INSERT INTO `tp_done_log` VALUES ('243', '1', 'admin', '超级管理员组', '用户管理', '39.149.247.210', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122613', '1704122613', '1704122613');
INSERT INTO `tp_done_log` VALUES ('244', '1', 'admin', '超级管理员组', '角色管理', '39.149.247.210', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122614', '1704122614', '1704122614');
INSERT INTO `tp_done_log` VALUES ('245', '1', 'admin', '超级管理员组', '操作日志', '39.149.247.210', 'admin:log:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122619', '1704122619', '1704122619');
INSERT INTO `tp_done_log` VALUES ('246', '1', 'admin', '超级管理员组', '密钥管理', '39.149.247.210', 'admin:app:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122630', '1704122630', '1704122630');
INSERT INTO `tp_done_log` VALUES ('247', '1', 'admin', '超级管理员组', '代码生成', '39.149.247.210', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122632', '1704122632', '1704122632');
INSERT INTO `tp_done_log` VALUES ('248', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122636', '1704122636', '1704122636');
INSERT INTO `tp_done_log` VALUES ('249', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122639', '1704122639', '1704122639');
INSERT INTO `tp_done_log` VALUES ('250', '1', 'admin', '超级管理员组', '查看文章栏目详情', '39.149.247.210', 'admin:cogencgcolumn:getinfo', '{\"id\":1,\"signature\":\"4918c71c70d6d180a6dd4e4ad20d8f60\"}', '1704122645', '1704122645', '1704122645');
INSERT INTO `tp_done_log` VALUES ('251', '1', 'admin', '超级管理员组', '查看文章栏目详情', '39.149.247.210', 'admin:cogencgcolumn:getinfo', '{\"id\":2,\"signature\":\"e84e07e66af3c61c2846c47344ae0774\"}', '1704122649', '1704122649', '1704122649');
INSERT INTO `tp_done_log` VALUES ('252', '1', 'admin', '超级管理员组', '查看文章栏目详情', '39.149.247.210', 'admin:cogencgcolumn:getinfo', '{\"id\":9,\"signature\":\"4a931b96e96b63f30315d40633864680\"}', '1704122655', '1704122655', '1704122655');
INSERT INTO `tp_done_log` VALUES ('253', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122658', '1704122658', '1704122658');
INSERT INTO `tp_done_log` VALUES ('254', '1', 'admin', '超级管理员组', '查看文章管理详情', '39.149.247.210', 'admin:cogencgarticle:getinfo', '{\"id\":20,\"signature\":\"d3a01e6c166efd456b79afa33819e7c6\"}', '1704122682', '1704122682', '1704122682');
INSERT INTO `tp_done_log` VALUES ('255', '1', 'admin', '超级管理员组', '新增/修改文章管理', '39.149.247.210', 'admin:cogencgarticle:save', '{\"id\":20,\"title\":\"\\u6587\\u7ae0\\u6d4b\\u8bd5\\u6807\\u9898\",\"dept_id\":1,\"userid\":1,\"cid\":2,\"cate\":\"\\u9996\\u53d1\\u65b0\\u8bfe,\\u70ed\\u95e8\\u63a8\\u8350\",\"notes\":\"\",\"content\":\"<p>123<\\/p>\",\"status\":1,\"sorts\":100,\"types\":1,\"img\":\"\",\"visit_num\":0,\"video\":\"\",\"author\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"add_time\":1685585436,\"start_time\":0,\"end_time\":0,\"signature\":\"df3dede4efd1431386724a0d4d929ff0\"}', '1704122688', '1704122688', '1704122688');
INSERT INTO `tp_done_log` VALUES ('256', '1', 'admin', '超级管理员组', '新增/修改文章管理', '39.149.247.210', 'admin:cogencgarticle:save', '{\"id\":20,\"title\":\"\\u6587\\u7ae0\\u6d4b\\u8bd5\\u6807\\u9898\",\"dept_id\":1,\"userid\":1,\"cid\":2,\"cate\":\"\\u9996\\u53d1\\u65b0\\u8bfe,\\u70ed\\u95e8\\u63a8\\u8350\",\"notes\":\"\",\"content\":\"<p>123<\\/p>\",\"status\":1,\"sorts\":100,\"types\":1,\"img\":\"\",\"visit_num\":0,\"video\":\"\",\"author\":\"\\u8d85\\u7ea7\\u7ba1\\u7406\\u5458\",\"add_time\":1685585436,\"start_time\":0,\"end_time\":0,\"signature\":\"df3dede4efd1431386724a0d4d929ff0\"}', '1704122773', '1704122773', '1704122773');
INSERT INTO `tp_done_log` VALUES ('257', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122773', '1704122773', '1704122773');
INSERT INTO `tp_done_log` VALUES ('258', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122775', '1704122775', '1704122775');
INSERT INTO `tp_done_log` VALUES ('259', '1', 'admin', '超级管理员组', '删除文章管理', '39.149.247.210', 'admin:cogencgarticle:del', '{\"id\":20,\"signature\":\"d3a01e6c166efd456b79afa33819e7c6\"}', '1704122791', '1704122791', '1704122791');
INSERT INTO `tp_done_log` VALUES ('260', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122791', '1704122791', '1704122791');
INSERT INTO `tp_done_log` VALUES ('261', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122792', '1704122792', '1704122792');
INSERT INTO `tp_done_log` VALUES ('262', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122794', '1704122794', '1704122794');
INSERT INTO `tp_done_log` VALUES ('263', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"title\":\"<?php  declare (strict_types=1);  namespace app\\\\admin\\\\controller;  use think\\\\annotation\\\\route\\\\Group; use think\\\\annotation\\\\Route; use think\\\\annotation\\\\route\\\\Middleware; use app\\\\admin\\\\controller\\\\Base; use app\\\\admin\\\\middleware\\\\CheckAdmin; use think\\\\facade\\\\Db;  \\/**  * \\u6570\\u636e\\u7edf\\u8ba1  * Class Statistics  * @package app\\\\admin\\\\controller  * @author  hardphp\\uff082066362155@qq.com\\uff09  * @Group(\\\"statistics\\\")  * @Middleware({CheckAdmin::class})  *\\/ class Statistics extends Base {     \\/**       *       * @Route(\\\"index\\\", method=\\\"POST\\\")       *\\/     public function index()     {          $col_num = Db::name(\'cg_column\')->where(true)->count();         $art_num = Db::name(\'cg_article\')->where(true)->count();         $user_num = Db::name(\'user\')->where(true)->count();         $bao_num = Db::name(\'user_article\')->where(\'types\',1)->count();          $data[\'homeOne\'] = [             [\'num1\'=>$col_num ,\'num2\'=>0,\'num3\'=>\'\\u680f\\u76ee\\u6570\\u91cf\'],             [\'num1\'=>$art_num,\'num2\'=>0,\'num3\'=>\'\\u6587\\u7ae0\\u6570\\u91cf\'],             [\'num1\'=>$user_num,\'num2\'=>0,\'num3\'=>\'\\u7528\\u6237\\u6570\\u91cf\'],             [\'num1\'=>$bao_num,\'num2\'=>0,\'num3\'=>\'\\u62a5\\u540d\\u6570\\u91cf\'],         ];          $act_num = Db::name(\'cg_article\')->where(\'cid\',7)->count();         $video_num = Db::name(\'cg_article\')->where(\'cid\',8)->count();         $link_num = Db::name(\'cg_links\')->where(true)->count();         $xuexi_num = 0;          $data[\'homeThree\'] = [             [\'label\'=>\'\\u6d3b\\u52a8\\u6570\\u91cf\',\'value\'=>$act_num],             [\'label\'=>\'\\u8bfe\\u7a0b\\u6570\\u91cf\',\'value\'=> $video_num],             [\'label\'=>\'\\u94fe\\u63a5\\u6570\\u91cf\',\'value\'=>$link_num ],             [\'label\'=>\'\\u5b66\\u4e60\\u4eba\\u6570\',\'value\'=>$xuexi_num],         ];           \\/\\/\\u6700\\u8fd1\\u4e24\\u5468         \\/\\/ \\u83b7\\u53d6\\u5f53\\u524d\\u65e5\\u671f         $currentDate = date(\'Y-m-d\');         \\/\\/ \\u83b7\\u53d6\\u4e24\\u5468\\u524d\\u7684\\u65e5\\u671f         $twoWeeksAgo = date(\'Y-m-d\', strtotime(\'-2 weeks\'));          \\/\\/ \\u8f93\\u51fa\\u6700\\u8fd1\\u4e24\\u5468\\u7684\\u65e5\\u671f         for ($i = 13; $i >= 0; $i--) {             $date = date(\'Y-m-d\', strtotime(\\\"-$i days\\\"));             if ($date >= $twoWeeksAgo && $date <= $currentDate) {             $data[\'daydata\'][]=$date;             }         }          $news = [];          $days =  Db::name(\'user\')->where(\'create_time\',\'>=\',strtotime($twoWeeksAgo))->order([\'create_time\'=>\'asc\'])->select()->toArray();         foreach($days as $v){             $todayStart = date(\'Y-m-d\', $v[\'create_time\']);             if(isset($news[$todayStart])){                 $news[$todayStart]++;             }else{                 $news[$todayStart] = 1;             }         }          foreach ($data[\'daydata\'] as $v) {                          if(isset($news[$v])) {                 $data[\'timedata\'][]=$news[$v];             } else {                 $data[\'timedata\'][]=0;             }         }             return json_ok($data);     } }\",\"signature\":\"896dd2ea9925442d7758b7cfd2423c86\"}', '1704122798', '1704122798', '1704122798');
INSERT INTO `tp_done_log` VALUES ('264', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"title\":\"12\",\"signature\":\"a9f0eb6a00b88432bc3a0a09324354d2\"}', '1704122802', '1704122802', '1704122802');
INSERT INTO `tp_done_log` VALUES ('265', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122804', '1704122804', '1704122804');
INSERT INTO `tp_done_log` VALUES ('266', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122840', '1704122840', '1704122840');
INSERT INTO `tp_done_log` VALUES ('267', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122845', '1704122845', '1704122845');
INSERT INTO `tp_done_log` VALUES ('268', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122849', '1704122849', '1704122849');
INSERT INTO `tp_done_log` VALUES ('269', '1', 'admin', '超级管理员组', '查看文章分类详情', '39.149.247.210', 'admin:cogencgcategery:getinfo', '{\"id\":5,\"signature\":\"8a260f529b6b9d08d2687406daa5845b\"}', '1704122853', '1704122853', '1704122853');
INSERT INTO `tp_done_log` VALUES ('270', '1', 'admin', '超级管理员组', '查看文章栏目详情', '39.149.247.210', 'admin:cogencgcolumn:getinfo', '{\"id\":1,\"signature\":\"4918c71c70d6d180a6dd4e4ad20d8f60\"}', '1704122856', '1704122856', '1704122856');
INSERT INTO `tp_done_log` VALUES ('271', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122877', '1704122877', '1704122877');
INSERT INTO `tp_done_log` VALUES ('272', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122877', '1704122877', '1704122877');
INSERT INTO `tp_done_log` VALUES ('273', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122878', '1704122878', '1704122878');
INSERT INTO `tp_done_log` VALUES ('274', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122879', '1704122879', '1704122879');
INSERT INTO `tp_done_log` VALUES ('275', '1', 'admin', '超级管理员组', '查看文章栏目详情', '39.149.247.210', 'admin:cogencgcolumn:getinfo', '{\"id\":1,\"signature\":\"4918c71c70d6d180a6dd4e4ad20d8f60\"}', '1704122881', '1704122881', '1704122881');
INSERT INTO `tp_done_log` VALUES ('276', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122884', '1704122884', '1704122884');
INSERT INTO `tp_done_log` VALUES ('277', '1', 'admin', '超级管理员组', '查看文章管理详情', '39.149.247.210', 'admin:cogencgarticle:getinfo', '{\"id\":19,\"signature\":\"b581d73929d7482af39a70d4667b5d52\"}', '1704122886', '1704122886', '1704122886');
INSERT INTO `tp_done_log` VALUES ('278', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122915', '1704122915', '1704122915');
INSERT INTO `tp_done_log` VALUES ('279', '1', 'admin', '超级管理员组', '文章管理管理', '39.149.247.210', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122916', '1704122916', '1704122916');
INSERT INTO `tp_done_log` VALUES ('280', '1', 'admin', '超级管理员组', '文章分类管理', '39.149.247.210', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704122917', '1704122917', '1704122917');
INSERT INTO `tp_done_log` VALUES ('281', '1', 'admin', '超级管理员组', '用户管理', '223.88.45.24', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704181165', '1704181165', '1704181165');
INSERT INTO `tp_done_log` VALUES ('282', '1', 'admin', '超级管理员组', '角色管理', '223.88.45.24', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704181168', '1704181168', '1704181168');
INSERT INTO `tp_done_log` VALUES ('283', '1', 'admin', '超级管理员组', '操作日志', '223.88.45.24', 'admin:log:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704181171', '1704181171', '1704181171');
INSERT INTO `tp_done_log` VALUES ('284', '1', 'admin', '超级管理员组', '密钥管理', '223.88.45.24', 'admin:app:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704181175', '1704181175', '1704181175');
INSERT INTO `tp_done_log` VALUES ('285', '1', 'admin', '超级管理员组', '代码生成', '223.88.45.24', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704181177', '1704181177', '1704181177');
INSERT INTO `tp_done_log` VALUES ('286', '1', 'admin', '超级管理员组', '文章分类管理', '223.88.45.24', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704181182', '1704181182', '1704181182');
INSERT INTO `tp_done_log` VALUES ('287', '1', 'admin', '超级管理员组', '查看文章分类详情', '223.88.45.24', 'admin:cogencgcategery:getinfo', '{\"id\":5,\"signature\":\"8a260f529b6b9d08d2687406daa5845b\"}', '1704181184', '1704181184', '1704181184');
INSERT INTO `tp_done_log` VALUES ('288', '1', 'admin', '超级管理员组', '查看文章栏目详情', '223.88.45.24', 'admin:cogencgcolumn:getinfo', '{\"id\":1,\"signature\":\"4918c71c70d6d180a6dd4e4ad20d8f60\"}', '1704181190', '1704181190', '1704181190');
INSERT INTO `tp_done_log` VALUES ('289', '1', 'admin', '超级管理员组', '文章管理管理', '223.88.45.24', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704181198', '1704181198', '1704181198');
INSERT INTO `tp_done_log` VALUES ('290', '1', 'admin', '超级管理员组', '文章管理管理', '223.88.45.24', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704181348', '1704181348', '1704181348');
INSERT INTO `tp_done_log` VALUES ('291', '1', 'admin', '超级管理员组', '代码生成', '223.88.45.24', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704182784', '1704182784', '1704182784');
INSERT INTO `tp_done_log` VALUES ('292', '1', 'admin', '超级管理员组', '查看详情', '223.88.45.24', 'admin:cogen:getinfo', '{\"id\":9,\"signature\":\"4a931b96e96b63f30315d40633864680\"}', '1704182786', '1704182786', '1704182786');
INSERT INTO `tp_done_log` VALUES ('293', '1', 'admin', '超级管理员组', '角色管理', '223.88.45.24', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704186547', '1704186547', '1704186547');
INSERT INTO `tp_done_log` VALUES ('294', '1', 'admin', '超级管理员组', '代码生成', '223.88.45.24', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704186550', '1704186550', '1704186550');
INSERT INTO `tp_done_log` VALUES ('295', '1', 'admin', '超级管理员组', '密钥管理', '223.88.45.24', 'admin:app:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704186551', '1704186551', '1704186551');
INSERT INTO `tp_done_log` VALUES ('296', '1', 'admin', '超级管理员组', '文章管理管理', '223.88.45.24', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704186552', '1704186552', '1704186552');
INSERT INTO `tp_done_log` VALUES ('297', '1', 'admin', '超级管理员组', '文章分类管理', '223.88.45.24', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704186558', '1704186558', '1704186558');
INSERT INTO `tp_done_log` VALUES ('298', '1', 'admin', '超级管理员组', '用户管理', '223.88.45.24', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704187043', '1704187043', '1704187043');
INSERT INTO `tp_done_log` VALUES ('299', '1', 'admin', '超级管理员组', '查看用户详情', '223.88.45.24', 'admin:admin:getinfo', '{\"id\":1,\"signature\":\"4918c71c70d6d180a6dd4e4ad20d8f60\"}', '1704187047', '1704187047', '1704187047');
INSERT INTO `tp_done_log` VALUES ('300', '1', 'admin', '超级管理员组', '角色管理', '223.88.45.24', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704187058', '1704187058', '1704187058');
INSERT INTO `tp_done_log` VALUES ('301', '1', 'admin', '超级管理员组', '查看角色详情', '223.88.45.24', 'admin:groups:getinfo', '{\"id\":1,\"signature\":\"4918c71c70d6d180a6dd4e4ad20d8f60\"}', '1704187059', '1704187059', '1704187059');
INSERT INTO `tp_done_log` VALUES ('302', '1', 'admin', '超级管理员组', '代码生成', '223.88.45.24', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704187095', '1704187095', '1704187095');
INSERT INTO `tp_done_log` VALUES ('303', '1', 'admin', '超级管理员组', '文章管理管理', '223.88.45.24', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704187118', '1704187118', '1704187118');
INSERT INTO `tp_done_log` VALUES ('304', '1', 'admin', '超级管理员组', '查看文章管理详情', '223.88.45.24', 'admin:cogencgarticle:getinfo', '{\"id\":19,\"signature\":\"b581d73929d7482af39a70d4667b5d52\"}', '1704187120', '1704187120', '1704187120');
INSERT INTO `tp_done_log` VALUES ('305', '1', 'admin', '超级管理员组', '查看文章管理详情', '223.88.45.24', 'admin:cogencgarticle:getinfo', '{\"id\":19,\"signature\":\"b581d73929d7482af39a70d4667b5d52\"}', '1704187138', '1704187138', '1704187138');
INSERT INTO `tp_done_log` VALUES ('306', '1', 'admin', '超级管理员组', '用户管理', '223.104.122.31', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704188268', '1704188268', '1704188268');
INSERT INTO `tp_done_log` VALUES ('307', '1', 'admin', '超级管理员组', '角色管理', '223.104.122.31', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704188270', '1704188270', '1704188270');
INSERT INTO `tp_done_log` VALUES ('308', '1', 'admin', '超级管理员组', '代码生成', '223.104.122.31', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704188281', '1704188281', '1704188281');
INSERT INTO `tp_done_log` VALUES ('309', '1', 'admin', '超级管理员组', '用户管理', '59.37.3.98', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704188344', '1704188344', '1704188344');
INSERT INTO `tp_done_log` VALUES ('310', '1', 'admin', '超级管理员组', '操作日志', '59.37.3.98', 'admin:log:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704188351', '1704188351', '1704188351');
INSERT INTO `tp_done_log` VALUES ('311', '1', 'admin', '超级管理员组', '密钥管理', '59.37.3.98', 'admin:app:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704188361', '1704188361', '1704188361');
INSERT INTO `tp_done_log` VALUES ('312', '1', 'admin', '超级管理员组', '用户管理', '180.169.254.2', 'admin:admin:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704188369', '1704188369', '1704188369');
INSERT INTO `tp_done_log` VALUES ('313', '1', 'admin', '超级管理员组', '代码生成', '59.37.3.98', 'admin:cogen:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704188373', '1704188373', '1704188373');
INSERT INTO `tp_done_log` VALUES ('314', '1', 'admin', '超级管理员组', '角色管理', '180.169.254.2', 'admin:groups:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704188374', '1704188374', '1704188374');
INSERT INTO `tp_done_log` VALUES ('315', '1', 'admin', '超级管理员组', '密钥管理', '180.169.254.2', 'admin:app:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704188390', '1704188390', '1704188390');
INSERT INTO `tp_done_log` VALUES ('316', '1', 'admin', '超级管理员组', '文章分类管理', '59.37.3.98', 'admin:cogencgcategery:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704188408', '1704188408', '1704188408');
INSERT INTO `tp_done_log` VALUES ('317', '1', 'admin', '超级管理员组', '文章管理管理', '59.37.3.98', 'admin:cogencgarticle:index', '{\"page\":1,\"psize\":10,\"signature\":\"32a8ecfaa0234c92aa1478b6bf4605ac\"}', '1704188423', '1704188423', '1704188423');

-- ----------------------------
-- Table structure for tp_failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `tp_failed_jobs`;
CREATE TABLE `tp_failed_jobs` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) DEFAULT '1' COMMENT '1=小程序，2=短信',
  `data` text COMMENT '数据',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='队列失败任务记录';

-- ----------------------------
-- Records of tp_failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for tp_files
-- ----------------------------
DROP TABLE IF EXISTS `tp_files`;
CREATE TABLE `tp_files` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT '' COMMENT '标题',
  `hash` varchar(50) DEFAULT '' COMMENT 'hash',
  `size` int(10) DEFAULT '0' COMMENT '文件大小',
  `types` tinyint(2) DEFAULT '0' COMMENT '文件类型 :1= 图片，2=视频，3=附件',
  `url` varchar(255) DEFAULT NULL COMMENT '文件地址',
  `mine` varchar(150) DEFAULT NULL COMMENT '文件mine类型',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tp_files
-- ----------------------------
INSERT INTO `tp_files` VALUES ('1', 'avatar.png', '3f31ddb2666e24bf288bdbaa3a7efe3b57a2748b', '2021', '1', '\'http://www.hardphp.com\'/storage/images/20230627/652891011b0c2e7f054ef12ade82dd13.png', 'image/png', '1687859975', '1687859975');
INSERT INTO `tp_files` VALUES ('2', 'ku.jpg', 'df09c353a4e51af1da880bd839e5ae2066abc87f', '28236', '1', '\'http://www.hardphp.com\'/storage/images/20230628/3fef0a4b713c08703aa3049c8a3e6431.jpg', 'image/jpeg', '1687924974', '1687924974');
INSERT INTO `tp_files` VALUES ('3', '未命名码 (1).png', 'd6d75a7c25dde47deaf9b52f1f0caeef01a3c347', '2509', '1', '\'http://www.hardphp.com\'/storage/images/20230713/9a303dbea3ae21185ab66ee556ae119b.png', 'image/png', '1689218189', '1689218189');
INSERT INTO `tp_files` VALUES ('4', '未命名码 (1).png', 'd6d75a7c25dde47deaf9b52f1f0caeef01a3c347', '2509', '1', '\'http://www.hardphp.com\'/storage/images/20230713/396a56edc267286d53c8029ac5d08c59.png', 'image/png', '1689218202', '1689218202');
INSERT INTO `tp_files` VALUES ('5', '未命名码 (1).png', 'd6d75a7c25dde47deaf9b52f1f0caeef01a3c347', '2509', '1', 'http://www.hardphp.com/storage/images/20230713/eddd0d36ba34b606cb3363b77a722d8e.png', 'image/png', '1689218225', '1689218225');
INSERT INTO `tp_files` VALUES ('6', '未命名码.png', 'd6d75a7c25dde47deaf9b52f1f0caeef01a3c347', '2509', '1', 'http://www.hardphp.com/storage/images/20230713/b6c2edc67698cce13130b72915d99b5f.png', 'image/png', '1689219437', '1689219437');
INSERT INTO `tp_files` VALUES ('7', '微信图片_20221202085028.png', 'b81a4b0c0a6a4c9e30029525c973ca94af1d2654', '161669', '1', 'http://www.hardphp.com/storage/images/20230721/2cced49c8f5ef298a15ab460561d222a.png', 'image/png', '1689924523', '1689924523');
INSERT INTO `tp_files` VALUES ('8', '51691689913218_.pic_hd (1).jpg', '518ea48d5ec33f99eb4b4cd57a20dba017cb64fc', '188752', '1', 'http://www.hardphp.com/storage/images/20230802/7c2f6b32d340e5977dce0f843b0c193f.jpg', 'image/jpeg', '1690940464', '1690940464');
INSERT INTO `tp_files` VALUES ('9', 'ok.jpg', 'aa4b7bee1d4de5a653f63906c931376f7cadda69', '89273', '1', 'http://www.hardphp.com/storage/images/20230804/ea5c5ffe09c67e7bc508ecfe3cb8de42.jpg', 'image/jpeg', '1691132244', '1691132244');
INSERT INTO `tp_files` VALUES ('10', '公众号次图.jpg', 'aca91fa097c412c036ffadf006a93efc6bf0b18c', '132530', '1', 'http://www.hardphp.com/storage/images/20230821/0276fa2d5a93bc1111a23de58e226f63.jpg', 'image/jpeg', '1692618362', '1692618362');
INSERT INTO `tp_files` VALUES ('11', 'WeChat_20221202095150.mp4', '0fe6de37caca52ac72e68799c7a4f3f4e9363d9c', '4747104', '2', 'http://www.hardphp.com/storage/vedios/20230821/31ad5fd07af782d34e73a61a7052a2a0.mp4', 'video/mp4', '1692618370', '1692618370');
INSERT INTO `tp_files` VALUES ('12', '公众号次图.jpg', 'aca91fa097c412c036ffadf006a93efc6bf0b18c', '132530', '1', 'http://www.hardphp.com/storage/images/20230822/232133ead56d119ced2e2fbf4e17b752.jpg', 'image/jpeg', '1692669953', '1692699640');
INSERT INTO `tp_files` VALUES ('13', 'AI.png', '39b1e1b7797b1fb6a3640e8cea3f52eb65214681', '88386', '1', 'http://www.hardphp.com/storage/images/20231220/d8e23c8273691482de407a9fb14d0344.png', 'image/png', '1703044869', '1703044869');
INSERT INTO `tp_files` VALUES ('14', '7.png', 'e2f20dfc0c11934814d050e80a174a9689e4a7be', '38304', '1', 'http://www.hardphp.com/storage/images/20231229/9dcd03cdb51c3458bf7ae11d7c49a4ac.png', 'image/png', '1703784027', '1703784027');
INSERT INTO `tp_files` VALUES ('15', 'about-widget-person.jpg', 'e269188b59a0dc3200a6c1d367a9cd48159a7551', '11189', '1', 'http://www.hardphp.com/storage/images/20231229/90e94be36e6067f5d6faf54601f121b1.jpg', 'image/jpeg', '1703784068', '1703784068');
INSERT INTO `tp_files` VALUES ('16', '简约插画引导关注抖音背景图 (1).jpg', '17056535546b6670880c41553cb6b3a22e6f7625', '1035115', '1', '\'\'/storage/images/20231229/6f4f528e02eb24d9d89ec3ca8c6b8412.jpg', 'image/jpeg', '1703865173', '1703865173');
INSERT INTO `tp_files` VALUES ('17', '1_1700640101.mp4', '18b2bda1635d65a113246846db43c7334f3aa837', '498280', '2', '\'\'/storage/vedios/20240101/e8a245d465b62f44332561d2fc2636fe.mp4', 'video/mp4', '1704112927', '1704112927');

-- ----------------------------
-- Table structure for tp_notice_send_log
-- ----------------------------
DROP TABLE IF EXISTS `tp_notice_send_log`;
CREATE TABLE `tp_notice_send_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) DEFAULT '1' COMMENT '1=小程序，2=公众号，3=短信',
  `data` text COMMENT '数据',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `result` text COMMENT '结果',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COMMENT='通知消息发送记录';

-- ----------------------------
-- Records of tp_notice_send_log
-- ----------------------------

-- ----------------------------
-- Table structure for tp_sms
-- ----------------------------
DROP TABLE IF EXISTS `tp_sms`;
CREATE TABLE `tp_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone` varchar(200) NOT NULL COMMENT '手机号',
  `code` varchar(10) NOT NULL COMMENT '验证码',
  `ip` varchar(50) NOT NULL COMMENT 'ip地址',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=注册，2=登录，3=找回密码',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 未使用，1已使用',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `content` text COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='短信邮件发送';

-- ----------------------------
-- Records of tp_sms
-- ----------------------------
INSERT INTO `tp_sms` VALUES ('1', '1247875312@qq.com', '079573', '0.0.0.0', '1689246356', '1', '0', '1689245756', '1689242717', null);
INSERT INTO `tp_sms` VALUES ('2', '1247875312123@qq.com', '275919', '115.57.53.147', '1689245538', '1', '0', '1689244938', '1689244160', null);

-- ----------------------------
-- Table structure for tp_system_config
-- ----------------------------
DROP TABLE IF EXISTS `tp_system_config`;
CREATE TABLE `tp_system_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mark` varchar(255) DEFAULT '' COMMENT '标志',
  `title` varchar(255) DEFAULT '' COMMENT '配置标题',
  `value` text COMMENT '配置值',
  `sorts` int(3) DEFAULT '50' COMMENT '排序',
  `notes` varchar(255) DEFAULT '' COMMENT '备注',
  `types` tinyint(1) DEFAULT '1' COMMENT '1 文本，2图片 3 富文本;4 视频',
  `update_time` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tp_system_config
-- ----------------------------
INSERT INTO `tp_system_config` VALUES ('1', '', '友情链接分类', '合作伙伴', '50', '', '1', '1686824884');
INSERT INTO `tp_system_config` VALUES ('2', '', '网站logo', '', '50', '', '2', '1686206258');
INSERT INTO `tp_system_config` VALUES ('3', '', '网站标题', '', '50', '', '1', '1686206201');
INSERT INTO `tp_system_config` VALUES ('4', '', '联系地址', '', '50', '', '1', '1686206190');
INSERT INTO `tp_system_config` VALUES ('5', '', '工作时间', '', '50', '', '1', '1686206146');
INSERT INTO `tp_system_config` VALUES ('8', '', '用户协议和隐私声明', '', '50', '', '3', '1686801871');
INSERT INTO `tp_system_config` VALUES ('6', '', '联系电话', '', '50', '', '1', '1686206124');
INSERT INTO `tp_system_config` VALUES ('7', '', '公众号', '', '50', '', '2', '1686206108');

-- ----------------------------
-- Table structure for tp_user
-- ----------------------------
DROP TABLE IF EXISTS `tp_user`;
CREATE TABLE `tp_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `realname` varchar(30) NOT NULL DEFAULT '' COMMENT '姓名',
  `nickname` varchar(20) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '32位小写MD5密码',
  `phone` varchar(30) NOT NULL DEFAULT '' COMMENT '手机号',
  `email` varchar(100) DEFAULT '' COMMENT '邮箱',
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '系统是否启用',
  `img` varchar(255) NOT NULL DEFAULT '' COMMENT '头像URL',
  `sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别。0表示未定义，1表示男性，2表示女性。',
  `birth` varchar(50) NOT NULL DEFAULT '' COMMENT '生日',
  `descript` varchar(200) NOT NULL DEFAULT '',
  `login_ip` varchar(20) NOT NULL DEFAULT '' COMMENT 'IP',
  `login_time` int(10) NOT NULL DEFAULT '0' COMMENT '登录时间',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '注册时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='会员工表';

-- ----------------------------
-- Records of tp_user
-- ----------------------------
INSERT INTO `tp_user` VALUES ('1', '张三', '', 'd93a5def7511da3d0f2d171d9c344e91', '', '1123456@163.com', '1', '', '0', '', '', '39.103.188.159', '1692774305', '1689318769', '1692774305');
