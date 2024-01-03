<?php
declare (strict_types=1);

namespace app\admin\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use app\BaseController;
use app\service\admin\AdminService;
use OpenApi\Annotations as OA;

/**
 * 登陆
 * Class Login
 * @package app\admin\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("login")
 * @OA\Info(title="后端接口", version="1.0")
 */
class Login extends BaseController
{
    /**
     * 登录
     * @Route("index", method="POST")
    *  @OA\Post(
    *   path="/admin/login/index",
    *   tags={"用户登录"},
    *   summary="帐号登录",
    *   @OA\Parameter(name="x-access-appid", in="header",description="应用appid",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="signature", in="query",description="签名",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="phone", in="query",description="手机号",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="password", in="query",description="密码",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="code", in="query",description="验证码",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="key", in="query",description="key",required=true,@OA\Schema(type="string")),
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
     */
    public function index()
    {
        //接收数据
        $data = [
            'username' => input('username', '', 'trim'),
            'password' => input('password', '', 'trim'),
            'code'     => input('code', '', 'trim'),
            'key'      => input('key', '', 'trim')
        ];
        if (empty($data['username'])) {
            return json_error(12007);
        }
        if (empty($data['password'])) {
            return json_error(12008);
        }

        if (empty($data['code'])) {
            return json_error(11109);
        }
        if (empty($data['key'])) {
            return json_error(10004);
        }
        //验证码验证
        if (!captcha_check($data['key'], $data['code'])) {
            return json_error(11110);
        }

        // 登录验证并获取包含访问令牌的用户
        $result = AdminService::login($data['username'], $data['password']);
        return json_ok($result, 11108);
    }


}
