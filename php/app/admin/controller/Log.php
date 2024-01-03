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
 * 管理员日志
 * Class Log
 * @package app\admin\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("log")
 * @Middleware({CheckAdmin::class}) 
 */
class Log extends Base
{
    //服务，带命名空间
    public static $service = 'app\service\admin\DoneLogService';
    //验证器名称
    public static $validateName = 'app\validate\admin\Log';
    //保存验证场景
    public static $validateScene = '';
    //状态变更允许字段,格式 字段名：允许值
    public static $enableField = [];

    use ControllerTrait;


    //查询条件前置处理
    public function beforeIndex()
    {
        //搜索参数
        $uid        = input('uid', 0, 'intval');
        $username   = input('username', '', 'trim');
        $tilte   = input('tilte', '', 'trim');
        $done_ip   = input('done_ip', '', 'trim');
        $start_time = input('start_time', '', 'strtotime');
        $end_time   = input('end_time', '', 'strtotime');

        $where = true;
        if ($username) {
            $where .= " and username like '%" . $username . "%' ";
        }
        if ($tilte) {
            $where .= " and tilte like '%" . $tilte . "%' ";
        }
        if ($done_ip) {
            $where .= " and done_ip like '%" . $done_ip . "%' ";
        }
        if ($start_time) {
            $where .= " and create_time >= " . $start_time . " ";
        }
        if ($end_time) {
            $where .= " and create_time <= " . $end_time . " ";
        }
        if ($uid) {
            $where .= " and uid = " . $uid;
        }

        return [$where, [],['id' => 'desc'],[]];
    }


    //查询权限处理
    public function beforeIndexAuth($where)
    {
        if ($this->user->group_id !== 1) {
            $where .= ' and uid = '.$this->user->id;
        }
        return $where;
    }
}
