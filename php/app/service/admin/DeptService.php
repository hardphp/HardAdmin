<?php
declare (strict_types=1);
namespace app\service\admin;

use app\traits\ServiceTrait;

/**
 * 部门
 * Class DeptService
 * @package app\service
 * @author  hardphp（2066362155@qq.com）
 */
class DeptService
{
    //模型，带命名空间
    public static $model = 'app\model\admin\Dept';
    //模型主键
    public static $pk = 'id';
    //name字段名称
    public static $name = '';

    use ServiceTrait;

}
