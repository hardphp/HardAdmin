<?php
declare (strict_types=1);

namespace app\service\base;

use app\traits\ServiceTrait;
use think\facade\Config;
use think\helper\Str;
use app\util\EmailUtil;
use app\util\SmsUtil;


/**
 * 验证码服务
 * Class SmsService
 * @package app\service
 * @author  hardphp（2066362155@qq.com）
 */
class SmsService
{
    //模型，带命名空间
    public static $model = 'app\model\base\Sms';
    //模型主键
    public static $pk = 'id';
    //name字段名称
    public static $name = 'phone';

    use ServiceTrait;

    /**
     * 短信验证
     * @param $phone
     * @param $code
     * @param int $type 1=注册，2=登录，3=找回密码
     * @throws \think\Exception
     */
    public static function checkCode($phone, $code, $type = 1)
    {
        $info = SmsService::getInfoByName($phone);
        if (empty($info) || $info['deadline'] < time()) {
            throw new \app\MyException(10311);
        } elseif ($info['code'] !== $code) {
            throw new \app\MyException(10312);
        }

        $data['status'] = 1;
        $res = self::save($data, $info['id']);
        return true;
    }

    /**
     * 发送验证码
     * @param $phone
     * @param int $type 1=注册，2=登录，3=找回密码
     * @param int $channel 0=短信，1=邮件
     */
    public static function sendCode($phone, $type = 1,$channel =0)
    {
         trace('错误信息', 'error');
        //1.生成验证码
        $info = SmsService::getInfoByName($phone);
        $code = Str::random(6, 1);
        if (empty($info)) {
            $data['code']     = $code;
            $data['phone']    = $phone;
            $data['type']     = $type;
            $data['status']   = 0;
            $data['ip']       = request()->ip();
            $data['deadline'] = time() + 10 * 60;
            $res = SmsService::save($data);
        }else{
            $data['deadline'] = time() + 10 * 60;
            $data['code']     = $code;
            $data['ip']       = request()->ip();
            $res = SmsService::save($data, $info['id']);
        } 
        
        if(!$res){
            throw new \app\MyException(10012);
        }
        
       
        
        //2.发送验证码
        if($channel == 0) {
            return SmsUtil::sendCode($phone, $code);
        } else {
            return EmailUtil::sendCode($phone,  $code);
        }    
 
    }

    

}
