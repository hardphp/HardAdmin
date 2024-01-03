<?php

declare (strict_types=1);

namespace app\service\user;

use app\traits\ServiceTrait;
use app\util\JwtUtil;
use think\facade\Config;

/**
 * 用户
 * Class UserService
 * @package app\service
 * @author  hardphp（2066362155@qq.com）
 */
class UserService
{
    use ServiceTrait;
    //模型，带命名空间
    public static $model = 'app\model\user\User';
    //模型主键
    public static $pk = 'id';
    //name字段名称
    public static $name = 'phone';


    /**
     * 登录
     * @param string $username 用户名
     * @param string $password 未加密的密码
     * @return array 对象数组，包含字段：userToken，已编码的用户访问令牌；user，用户信息。
     * @throws \app\MyException
     */
    public static function login($username, $password)
    {
        // 查找身份，验证身份
        $user = UserService::getInfoByName($username);
        if (empty($user)) {
            throw new \app\MyException(11104);
        }
        //密码验证
        if ($user['password'] !== encrypt_pass($password)) {
            throw new \app\MyException(11105);
        }
        // 检测用户状态
        if ($user['is_enabled'] != 1) {
            throw new \app\MyException(11106, '账号等待管理员审核');
        }
        // 数据处理和令牌获取
        $time = time();
        //登录事件
        UserService::save(['login_time' => $time,'login_ip'=>request()->ip()], $user['id']);

        // 令牌生成
        $payload['uid']        = $user['id'];
        $payload['login_time'] = $time;
        $user_token            = think_encrypt(JwtUtil::encode($payload));
        // 返回

        $data['realname']    = $user['realname'];
        $data['phone']       = $user['phone'];
        $data['img']         = $user['img'];
        $data['create_time'] = $user['create_time'];
        $data['login_time']  = $user['login_time'] ? date('Y-m-d H:i:s', $user['login_time']) : '';
        $data['user_token']  =$user_token;
        return $data;
    }


    /**
     * 获取用户身份token
     * @param $user 用户信息
     */
    public static function getToken($uid, $time)
    {
        //登录事件
        event('UserLogin', [$uid, $time]);

        // 令牌生成
        $payload['uid']        = $uid;
        $payload['login_time'] = $time;
        $user_token            = think_encrypt(JwtUtil::encode($payload));
        // 返回
        return $user_token;
    }

    /**
     * 通过手机号获取信息
     * @param $phone
     */
    public static function getInfoByPhone($phone, $field = [])
    {
        return UserService::getInfoByPhone($phone, $field);
    }

    /**
     * 用户身份验证
     */
    public static function checkUser($userToken)
    {
        // JWT用户令牌认证，令牌内容获取
        if (empty($userToken)) {
            throw new \app\MyException(11101);
        }
        try {
            $userToken = think_decrypt($userToken);
            $payload   = JwtUtil::decode($userToken);
        } catch (\UnexpectedValueException $e) {
            throw new \app\MyException(11101);
        } catch (\Exception $e) {
            throw new \app\MyException(11101);
        }
        if ($payload === false || empty($payload->uid) || empty($payload->login_time)) {
            throw new \app\MyException(11101);
        }
        //用户登录有效期
        $userLoginTime = Config::get('system.user_login_time');
        if ($payload->login_time < time() - $userLoginTime) {
            throw new \app\MyException(11102);
        }
        // 实时用户数据
        $user = UserService::getInfoById($payload->uid);

        //用户是否存在
        if (empty($user)) {
            throw new \app\MyException(11104);
        }

        //是否多设备登录
        if (!empty($user['login_time']) && $user['login_time'] != $payload->login_time) {
            throw new \app\MyException(11103);
        }
        //认证：状态
        if ($user['is_enabled'] != true) {
            throw new \app\MyException(11106);
        }

        return array('user' => $user);
    }

}
