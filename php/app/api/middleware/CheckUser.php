<?php
declare (strict_types=1);

namespace app\api\middleware;

use app\util\JwtUtil;
use think\facade\Config;
use app\service\user\UserService;

/**
 * 身份验证
 * Class CheckUser
 * @package app\middleware
 * @author  hardphp（2066362155@qq.com）
 */
class CheckUser
{
    public function handle($request, \Closure $next)
    {
        // JWT用户令牌认证，令牌内容获取
        $userToken = $request->header('x-access-token');
        $user = UserService::checkUser($userToken);
        $request->sys_user = $user['user'];
        return $next($request);
    }
}
