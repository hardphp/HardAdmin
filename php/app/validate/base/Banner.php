<?php

declare (strict_types=1);

namespace app\validate\base;

use think\Validate;

/**
 * 轮播
 * Class Banner
 * @package app\validate
 * @author  hardphp（2066362155@qq.com）
 * @date 2019-11-27
 */
class Banner extends Validate
{
    //验证规则
    protected $rule = [
        'title'     => ['require'],
        'img'   => ['require'],
    ];

    //提示信息
    protected $message = [
        'title'     => '标题必填',
        'img'   => '请上传图片',
    ];
    //验证场景
    protected $scene = [
        'save'   => ['title', 'img'],
    ];

}
