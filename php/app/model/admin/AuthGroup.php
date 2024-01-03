<?php
declare (strict_types=1);

namespace app\model\admin;

use think\Model;
use app\traits\ModelTrait;

/**
 * 用户组
 * Class AuthGroup
 * @package app\model
 * @author  hardphp（2066362155@qq.com）
 */
class AuthGroup extends Model
{
    //时间字段显示格式
    protected $dateFormat = 'Y-m-d H:i:s';
    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    //只读字段，不允许被更改
    protected $readonly = [];
    //数据输出隐藏的属性
    protected $hidden = [];

    //据输出显示的属性
    public static $showField = ['id', 'title', 'status', 'rules','depts','types', 'update_time', 'create_time'];

    use ModelTrait;

}