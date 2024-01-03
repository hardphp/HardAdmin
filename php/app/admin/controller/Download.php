<?php
declare (strict_types=1);

namespace app\admin\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use app\BaseController;
use think\facade\Config;

/**
 * 文件下载
 * Class Download
 * @package app\admin\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("download")
 */
class Download extends BaseController
{

    /**
     *  下载图片
     * @throws \Exception
     * 员工二维码
     * @Route("downimg", method="GET")
     */
    public function downimg(){
        //获取要下载的文件名
        $url = input('url','','trim'); 
        $filename = input('filename','','trim');
        
        $path = str_replace(Config::get("app.app_host"),'.',$url);
        
        if(empty($path) || !is_file($path)){
            return json_error(10002);
        }
        $filename .= date('Ymd',time()); 
        return download($path, $filename);
    } 
}
