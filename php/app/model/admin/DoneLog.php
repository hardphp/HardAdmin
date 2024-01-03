<?php
declare (strict_types=1);

namespace app\model\admin;

use think\Model;
use app\traits\ModelTrait;

/**
 * 管理员操作日志
 * Class DoneLog
 * @package app\model
 * @author  hardphp（2066362155@qq.com）
 */
class DoneLog extends Model
{
    //时间字段显示格式
    protected $dateFormat = 'Y-m-d H:i:s';
    // 开启自动写入时间戳字段
    protected $autoWriteTimestamp = 'int';

    //据输出显示的属性
    public static $showField = ['id', 'username', 'uid', 'done_ip', 'done_time', 'roles','permission','data','title', 'create_time', 'update_time'];


    use ModelTrait;
}



