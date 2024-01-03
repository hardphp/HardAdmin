<?php

declare (strict_types=1);

namespace app\admin\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use think\annotation\route\Middleware;
use app\admin\controller\Base;
use app\traits\ControllerTrait;
use app\admin\middleware\CheckAdmin;

/**
 * 员工管理
 * Class User
 * @package app\admin\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("user")
 * @Middleware({CheckAdmin::class})
 */
class User extends Base
{
    use ControllerTrait;
    //服务，带命名空间
    public static $service = 'app\service\user\UserService';
    //验证器名称
    public static $validateName = 'app\validate\user\User';
    //保存验证场景
    public static $validateScene = 'save';
    //状态变更允许字段,格式 字段名：允许值
    public static $enableField = ['is_enabled' => [0, 1]];

    //查询条件前置处理
    public function beforeIndex()
    {
        //搜索参数
        $is_enabled = input('status', '', 'trim');
        $phone      = input('phone', '', 'trim');
        $realname   = input('realname', '', 'trim');
        $start_time = input('start_time', '', 'strtotime');
        $end_time   = input('end_time', '', 'strtotime');

        $where = true;
        if ($phone) {
            $where .= " and phone like '%" . $phone . "%' ";
        }
        if ($realname) {
            $where .= " and realname like '%" . $realname . "%' ";
        }
        if ($start_time) {
            $where .= " and login_time >= " . $start_time . " ";
        }
        if ($end_time) {
            $where .= " and login_time <= " . $end_time . " ";
        }
        if ($is_enabled != '') {
            $where .= " and is_enabled = " . $is_enabled;
        }

        return [$where, [],['id' => 'desc'],[]];
    }

    //保存前置处理
    public function beforeSave($id)
    {

        $id = input('id', '0', 'int');
        //接收数据
        $data = [
            'id'         => $id,
            'nickname'   => input('nickname', '', 'trim'),
            'realname'   => input('realname', '', 'trim'),
            'img'        => input('img', '', 'trim'),
            'phone'      => input('phone', '', 'trim'),
            'email'      => input('email', '', 'trim'),
            'password'   => input('password', '', 'trim'),
            'is_enabled' => input('is_enabled', 0, 'int'),
            'sex'        => input('sex', 0, 'int'),
            'birth'     => input('birth', '', 'trim'),
        ];

        if ($id == 0) {
            $data['reg_ip'] = request()->ip();
        }
        if ($data['password']) {
            $data['password'] = encrypt_pass($data['password']);
        } else {
            unset($data['password']);
        }

        return $data;
    }



}
