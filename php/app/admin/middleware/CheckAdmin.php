<?php
declare (strict_types=1);

namespace app\admin\middleware;

use app\util\JwtUtil;
use think\facade\Config;
use app\service\admin\AdminService;

/**
 * 管理员身份验证
 * Class CheckAdmin
 * @package app\middleware
 * @author  hardphp（2066362155@qq.com）
 */
class CheckAdmin
{
    public function handle($request, \Closure $next)
    {
        // JWT用户令牌认证，令牌内容获取
        $userToken = $request->header('x-access-token');
		$user = AdminService::checkAdmin($userToken);
        $request->sys_user = $user['user'];
        return $next($request);
    }
}
