<?php
declare (strict_types=1);

namespace app\listener\admin;

use app\service\admin\DoneLogService;

/**
 * 用户操作事件
 * Class AdminDone
 * @package app\listener\admin
 * @author hardphp（2066362155@qq.com）
 */
class AdminDone
{
    /**
     * 事件监听处理
     *
     * @return mixed
     */
    public function handle($event)
    {
        list($user, $group ,$title ,$permission ,$data) = $event;
        
        DoneLogService::save([
            'uid'        => $user['id'],
            'username'   => $user['username'],
            'roles'      => $group['title'],
            'done_time'  => time(),
            'title'      => $title,
            'permission' => $permission,
            'data'       => json_encode($data),
            'done_ip'   => request()->ip(),
        ]);
    }
}
