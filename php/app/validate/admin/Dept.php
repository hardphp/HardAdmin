<?php
declare (strict_types=1);

namespace app\validate\admin;

use think\Validate;

/**
 * 部门
 * Class Dept
 * @package app\validate
 * @author  hardphp（2066362155@qq.com）
 * @date 2019-11-27
 */
class Dept extends Validate
{
    //验证规则
    protected $rule = [
        'dept_name' => ['require'],
    ];

    //提示信息
    protected $message = [
        'dept_name.require'   => '名称必须',
    ];

    //验证场景
    protected $scene = [
        'save'   => ['dept_name'],
    ];


}
