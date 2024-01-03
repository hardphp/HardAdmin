<?php

declare (strict_types=1);

namespace app\admin\controller\cogen;

use think\annotation\route\Group;
use think\annotation\Route;
use think\annotation\route\Middleware;
use app\admin\controller\Base;
use app\traits\ControllerTrait;
use app\admin\middleware\CheckAdmin;
use app\service\admin\AuthGroupService;

/**
 * {%tableComment%} {%datetime%}
 * Class {%tableName%}
 * @package app\admin\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("cogen{%groupName%}")
 * @Middleware({CheckAdmin::class})
 */
class {%tableName%} extends Base
{
    use ControllerTrait;
    //服务，带命名空间
    public static $service = 'app\service\cogen\{%tableName%}Service';
    //验证器名称
    public static $validateName = 'app\validate\cogen\{%tableName%}';
    //保存验证场景
    public static $validateScene = 'save';


    //查询权限处理
    public function beforeIndexAuth($where)
    {
        {%auth_where%}
    }

     //查询权限处理
     public function beforeGetListsAuth($where)
     {
        {%auth_where%}
     }


    //查询条件前置处理
    public function beforeIndex()
    {
        //搜索参数
        {%searchwhere%}

        return [$where, {%showField%},['id' => 'desc'],[]];
    }
    
    //查询条件前置处理
    public function beforeGetLists()
    {
        //搜索参数
        $fields    = input('fields', [],'trim');

        {%searchwhere%}

        return [$where, $fields,['id' => 'asc']];
    }
    
    //查询条件前置处理
    public function beforeGetListsIdName()
    {
        //搜索参数
        $field    = input('field', '{%name%}','trim');
        
        {%searchwhere%}

        return [$where, ['id' => 'asc'],$field,'id'];
    }


   
    //保存前置处理
    public function beforeSave($id)
    {
        //接收数据
        {%savedata%}
    
        return $data;
    }

}
