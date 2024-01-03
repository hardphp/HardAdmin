<?php

declare (strict_types=1);

namespace app\model\base;

use think\Model;
use app\traits\ModelTrait;

/**
 * 应用
 * Class App
 * @package app\model
 * @author  hardphp（2066362155@qq.com）
 */
class App extends Model
{
    use ModelTrait;
    //时间字段显示格式
    protected $dateFormat = 'Y-m-d H:i:s';
    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';
    //只读字段，不允许被更改
    protected $readonly = [];
    //数据输出隐藏的属性
    protected $hidden = [];

    //据输出显示的属性
    public static $showField = ['id', 'appid', 'app_salt', 'title', 'is_sign','sign_white_url', 'update_time', 'is_enabled', 'create_time'];
}
