<?php

declare (strict_types=1);

namespace app\model\base;

use think\Model;
use app\traits\ModelTrait;

/**
 * 文件管理
 * Class Files
 * @package app\model
 * @author  hardphp（2066362155@qq.com）
 */
class Files extends Model
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
    public static $showField = ['id','title','size', 'hash', 'types','url', 'mine','update_time', 'create_time'];
}
