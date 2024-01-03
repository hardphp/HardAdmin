<?php
declare (strict_types=1);

namespace app\service\base;

use app\traits\ServiceTrait;

/**
 * 失败队列服务
 * Class FailedJobsService
 * @package app\service
 * @author  hardphp（2066362155@qq.com）
 */
class FailedJobsService
{
    //模型，带命名空间
    public static $model = 'app\model\base\FailedJobs';
    //模型主键
    public static $pk = 'id';
    //name字段名称
    public static $name = '';

    use ServiceTrait;
}
