<?php

declare (strict_types=1);

namespace app\admin\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use think\annotation\route\Middleware;
use app\admin\controller\Base;
use app\traits\ControllerTrait;
use app\admin\middleware\CheckAdmin;
use app\service\admin\AuthRuleService;

/**
 * 规则管理
 * Class Rules
 * @package app\admin\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("rules")
 * @Middleware({CheckAdmin::class})
 */
class Rules extends Base
{
    use ControllerTrait;
    //服务，带命名空间
    public static $service = 'app\service\admin\AuthRuleService';
    //验证器名称
    public static $validateName = 'app\validate\admin\AuthRule';
    //保存验证场景
    public static $validateScene = '';
    //状态变更允许字段,格式 字段名：允许值
    public static $enableField = ['status' => [0, 1]];

    //查询条件前置处理
    public function beforeIndex()
    {
        //搜索参数
        $name  = input('name', '', 'trim');
        $status = input('status', '', 'trim');

        $where = true;
        if ($name) {
            $where .= " and name like '%" . $name . "%' ";
        }
        if ($status != '') {
            $where .= " and status = " . $status;
        }

        return [$where, [],['id' => 'asc'],[]];
    }

    public function beforeGetLists()
    {

        //搜索参数
        $name  = input('name', '', 'trim');
        $status = input('status', '', 'trim');
        $fields    = input('fields', [],'trim');

        $where = true;
        if ($name) {
            $where .= " and name like '%" . $name . "%' ";
        }
        if ($status != '') {
            $where .= " and status = " . $status;
        }

        return [$where, $fields,['id'=>'asc']];
    }



    //保存前置处理
    public function beforeSave($id)
    {
        //接收数据
        $data = [
            'parent_id'   => input('parent_id', 0, 'int'),
            'name'        => input('name', '', 'trim'),
            'icon'        => input('icon', '', 'trim'),
            'status'      => input('status', 0, 'int'),
            'path'        => input('path', '', 'trim'),
            'component'   => input('component', '', 'trim'),
            'permission'    => input('permission', '', 'trim'),
            'sorts'         => input('sorts', 0, 'int'),
            'menu_type'     => input('menu_type', '', 'trim'),
            'is_link'       => input('is_link', 0, 'int'),
            'is_keep_alive' => input('is_keep_alive', 0, 'int'),
            'is_iframe'     => input('is_iframe', 0, 'int'),
            'is_hide'       => input('is_hide', 0, 'int'),
            'is_affix'      => input('is_affix', 0, 'int')
        ];

        if ($id && $id == $data['parent_id']) {
            return json_error(10009);
        }
        return $data;
    }
}
