<?php
declare (strict_types=1);
namespace app\validate\admin;

use think\Validate;

/**
 * 规则
 * Class AuthRule
 * @package app\validate
 * @author  hardphp（2066362155@qq.com）
 * @date 2019-11-27
 */
class AuthRule extends Validate
{
    //验证规则
    protected $rule = [
        'name'      => ['require'],
        //'path'      => ['require'],
    ];

    //提示信息
    protected $message = [
        'name'      => '名称必填',
        //'path'      => '路径必填',
    ];


}
