<?php

declare (strict_types=1);

namespace app\validate\base;

use think\Validate;

/**
 * 应用
 * Class App
 * @package app\validate
 * @author  hardphp（2066362155@qq.com）
 */
class App extends Validate
{
    //验证规则
    protected $rule = [
        'title'     => ['require'],
        'appid'     => ['require', 'alphaNum'],
    ];

    //提示信息
    protected $message = [
        'title.require'      => '名称必须',
        'appid.require'      => 'appid必须',
        'appid.alphaNum'     => 'appid必须是字母或者数字',
    ];

    //验证场景
    protected $scene = [
        'save' => ['title','appid'],
    ];


}
