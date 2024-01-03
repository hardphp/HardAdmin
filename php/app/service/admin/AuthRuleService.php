<?php
declare (strict_types=1);
namespace app\service\admin;

use app\service\admin\AuthGroupService;
use app\traits\ServiceTrait;

/**
 * 权限组
 * Class AuthRuleService
 * @package app\service
 * @author  hardphp（2066362155@qq.com）
 */
class AuthRuleService
{
    //模型，带命名空间
    public static $model = 'app\model\admin\AuthRule';
    //模型主键
    public static $pk = 'id';
    //name字段名称
    public static $name = '';
    
    use ServiceTrait;

    /**
     * 获取权限组权限
     * @param $groupId 分组id
     * @return array
     */
    public static function getAuthByGroupId($groupId)
    {
        //获取分组信息
        $group = AuthGroupService::getInfoById($groupId);
        if ($group['status'] != 1 || empty($group['rules'])) {
            return [];
        }
        //分组角色
        $ruleIds = explode(',', $group['rules']);
        $rules   = AuthRuleService::getListsAll([['id', 'in', $ruleIds],['status','=',1]], ['sorts' => 'asc']);
        return $rules;
    }
    
    /**
     * 获取菜单，不包含按钮
     * @param $groupId 分组id
     * @return array
     */
    public static function getMenuByGroupId($groupId)
    {
        //获取分组信息
        $group = AuthGroupService::getInfoById($groupId);
        if ($group['status'] != 1 || empty($group['rules'])) {
            return [];
        }
        //分组角色
        $ruleIds = explode(',', $group['rules']);
        $rules   = AuthRuleService::getListsAll([['id', 'in', $ruleIds],['status','=',1],['menu_type','=','menu']], ['sorts' => 'asc']);
        return $rules;
    }

}
