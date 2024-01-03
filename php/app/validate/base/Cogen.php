<?php

declare (strict_types=1);

namespace app\validate\base;

use think\Validate;

/**
 * 代码生成
 * Class App
 * @package app\validate
 * @author  hardphp（2066362155@qq.com）
 */
class Cogen extends Validate
{
    //验证规则
    protected $rule = [
        'table'         => ['require'],
        'comment'       => ['require'],
        'search'        => ['require'],
        'lists'         => ['require'],
        'form'          => ['require'],
        'show_field'    => ['require'],
        'name'          => ['require'],
        'form_require'  => ['require'],
        'field_rule'  => ['require'],
    ];

    //提示信息
    protected $message = [
        'table.require'      => '数据表名必须',
        'comment.require'    => '数据表注释必须',
        'search.require'     => '列表搜索字段必须',
        'lists.require'      => '列表展示字段必须',
        'form.require'       => '表单字段必须',
        'show_field.require' => '显示的属性必须',
        'name.require'       => '检索字段必须',
        'field_rule.require'       => '字段规则必须',
    ];

    //验证场景
    protected $scene = [
        'save' => ['table','comment','search','lists','form','show_field','name','form_require','field_rule'],
    ];
}