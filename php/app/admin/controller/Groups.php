<?php

declare (strict_types=1);

namespace app\admin\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use think\annotation\route\Middleware;
use app\admin\controller\Base;
use app\traits\ControllerTrait;
use app\admin\middleware\CheckAdmin;
use app\service\admin\AuthGroupService;

/**
 * 分组管理
 * Class Group
 * @package app\admin\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("groups")
 * @Middleware({CheckAdmin::class})
 */
class Groups extends Base
{
    use ControllerTrait;
    //服务，带命名空间
    public static $service = 'app\service\admin\AuthGroupService';
    //验证器名称
    public static $validateName = 'app\validate\admin\AuthGroup';
    //保存验证场景
    public static $validateScene = '';
    //状态变更允许字段,格式 字段名：允许值
    public static $enableField = ['status' => [0, 1]];

    //查询条件前置处理
    public function beforeIndex()
    {
        //搜索参数
        $title  = input('title', '', 'trim');
        $status = input('status', '', 'trim');

        $where = true;
        if ($title) {
            $where .= " and title like '%" . $title . "%' ";
        }
        if ($status != '') {
            $where .= " and status = " . $status;
        }
        return [$where, [],['id' => 'asc'],[]];
    }
    //查询条件前置处理
    public function beforeGetListsIdName()
    {
        //搜索参数
        $status    = input('status', '', 'trim');
        $field    = input('field', 'title','trim');
        $where = true;
        if ($status != '') {
            $where .= " and status = " . $status;
        }
        return [$where, ['id' => 'asc'],$field,'id'];
    }

    //保存前置处理
    public function beforeSave($id)
    {
        //接收数据
        $data = [
            'title'  => input('title', '', 'trim'),
            'status' => input('status', 0, 'int'),
            'types' => input('types', 0, 'int'),
            'rules'  => input('rules/a', ''),
            'depts'  => input('depts/a', '')

        ];
        if ($data['rules']) {
            $data['rules'] = implode(',', $data['rules']);
        }

        if ($data['depts']) {
            $data['depts'] = implode(',', $data['depts']);
        }
        return $data;
    }

}
