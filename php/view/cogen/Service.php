<?php

declare (strict_types=1);

namespace app\service\cogen;

use app\traits\ServiceTrait;

/**
 * {%tableComment%} {%datetime%}
 * Class {%tableName%}Service
 * @package app\service
 * @author  hardphp（2066362155@qq.com）
 */
class  {%tableName%}Service
{
    use ServiceTrait;
    //模型，带命名空间
    public static $model = 'app\model\cogen\{%tableName%}';
    //模型主键
    public static $pk = 'id';
    //name字段名称
    public static $name = '{%name%}';

}
