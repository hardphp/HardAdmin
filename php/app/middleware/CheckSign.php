<?php

declare (strict_types=1);

namespace app\middleware;

use think\facade\Config;
use app\service\base\AppService;
use think\facade\Log;

/**
 * 签名验证
 * Class CheckSign
 * @package app\middleware
 * @author  hardphp（2066362155@qq.com）
 */
class CheckSign
{
    public function handle($request, \Closure $next)
    {
        //模块免签
        if (in_array($request->pathinfo(), [])) {
            return $next($request);
        }

        $appid = $request->header('x-access-appid');
        if (empty($appid)) {
            throw new \app\MyException(11001);
        }
        // 实时数据
        $app = AppService::getInfoByName($appid);
        //认证：状态
        if (empty($app)) {
            throw new \app\MyException(11001);
        }

        if (empty($app) || $app['is_enabled'] != true) {
            throw new \app\MyException(11002);
        }

        // 接口签名认证
        if ($app['is_sign']) {

            //免签白名单
            if ($request->pathinfo() && $app['sign_white_url']) {
                if(in_array($request->pathinfo(), json_decode($app['sign_white_url'], true))) {
                    return $next($request);
                }
            }

            // app端生成的签名
            $signature = $request->param("signature");
            $param     = $request->param();
            unset($param['signature']);//去掉签名
            unset($param['content']);//去掉富文本
            if (empty($signature)) {
                throw new \app\MyException(11003);
            }
            //数组排序
            ksort($param);
            $str        = http_build_query($param);

            //空格 + 转 %20，~ 处理
            $str = str_replace('+', '%20', $str);
            $str = str_replace('%7E', '~', $str);
            $signature1 = md5(sha1($str) . $app['app_salt']);
            if ($signature != $signature1) {
                throw new \app\MyException(11004);
            }
        }

        return $next($request);

    }
}
