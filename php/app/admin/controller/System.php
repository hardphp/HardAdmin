<?php

declare (strict_types=1);

namespace app\admin\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use think\annotation\route\Middleware;
use think\facade\Db;
use app\admin\controller\Base;
use app\traits\ControllerTrait;
use app\admin\middleware\CheckAdmin;

/**
 * 系统配置管理
 * Class System
 * @package app\admin\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("system")
 * @Middleware({CheckAdmin::class})
 */
class System extends Base
{
    /**
       *
       * @Route("index", method="POST")
       */
    public function index()
    {

        $page  = input('page', 1, 'intval');
        $psize = input('psize', 20, 'intval');
        $title   = input('title', '', 'trim');

        $where = true;
        if ($title) {
            $where .= " and title like '%" . $title . "%' ";
        }

        $lists           = Db::name('system_config')->where($where)->order(['id'=>'desc'])->page($page, $psize)->select();
        $result['total'] = Db::name('system_config')->where($where)->count();
        $result['data']  = $lists;

        return json_ok($result);
    }


     /**
     * 详情
     * @Route("getinfo", method="POST")
     */
    public function getinfo()
    {
        $id = input('id', '0', 'int');
        if ($id == 0) {
            return json_error(10004);
        }

        $info =  Db::name('system_config')->where('id', $id)->find();
        return json_ok($info);
    }

    /**
     * 保存
     * @Route("save", method="POST")
     */
    public function save()
    {
        $id = input('id', '0', 'int');
        //接收数据
        $data = [
            'title'   => input('title', '', 'trim'),
            'value'   => input('value', '', 'trim'),
            'sorts'  => input('sorts', '', 'trim'),
            'notes'  => input('notes', '', 'trim'),
            'update_time'=>time()
        ];
        $res = Db::name('system_config')->where('id', $id)->update($data);
        if ($res == false) {
            return json_error(10005);
        } else {
            return json_ok(['id' => strval($res)], 10006);
        }
    }




}
