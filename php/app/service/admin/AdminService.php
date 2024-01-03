<?php
declare (strict_types=1);

namespace app\service\admin;

use app\traits\ServiceTrait;
use app\util\JwtUtil;
use think\facade\Config;
use app\service\admin\AuthGroupService;
use app\service\admin\AuthRuleService;

/**
 * 管理员
 * Class AdminService
 * @package app\service
 * @author  hardphp（2066362155@qq.com）
 */
class AdminService
{
    //模型，带命名空间
    public static $model = 'app\model\admin\Admin';
    //模型主键
    public static $pk = 'id';
    //name字段名称
    public static $name = 'username';
    
    use ServiceTrait;

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
        $user = AdminService::getInfoByName($username);
        if (empty($user)) {
            throw new \app\MyException(11104);
        }
        //密码验证
        if ($user['password'] !== encrypt_pass($password)) {
            throw new \app\MyException(11105);
        }
        // 检测用户状态
        if ($user['is_enabled'] != true) {
            throw new \app\MyException(11106);
        }
        //权限检测
        $group = AuthGroupService::getInfoById($user['group_id']);
        if (empty($group) || $group['status'] != true) {
            throw new \app\MyException(11107);
        }
        // 数据处理和令牌获取
        $time = time();
        //登录事件
        AdminService::save(['login_time' => $time,'login_ip'=>request()->ip()], $user['id']);

        // 令牌生成
        $payload['aid']        = $user['id'];
        $payload['login_time'] = $time;
        $user_token            = think_encrypt(JwtUtil::encode($payload));
        // 返回

        $data['username']    = $user['username'];
        $data['email']       = $user['email'];
        $data['realname']    = $user['realname'];
        $data['phone']       = $user['phone'];
        $data['img']         = $user['img'];
        $data['create_time'] = $user['create_time'];
        $data['login_time']  = $user['login_time'] ? date('Y-m-d H:i:s', $user['login_time']) : '';
        $data['group']       = $group['title'];
        $data['gid']         = $group['id'];
        $data['user_token']  =$user_token;
        
        //按钮权限
        $menu = AuthRuleService::getAuthByGroupId($user['group_id'])->toArray();
        $data['auths']       = array_column($menu,'permission');

        return $data;
    }

    /**
     * 管理员身份验证
     */
    public static function checkAdmin($userToken)
    {
        if (empty($userToken)) {
            throw new \app\MyException(11101);
        }
        $userToken = think_decrypt($userToken);
        $payload   = JwtUtil::decode($userToken);
        if ($payload === false || empty($payload->aid) || empty($payload->login_time)) {
            throw new \app\MyException(11101);
        }
        //用户登录有效期
        $userLoginTime = Config::get('system.user_login_time');
        if ($payload->login_time < time() - $userLoginTime) {
            throw new \app\MyException(11102);
        }
        // 实时用户数据
        $user = AdminService::getInfoById($payload->aid);

        //用户是否存在
        if (empty($user)) {
            throw new \app\MyException(11104);
        }

        //是否多设备登录
        if (!empty($user['login_time']) && $user['login_time'] != $payload->login_time) {
            //throw new \app\MyException(11103);
        }
        //认证：状态
        if ($user['is_enabled'] != true) {
            throw new \app\MyException(11106);
        }
        return array('user' => $user);
    }

}
