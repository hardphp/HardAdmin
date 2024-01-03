<?php
declare (strict_types=1);
namespace app\service\user;

use think\Exception;
use think\facade\Config;
use EasyWeChat\Factory;
use EasyWeChat\Kernel\Messages\TextCard;

/**
 * 企业微信用户
 * Class UserWorkService
 * @package app\service\user
 * @author  hardphp（2066362155@qq.com）
 */
class UserWorkService
{

    /**
     *
     * 获取微信用户code
     * $callbackUrl string 回调地址
     **/
    public static function getCode($callbackUrl)
    {
        $config = Config::get('system.wechat_work');

        $app = Factory::work($config);


        // $callbackUrl 为授权回调地址
        $callbackUrl = Config::get('app.app_host') . $callbackUrl; // 需设置可信域名

        // 返回一个 redirect 实例
        $redirect = $app->oauth->redirect($callbackUrl);

        // 获取企业微信跳转目标地址
        $targetUrl = $redirect->getTargetUrl();

        // 直接跳转到企业微信授权
        $redirect->send();

    }

    /**
     * 根据code获取用户信息
     */
    public static function getUserInfo($code)
    {
        $config = Config::get('system.wechat_work');

        $app = Factory::work($config);

        $user = $app->oauth->detailed()->userFromCode($code);
        // 获取用户信息
        $userid = $user->getId(); // 对应企业微信英文名（userid）
        $info = $user->getRaw(); // 获取企业微信接口返回的原始信息

        $user = $app->user->get($userid);
        
        if ($user['errcode'] != 0) {
            throw new \app\MyException(12009);
        }
        //更新用户信息
        $has = UserService::getInfoByName($userid);
        
        if ($has) {
            $data = [
                'nickname' => $user['alias'],
                'sex' => $user['gender'],
                'update_time' => time(),
                'login_time' => time(),
                'login_ip'=> request()->ip(),
                
            ];
            if(isset($has['realname']) && !$has['realname']){
                $data['realname'] = $user['name'];
            }
            
            if(isset($has['img']) && !$has['img']){
                $data['img'] = $user['avatar'];
            }
            
            if(isset($has['phone']) && !$has['phone']){
                $data['phone'] = $user['mobile'];
            }
            
            if(isset($has['crop_code']) && !$has['crop_code']){
                $data['crop_code'] = $user['qr_code'];
            }
            UserService::save($data, $has['id']);
            $uid = $has['id'];
        } else {
            // $data = [
            //     'userid' => $user['userid'],
            //     'realname' => $user['name'],
            //     'nickname' => $user['name'],
            //     'img' => $user['avatar'],
            //     'sex' => $user['gender']
            // ];
            // $uid = UserService::save($data);
            throw new \app\MyException(12121);
        }
        $time = time();
        $token = UserService::getToken($uid, $time);

        return ['userid'=>$user['userid'],'token'=>$token,'status'=>$has['is_enabled']];
    }
    
    /**
     * 给userid 发送企业微信消息
     */
    public static function sendMsg($userid,$msg)
    {
        $config = Config::get('system.wechat_work');

        $app = Factory::work($config);


        // 获取 Messenger 实例
        $messenger = $app->messenger;
        
        // 准备消息
        $message = new TextCard([
            'title' => $msg['title'], 
            'description' => $msg['description'],
            'url' => $msg['url']
        ]);
        
        // 发送
        $res = $messenger->message($message)->toUser($userid)->send();
 
        return $res;
        
    }
    
}
