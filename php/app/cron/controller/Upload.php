<?php

declare (strict_types=1);

namespace app\cron\controller;

use think\annotation\route\Group;
use app\cron\controller\Base;
use app\traits\UploadTrait;

/**
 * 文件上传
 * Class Upload
 * @package app\cron\controller;
 * @author  hardphp（2066362155@qq.com）
 * @Group("upload")
 */
class Upload extends Base
{
    use UploadTrait;
}
