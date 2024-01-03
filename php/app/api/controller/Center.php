<?php
declare (strict_types=1);
namespace app\api\controller;

use app\api\controller\Base;


/**
 * 会员中心基类
 * Class Center
 * @package app\api\controller
 * @author  hardphp（2066362155@qq.com）
 */
class Center extends Base
{
    //用户信息
    protected $user = [];
    // 初始化
    protected function initialize()
    {
        parent::initialize();
        $this->user = $this->request->sys_user;
    }
    
   
        

}
