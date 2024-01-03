<?php
declare (strict_types=1);
namespace app\service\admin;

use app\traits\ServiceTrait;
use app\service\admin\DeptService;
use app\util\TreeUtil;

/**
 * 权限组
 * Class AuthGroupService
 * @package app\service
 * @author  hardphp（2066362155@qq.com）
 */
class AuthGroupService
{
    //模型，带命名空间
    public static $model = 'app\model\admin\AuthGroup';
    //模型主键
    public static $pk = 'id';
    //name字段名称
    public static $name = '';

    use ServiceTrait;

    /**
     * 获取部门权限
     * @param string $dept_id 部门id
     * @throws \app\MyException
     */
    public static function getDeptAuth($group_id,$dept_id,$userid)
    {
        $group = AuthGroupService::getInfoById($group_id);
        if($group && $group['types'] == 1){
             //全部权限
             $where = " and 1=1 ";
        }elseif($group['types'] == 2){
             //本部门权限
             $where =" and dept_id = ".$dept_id;
        }elseif($group['types'] == 3){
             //本部门以及下属权限
             $depts = DeptService::getListsAll(true,['id'=>'asc']);
             $subids = TreeUtil::getSubordinateIds($depts,$dept_id,'id','parent_id');
             $subids[] = $dept_id;

             $subids = implode(',',$subids);
             $where =" and dept_id in (".$subids.")";

        }elseif($group['types'] == 4){
             //本人
             $where =" and userid = ".$userid;
        }elseif($group['types'] == 5){
             //自定义权限
             if($group['depts']){
                 $where =" and dept_id in (".$group['depts'].")";
             }
        }

        return $where;
    }

}
