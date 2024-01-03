<?php

declare (strict_types=1);

namespace app\api\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use think\annotation\route\Middleware;
use think\facade\Db;
use app\api\controller\Center;
use app\api\middleware\CheckUser;
use OpenApi\Annotations as OA;

/**
 * 个人中心
 * Class User
 * @package app\api\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("user")
 * @Middleware({CheckUser::class})
 */
class User extends Center
{
    /**
     * @Route("index", method="GET")
     * @OA\Get(
     *     tags={"用户"},
     *     path="/api/user/index",
     *     summary="用户资料",
     *  @OA\Parameter(name="x-access-appid", in="header",description="应用appid",required=true,@OA\Schema(type="string")),
     *  @OA\Parameter(name="x-access-token", in="header",description="用户token",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="signature", in="query",description="签名",required=true,@OA\Schema(type="string")),
    *   @OA\RequestBody(
    *   ),
     *     @OA\Response(response="200", description="以实际返回数据为准")
     * )
     */
    public function index()
    {
        $user = $this->user;
        return json_ok($user);
    }

     /**
     * @Route("save", method="POST")
     * @OA\Post(
     *     tags={"用户"},
     *     path="/api/user/save",
     *     summary="用户资料修改",
     *  @OA\Parameter(name="x-access-appid", in="header",description="应用appid",required=true,@OA\Schema(type="string")),
     *  @OA\Parameter(name="x-access-token", in="header",description="用户token",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="signature", in="query",description="签名",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="sex", in="query",description="性别。1表示男性，2表示女性。",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="birth", in="query",description="生日",required=true,@OA\Schema(type="string")),
    *   @OA\Parameter(name="email", in="query",description="邮箱",required=true,@OA\Schema(type="string")),
    *   @OA\RequestBody(
    *   ),
     *     @OA\Response(response="200", description="以实际返回数据为准")
     * )
     */
    public function save()
    {
        $data['sex']    = input('sex', 1, 'intval');
        $data['birth']  = input('birth', '', 'trim');
        $data['email'] = input('email', '', 'trim');
        $data['update_time'] = time();

        if(empty($data['sex']) || empty($data['birth']) || empty($data['email'])) {
            return json_error('10002');
        }

        $res = Db::name('user')->where('id', '=', $this->user->id)->update($data);
        if($res) {
            return json_ok();
        } else {
            return json_error('10005');
        }

    }
}
