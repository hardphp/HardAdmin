<?php

declare (strict_types=1);

namespace app\api\controller\cogen;

use think\annotation\route\Group;
use think\annotation\Route;
use app\api\controller\Base;
use app\traits\ApiTrait;

/**
 * {%tableComment%} {%datetime%}
 * Class {%tableName%}
 * @package app\api\controller\cogen
 * @author  hardphp（2066362155@qq.com）
 * @Group("cogen{%groupName%}")
 */
class {%tableName%} extends Base
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
