<?php

declare (strict_types=1);

namespace app\api\controller\cogen;

use think\annotation\route\Group;
use think\annotation\Route;
use think\annotation\route\Middleware;
use app\api\controller\Center;
use app\api\middleware\CheckUser;
use app\traits\ApiTrait;

/**
 * {%tableComment%} {%datetime%}
 * Class {%tableName%}
 * @package app\api\controller\cogen
 * @author  hardphp（2066362155@qq.com）
 * @Group("cogen{%groupName%}")
 * @Middleware({CheckUser::class})
 */
class {%tableName%} extends Center
{
    use ApiTrait;
    //服务，带命名空间
    public static $service = 'app\service\cogen\{%tableName%}Service';
    //验证器名称
    public static $validateName = 'app\validate\cogen\{%tableName%}';
    //保存验证场景
    public static $validateScene = 'save';

    //查询条件前置处理
    public function beforeIndex()
    {
        //搜索参数
        {%searchwhere%}

        return [$where, {%showField%},['id' => 'desc']]; 
    }


    //查询权限处理
    public function beforeIndexAuth($where)
    {
        $where = $where . " and {%userid%} = ".$this->user->id;
        return $where;
    }

    //查询条件前置处理
    public function beforeGetLists()
    {
        //搜索参数
        $fields    = input('fields', [],'trim');

        {%searchwhere%}

        return [$where, $fields,['id' => 'asc']];
    }

    //查询权限处理
    public function beforeGetListsAuth($where)
    {
        $where = $where . " and {%userid%} = ".$this->user->id;
        return $where;
    }

     //查询条件前置处理
    public function beforeGetListsIdName()
    {
        //搜索参数
        $field    = input('field', '{%name%}','trim');
        
        {%searchwhere%}

        return [$where, ['id' => 'asc'],$field,'id'];
    }


       //查询权限处理
    public function beforeGetInfoAuth($where)
    {
        $where = $where . " and {%userid%} = ".$this->user->id;
        return $where;
    }
 
    //保存前置处理
    public function beforeSave($id)
    {
        //接收数据
        {%savedata%}
    
        return $data;
    }

    //权限处理
    public function beforeSaveAuth($where)
    {
        $where = $where . " and {%userid%} = ".$this->user->id;
        return $where;
    }

    //权限处理
    public function beforeDelAuth($where)
    {   
        $where = $where . " and {%userid%} = ".$this->user->id;
        return $where;
    }



}
