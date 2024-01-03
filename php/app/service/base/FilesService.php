<?php

declare (strict_types=1);

namespace app\service\base;

use app\traits\ServiceTrait;

/**
 *文件管理
 * Class FilesService
 * @package app\service
 * @author  hardphp（2066362155@qq.com）
 */
class FilesService
{
    use ServiceTrait;
    //模型，带命名空间
    public static $model = 'app\model\base\Files';
    //模型主键
    public static $pk = 'id';
    //name字段名称
    public static $name = 'hash';

}
