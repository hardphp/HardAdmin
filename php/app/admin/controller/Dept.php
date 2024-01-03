<?php

declare (strict_types=1);

namespace app\admin\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use think\annotation\route\Middleware;
use app\admin\controller\Base;
use app\traits\ControllerTrait;
use app\admin\middleware\CheckAdmin;
use app\service\admin\DeptService;

/**
 * 部门管理
 * Class Dept
 * @package app\admin\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("dept")
 * @Middleware({CheckAdmin::class})
 */
class Dept extends Base
{
    use ControllerTrait;
    //服务，带命名空间
    public static $service = 'app\service\admin\DeptService';
    //验证器名称
    public static $validateName = 'app\validate\admin\Dept';
    //保存验证场景
    public static $validateScene = '';
    //状态变更允许字段,格式 字段名：允许值
    public static $enableField = ['status' => [0, 1]];

    //查询条件前置处理
    public function beforeIndex()
    {
        //搜索参数
        $dept_name  = input('dept_name', '', 'trim');
        $status = input('status', '', 'trim');

        $where = true;
        if ($dept_name) {
            $where .= " and dept_name like '%" . $dept_name . "%' ";
        }
        if ($status != '') {
            $where .= " and status = " . $status;
        }

        return [$where, [],['id' => 'asc'],[]];
    }

    public function beforeGetLists()
    {

        //搜索参数
        $dept_name  = input('dept_name', '', 'trim');
        $status = input('status', '', 'trim');
        $fields    = input('fields', [],'trim');

        $where = true;
        if ($dept_name) {
            $where .= " and dept_name like '%" . $dept_name . "%' ";
        }
        if ($status != '') {
            $where .= " and status = " . $status;
        }

        return [$where, $fields,['id'=>'asc']];
    }
    
        //查询条件前置处理
    public function beforeGetListsIdName()
    {
        //搜索参数
        $field    = input('field', 'dept_name','trim');
        
        $where = true;
        $name    = input('name', '', 'trim');
        if($name){
            $where .= " and name like '%". $name ."%' " ;
        }


        return [$where, ['id' => 'asc'],$field,'id'];
    }



    //保存前置处理
    public function beforeSave($id)
    {
        //接收数据
        $data = [
            'parent_id'     => input('parent_id', 0, 'int'),
            'dept_name'     => input('dept_name', '', 'trim'),
            'status'        => input('status', 0, 'int'),
            'sorts'         => input('sorts', 0, 'int'),
            'leader'        => input('leader', '', 'trim'),
            'phone'         => input('phone', '', 'trim'),
            'email'         => input('email', '', 'trim')
        ];

        if ($id && $id == $data['parent_id']) {
            return json_error(10009);
        }
        return $data;
    }
}
