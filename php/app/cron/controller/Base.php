<?php
declare (strict_types=1);
namespace app\cron\controller;

use app\CronController;

/**
 * 定时任务基类
 * Class Base
 * @package app\api\controller
 * @author  hardphp（2066362155@qq.com）
 */
class Base extends CronController
{
    // 初始化
    protected function initialize()
    {
        parent::initialize();
    }
}
