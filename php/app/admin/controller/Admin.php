<?php

declare (strict_types=1);

namespace app\admin\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use think\annotation\route\Middleware;
use app\admin\controller\Base;
use app\admin\middleware\CheckAdmin;
use app\service\admin\AuthGroupService;
use app\service\admin\AuthRuleService;
use app\traits\ControllerTrait;
use app\util\TreeUtil;

/**
 * 管理员管理
 * Class Admin
 * @package app\admin\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("admin")
 * @Middleware({CheckAdmin::class})
 */
class Admin extends Base
{
    use ControllerTrait;
    //服务，带命名空间
    public static $service = 'app\service\admin\AdminService';
    //验证器名称
    public static $validateName = 'app\validate\admin\Admin';
    //保存验证场景
    public static $validateScene = 'save';
    //状态变更允许字段,格式 字段名：允许值
    public static $enableField = ['is_enabled' => [0, 1]];

    /**
     * 获取登录用户菜单支持三级
     * @Route("getusermenu", method="POST")
     */
    public function getusermenu()
    {
        $menu = AuthRuleService::getMenuByGroupId($this->user->group_id);
        return json_ok($menu);
    }

    //查询条件前置处理
    public function beforeIndex()
    {
        //搜索参数
        $is_enabled = input('status', '', 'trim');
        $username   = input('username', '', 'trim');
        $phone      = input('phone', '', 'trim');
        $realname   = input('realname', '', 'trim');
        $start_time = input('start_time', '', 'strtotime');
        $end_time   = input('end_time', '', 'strtotime');

        $where = true;
        if ($username) {
            $where .= " and username like '%" . $username . "%' ";
        }
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

        return [$where, [],['id' => 'asc'],[]];
    }

    //查询条件前置处理
    public function beforeGetLists()
    {
        $fields    = input('fields', ['id','realname'],'trim');
        return [true, $fields,[]];
    }

    //查询权限处理
    public function beforeGetListsAuth($where)
    {
        if ($this->user->group_id !== 1) {
            $where= [['id','=',$this->user->id]];
        }
        return $where;
    }

     //查询条件前置处理
     public function beforeGetListsIdName()
     {
         //搜索参数
         $status    = input('status', '');
         $field    = input('field', 'username','trim');
         $where = true;
         if ($status != '') {
             $where .= " and is_enabled = " . $status;
         }
         return [$where, ['id' => 'asc'],$field,'id'];
     }

    //保存前置处理
    public function beforeSave($id)
    {

        $id = input('id', '0', 'int');
        //接收数据
        $data = [
            'id'         => $id,
            'group_id'   => input('group_id', '', 'trim'),
            'dept_id'   => input('dept_id', '', 'trim'),
            'username'   => input('username', '', 'trim'),
            'realname'   => input('realname', '', 'trim'),
            'img'        => input('img', '', 'trim'),
            'phone'      => input('phone', '', 'trim'),
            'email'      => input('email', '', 'trim'),
            'password'   => input('password', '', 'trim'),
            'is_enabled' => input('is_enabled', 0, 'int'),
            'salary' => input('salary', 0, 'int'),
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

    /**
     * 修改
     * @Route("modify", method="POST")
     */
    public function modify()
    {
        //接收数据
        $data = [
            'realname'   => input('realname', '', 'trim'),
            'img'        => input('img', '', 'trim'),
            'phone'      => input('phone', '', 'trim'),
            'email'      => input('email', '', 'trim'),
            'password'   => input('password', '', 'trim'),
        ];

        if ($data['password']) {
            $data['password'] = encrypt_pass($data['password']);
        } else {
            unset($data['password']);
        }
        $validate = validate(self::$validateName);
        $result = $validate->scene('modify')->check($data);
        if (!$result) {
            $error = $validate->getError();
            return json_error($error);
        }

        $res = self::$service::save($data, $this->user->id);
        if ($res == false) {
            return json_error(10005);
        } else {
            return json_ok(['id' => strval($res)], 10006);
        }
    }

     /**
     * 获取当前登录用户信息
     * @Route("getnowuser", method="POST")
     */
    public function getnowuser()
    {
        $info = self::$service::getInfoById($this->user->id);
        $info['login_time'] = date('Y-m-d H:i:s', $info['login_time']);

        $group = AuthGroupService::getInfoById($this->user->group_id);

        $info['group'] = $group['title'];
        return json_ok($info);
    }


    /**
     * 删除前数据处理
     * $id
     */
    public function beforeDel($id)
    {
        if(empty($id)) {
            return true;
        }
        return true;
    }

    /**
     * 删除前数据处理
     * $id
     */
    public function beforeDelAll($ids)
    {

        return true;
    }

}
