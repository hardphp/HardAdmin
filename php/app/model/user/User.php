<?php

declare (strict_types=1);

namespace app\model\user;

use think\Model;
use app\traits\ModelTrait;

/**
 * 用户
 * Class User
 * @package app\model
 * @author  hardphp（2066362155@qq.com）
 */
class User extends Model
{
    use ModelTrait;
    //时间字段显示格式
    protected $dateFormat = 'Y-m-d H:i:s';
    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    //只读字段，不允许被更改
    protected $readonly = [];
    //数据输出隐藏的属性
    protected $hidden = ['password'];

    public static $showField = ['id','realname','nickname','password','phone','email','is_enabled','img','sex','birth','descript','login_ip','login_time','create_time','update_time'];
}
