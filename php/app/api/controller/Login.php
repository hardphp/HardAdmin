<?php

declare (strict_types=1);

namespace app\api\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use app\api\controller\Base;
use OpenApi\Annotations as OA;
use app\service\user\UserService;
use think\facade\Db;

/**
 * 客户登录接口
 * Class Login
 * @package app\api\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("login")
 * @OA\Info(title="前端接口", version="1.0",description =" x-access-appid 和 signature 每个方法必传，x-access-token 需要登录接口传；signature算法 = md5(sha1($str) . 密钥)，密钥 x-access-appid 对应，可以在后台应用管理中获取，$str 是参数数组先ksort排序，然后拼接成字符换")
 */
class Login extends Base
{
    /**
     * 用户登录
     * @Route("index", method="POST")
    * @OA\Post(
    *   path="/api/login/index",
    *   tags={"用户登录"},
    *   summary="帐号登录",
    *   @OA\Parameter(name="x-access-appid", in="header",description="应用appid",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="signature", in="query",description="签名",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="phone", in="query",description="手机号",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="password", in="query",description="密码",required=true,@OA\Schema(type="string")),
    *   @OA\RequestBody(
        *   @OA\MediaType(
        *     mediaType="x-www-form-urlencoded",
        *       @OA\Schema(
        *           @OA\Property(description="帐 号", property="phone", type="string"),
        *           @OA\Property(description="密 码", property="password", type="string"),
        *           required={"phone","password"})
        *     )
    *   ),
    *   @OA\Response(
    *       response="200",
    *       description="返回结果请以真实API拿数到数据为准",
    *   )
    * )
     *
     */
    public function index()
    {
        //接收数据
        $data = [
           'username' => input('phone', '', 'trim'),
           'password' => input('password', '', 'trim'),
        ];
        if (empty($data['username'])) {
            return json_error(12007);
        }
        if (empty($data['password'])) {
            return json_error(12008);
        }

        // 登录验证并获取包含访问令牌的用户
        $result = UserService::login($data['username'], $data['password']);
        return json_ok($result, 11108);
    }

    /**
     * @Route("reg", method="POST")
     * @OA\Post(
     *     tags={"用户注册"},
     *     path="/api/login/reg",
     *     summary="用户注册",
     *  @OA\Parameter(name="x-access-appid", in="header",description="应用appid",required=true,@OA\Schema(type="string")),
     *  @OA\Parameter(name="phone", in="query",description="手机号",required=true,@OA\Schema(type="string")),
     *  @OA\Parameter(name="realname", in="query",description="姓名",required=true,@OA\Schema(type="string")),
     *  @OA\Parameter(name="password", in="query",description="密码",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="signature", in="query",description="签名",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="sex", in="query",description="性别。1表示男性，2表示女性。",required=false,@OA\Schema(type="string")),
    *   @OA\Parameter(name="birth", in="query",description="生日",required=false,@OA\Schema(type="string")),
    *   @OA\Parameter(name="email", in="query",description="邮箱",required=false,@OA\Schema(type="string")),
    *   @OA\RequestBody(
    *   ),
     *     @OA\Response(response="200", description="以实际返回数据为准")
     * )
     */
    public function reg()
    {
        $data['phone']    = input('phone', '', 'trim');
        $data['realname']    = input('realname', '', 'trim');
        $data['password']    = input('password', '', 'trim');
        $data['sex']    = input('sex', 1, 'intval');
        $data['birth']  = input('birth', '', 'trim');
        $data['email'] = input('email', '', 'trim');
        $data['create_time'] = time();
        $data['is_enabled'] = 2;//待审核
        $data['reg_ip'] = request()->ip();

        if(empty($data['phone']) || empty($data['realname']) || empty($data['password'])) {
            return json_error('10002');
        }

        $data['password'] = encrypt_pass($data['password']);
        $has= Db::name('user')->where('phone', '=', $data['phone'])->find();
        if($has) {
            return json_error('10001', '手机号已经注册过了');
        }

        $res = Db::name('user')->insertGetId($data);
        if($res) {
            return json_ok();
        } else {
            return json_error('10021');
        }

    }


    /**
     * @Route("pwd", method="POST")
     * @OA\Post(
     *     tags={"忘记密码"},
     *     path="/api/login/pwd",
     *     summary="忘记密码",
     *  @OA\Parameter(name="x-access-appid", in="header",description="应用appid",required=true,@OA\Schema(type="string")),
     *  @OA\Parameter(name="phone", in="query",description="手机号",required=true,@OA\Schema(type="string")),
     *  @OA\Parameter(name="realname", in="query",description="姓名",required=true,@OA\Schema(type="string")),
     *  @OA\Parameter(name="password", in="query",description="密码",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="signature", in="query",description="签名",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="password2", in="query",description="确认密码",required=true,@OA\Schema(type="string")),
    *   @OA\RequestBody(
    *   ),
     *     @OA\Response(response="200", description="以实际返回数据为准")
     * )
     */
    public function pwd()
    {
        $phone   = input('phone', '', 'trim');
        $realname    = input('realname', '', 'trim');
        $data['password']    = input('password', '', 'trim');
        $password2  = input('password2', '', 'trim');
        //$data['email'] = input('email', '', 'trim');
        $data['update_time'] = time();

        if(empty($phone) || empty($realname) || empty($data['password'])) {
            return json_error('10002');
        }


        $has= Db::name('user')->where([['phone', '=', $phone],['realname', '=', $realname]])->find();
        if(!$has) {
            return json_error('10001', '未找到该用户');
        }

        if($data['password'] != $password2) {
            return json_error('10001', '两次密码不一致');
        }

        $data['password'] = encrypt_pass($data['password']);

        $res = Db::name('user')->where('id', '=', $has->id)->update($data);
        if($res) {
            return json_ok();
        } else {
            return json_error('10005');
        }

    }


}
