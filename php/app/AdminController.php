<?php
declare (strict_types=1);
namespace app;

use app\BaseController;
use think\facade\Request;
use app\service\admin\AuthRuleService;
use app\service\admin\AuthGroupService;

/**
 * 管理端基类
 * Class AdminController
 * @package app
 * @author  hardphp（2066362155@qq.com）
 */
class AdminController extends BaseController
{
    //用户信息
    protected $user = [];

    // 初始化
    protected function initialize()
    {
        $this->user = $this->request->sys_user;
        //获取访问模块：控制器：方法
        $url = request()->baseUrl();
        $url = explode('/',$url);
        
        //演示站禁止修改删除
        // if($url[3] == 'del' || $url[3] == 'save'){
        //      throw new \app\MyException(10001,'演示站禁止修改删除');
        // }
        
        $url = $url[1].':'.$url[2].':'.$url[3];
        
        //获取当前用户权限
        $menu = AuthRuleService::getAuthByGroupId($this->user->group_id)->toArray();
        $auths = array_column($menu,'permission');
        $titles = array_column($menu,'name','permission');
        //判断是否在权限管辖范围内
        $permission = AuthRuleService::getColumnByWhere([['status','=',1]],'permission');
        if(in_array($url,$permission) && $this->user->group_id !== 1){
            if(empty($auths) || !in_array($url,$auths)){
                throw new \app\MyException(10001,'无操作权限');
            }
        }
        if(in_array($url,$permission)){
            $group = AuthGroupService::getInfoById($this->user->group_id);
            event('AdminDone', [$this->user, $group, $titles[$url], $url, request()->param()]);
        }
        
    }

}
