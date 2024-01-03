<?php

declare (strict_types=1);

namespace app\admin\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use think\annotation\route\Middleware;
use app\admin\controller\Base;
use app\admin\middleware\CheckAdmin;
use think\facade\Db;

/**
 * 数据统计
 * Class Statistics
 * @package app\admin\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("statistics")
 * @Middleware({CheckAdmin::class})
 */
class Statistics extends Base
{
    /**
      *
      * @Route("index", method="POST")
      */
    public function index()
    {

        $col_num = Db::name('cg_column')->where(true)->count();
        $art_num = Db::name('cg_article')->where(true)->count();
        $user_num = Db::name('user')->where(true)->count();
        $bao_num = 0;

        $data['homeOne'] = [
            ['num1'=>$col_num ,'num2'=>0,'num3'=>'栏目数量'],
            ['num1'=>$art_num,'num2'=>0,'num3'=>'文章数量'],
            ['num1'=>$user_num,'num2'=>0,'num3'=>'用户数量'],
            ['num1'=>$bao_num,'num2'=>0,'num3'=>'报名数量'],
        ];

        $act_num = Db::name('cg_article')->where('cid',7)->count();
        $video_num = Db::name('cg_article')->where('cid',8)->count();
        $link_num = Db::name('cg_links')->where(true)->count();
        $xuexi_num = 0;

        $data['homeThree'] = [
            ['label'=>'活动数量','value'=>$act_num],
            ['label'=>'课程数量','value'=> $video_num],
            ['label'=>'链接数量','value'=>$link_num ],
            ['label'=>'学习人数','value'=>$xuexi_num],
        ];

         //最近两周
        // 获取当前日期
        $currentDate = date('Y-m-d');
        // 获取两周前的日期
        $twoWeeksAgo = date('Y-m-d', strtotime('-2 weeks'));

        // 输出最近两周的日期
        for ($i = 13; $i >= 0; $i--) {
            $date = date('Y-m-d', strtotime("-$i days"));
            if ($date >= $twoWeeksAgo && $date <= $currentDate) {
            $data['daydata'][]=$date;
            }
        }

        $news = [];

        $days =  Db::name('user')->where('create_time','>=',strtotime($twoWeeksAgo))->order(['create_time'=>'asc'])->select()->toArray();
        foreach($days as $v){
            $todayStart = date('Y-m-d', $v['create_time']);
            if(isset($news[$todayStart])){
                $news[$todayStart]++;
            }else{
                $news[$todayStart] = 1;
            }
        }

        foreach ($data['daydata'] as $v) {
            
            if(isset($news[$v])) {
                $data['timedata'][]=$news[$v];
            } else {
                $data['timedata'][]=0;
            }
        }    
        return json_ok($data);
    }
}
