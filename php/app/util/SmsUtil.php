<?php
declare (strict_types=1);

namespace app\util;

use think\facade\Config;
use think\facade\Log;

/**
 * 短信服务
 * Class SmsUtil
 * @package app\util
 * @author  hardphp（2066362155@qq.com）
 */
class SmsUtil
{
    /** 加密
     * @param $phone  手机号
     * @param $code  验证码
     * @throws \think\Exception 
     */
    public static function sendCode($phone,$code)
    {
        
        $sms = Config::get("app.sms");
        if (empty($sms) || !isset($sms['info']['username']) || !isset($sms['info']['password']) || !isset($sms['info']['send_url'])) {
            throw new \app\MyException(10003);
        }

        $content = str_replace('@', $code, $sms['con']);

        //地址
        $url              = $sms['info']['send_url'];
        $info             = [];
        $info['mobile']   = $phone;
        $info['content']  = $content;
        $info['tKey']     = time();
        $info['username'] = $sms['info']['username'];
        $info['password'] = md5(md5($sms['info']['password']) . $info['tKey']);

        $res = curl_post($url, $info);
        $res = json_decode($res, true);
        return $res;
    }
 

}
