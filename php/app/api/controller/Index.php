<?php

declare (strict_types=1);

namespace app\api\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use app\api\controller\Base;
use think\facade\Db;
use OpenApi\Annotations as OA;

/**
 * 非用户身份类接口
 * Class Index
 * @package app\api\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("index")
 */
class Index extends Base
{
    /**
     * @Route("navs", method="GET")
     * @OA\Get(
     *     tags={"首页"},
     *     path="/api/index/navs",
     *     summary="栏目导航",
     *     @OA\Response(response="200", description="以实际返回数据为准")
     * )
     */
    public function navs()
    {
        $lists = Db::name('cg_column')->where('status', '1')->order(['sorts'=>'asc','id'=>'desc'])->select();
        return json_ok($lists);
    }
}
