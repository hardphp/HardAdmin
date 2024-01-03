<?php
declare (strict_types=1);

namespace app\job;

use think\queue\Job;
use app\service\base\SmsService;
use app\service\base\FailedJobsService;

/**
 * 短信任务
 * Class Sms
 * @package app\job
 * @author hardphp（2066362155@qq.com）
 */
class Sms
{
    //任务处理
    public function fire(Job $job, $data)
    {
        //尝试3次失败剔除任务
        if ($job->attempts() > 3) {
            $job->delete();
        }
        $res = SmsService::sendCode($data['phone'], $data['type'],$data['channel']);
        if ($res) {
            //执行成功删除任务
            $job->delete();
        } else {
            //延迟时间10s执行
            $job->release(10);
        }


    }

    public function failed($data)
    {
        //失败任务保存到数据库
        FailedJobsService::save([
            'type'        => 2,
            'data'        => json_encode($data),
            'create_time' => time(),
            'update_time' => time(),
        ]);
    }

}