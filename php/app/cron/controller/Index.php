<?php

declare (strict_types=1);

namespace app\cron\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use app\cron\controller\Base;
use think\facade\Queue;
use app\service\base\SmsService;

/**
 * 接口
 * Class Index
 * @package app\cron\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("index")
 */
class Index extends Base
{
    
     /**
     * @Route("index", method="GET")
     * 
     * */
    public function index()
    {
         
         
    }
}
