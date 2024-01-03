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
 * 应用管理
 * Class App
 * @package app\admin\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("app")
 * @Middleware({CheckAdmin::class})
 */
class App extends Base
{
    use ControllerTrait;
    //服务，带命名空间
    public static $service = 'app\service\base\AppService';
    //验证器名称
    public static $validateName = 'app\validate\base\App';
    //保存验证场景
    public static $validateScene = 'save';
    //状态变更允许字段,格式 字段名：允许值
    public static $enableField = ['is_enabled' => [0, 1]];

    //查询条件前置处理
    public function beforeIndex()
    {
        //搜索参数
        $status    = input('status', '', 'trim');
        $title      = input('title', '', 'trim');

        $where = true;
        if ($title) {
            $where .= " and title like '%" . $title . "%' ";
        }
        if ($status != '') {
            $where .= " and is_enabled = " . $status;
        }

        return [$where, [],['id' => 'asc'],[]];
    }


    //保存前置处理
    public function beforeSave($id)
    {
        //接收数据
        $data = [
            'title'             => input('title', '', 'trim'),
            'appid'             => input('appid', '', 'trim'),
            'sign_white_url'    => input('sign_white_url', '', 'trim'),
            'is_sign'           => input('is_sign', 0, 'int'),
            'is_enabled'        => input('is_enabled', 0, 'int'),
        ];

        if(!$id) {
            $data['app_salt'] = encrypt_pass($data['appid']);
        }

        return $data;
    }
}
