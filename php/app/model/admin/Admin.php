<?php
declare (strict_types=1);

namespace app\model\admin;

use think\Model;
use app\traits\ModelTrait;

/**
 * 管理员
 * Class Admin
 * @package app\model
 * @author  hardphp（2066362155@qq.com）
 */
class Admin extends Model
{
    //时间字段显示格式
    protected $dateFormat = 'Y-m-d H:i:s';
    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    //只读字段，不允许被更改
    protected $readonly = [];

    //数据输出隐藏的属性
    protected $hidden = ['password'];

    //据输出显示的属性
    public static $showField = ['id', 'username', 'password', 'email', 'realname', 'phone', 'img', 'reg_ip', 'login_time', 'login_ip', 'is_enabled','salary','dept_id', 'group_id', 'create_time','update_time'];

    use ModelTrait;
}



