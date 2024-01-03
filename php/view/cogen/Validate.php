<?php

declare (strict_types=1);

namespace app\validate\cogen;

use think\Validate;

/**
 * {%tableComment%} {%datetime%}
 * Class {%tableName%}
 * @package app\validate
 * @author  hardphp（2066362155@qq.com）
 */
class {%tableName%} extends Validate
{
    //验证规则
    protected $rule = {%rule%}

    //提示信息
    protected $message = {%message%}
    //验证场景
    protected $scene = [
        'save'   => {%savescene%},
    ];

}
