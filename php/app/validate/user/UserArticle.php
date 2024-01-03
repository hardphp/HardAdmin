<?php

declare (strict_types=1);

namespace app\validate\user;

use think\Validate;

/**
 * 用户参与
 * Class UserArticle
 * @package app\validate
 * @author  hardphp（2066362155@qq.com）
 * @date 2019-11-27
 */
class UserArticle extends Validate
{
    //验证规则
    protected $rule = [
        'realname'   => ['require'],
        'phone'      => ['regex' => '/1[3458]{1}\d{9}$/'],
        'status'    => ['require']
    ];

    //提示信息
    protected $message = [
        'realname'     => '请输入姓名',
        'phone.regex'  => '手机格式错误',
        'status'     => '请选择状态',
    ];

    //验证场景
    protected $scene = [
        'save'          => ['status'],
    ];


}
