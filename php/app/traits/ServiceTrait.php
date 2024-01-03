<?php
declare (strict_types=1);

namespace app\traits;

/**
 * 逻辑服务公共方法
 * Trait ServiceTrait
 * @package app\traits
 * @author  hardphp（2066362155@qq.com）
 */
trait ServiceTrait
{

    /**
     * 通过ID获取信息
     * @param $id
     * @param $field 获取字段
     * @param $where 附加条件
     * @return mixed
     */
    public static function getInfoById($id, $field = [], $where = true)
    {
        return self::$model::where([self::$pk => $id])->where($where)->field($field ?: self::$model::$showField)->find();
    }

    /**
     * 通过name获取信息
     * @param $name
     * @param $field 获取字段
     * @param $where 附加条件
     * @return mixed
     */
    public static function getInfoByName($name, $field = [], $where = true)
    {
        return self::$model::where([self::$name => $name])->where($where)->field($field ?: self::$model::$showField)->find();
    }

    /**
     * 通过多条件获取单条信息
     * @param $where
     * @param $field 获取字段
     * @param $where 附加条件
     * @return mixed
     */
    public static function getInfoByWhere($where, $field = [])
    {
        return self::$model::where($where)->field($field ?: self::$model::$showField)->find();
    }

    /**
     * 获取列表,分頁
     * @param bool $where 查询条件
     * @param array $myorder 排序
     * @param int $page 页码
     * @param int $psize 分页大小
     * @param array $field 获取字段
     * @return mixed
     */
    public static function getLists($where, $myorder, $page = 1, $psize = 20, $field = [])
    {
        return self::$model::where($where)->order($myorder)->page($page, $psize)->field($field ?: self::$model::$showField)->select();
    }

    /**
     * 获取全部列表
     * @param bool $where 查询条件
     * @param array $myorder 排序
     * @param array $field 获取字段
     * @return mixed
     */
    public static function getListsAll($where, $myorder, $field = [])
    {
        return self::$model::where($where)->order($myorder)->field($field ?: self::$model::$showField)->select();
    }

        
    /**
     * 获取全部列表,id下标
     * @param bool $where 查询条件
     * @param array $myorder 排序
     * @param array/string $field 获取字段
     * @return mixed
     */
    public static function getListsIdName($where, $myorder, $field,$key='id')
    {
        return self::$model::where($where)->order($myorder)->column($field,$key);
    }

    /**
     * 查询数量
     * @param bool $where 查询条件
     * @return mixed
     */
    public static function getTotal($where)
    {
        return self::$model::where($where)->count();
    }

    /**
     * 新增
     * @param $data
     */
    public static function add($data)
    {
        return self::$model::create($data);
    }
    
    /**
     * 批量新增 
     **/
    public static function addAll($data){
        return self::$model::insertAll($data);
    }
    /**
     * 修改
     * @param $id
     * @param $data
     */
    public static function edit($id, $data)
    {
        return self::$model::update($data, [self::$pk => $id]);
    }

    /**
     * 删除
     * @param int/array $id
     * @return int
     */
    public static function del($id)
    {
        return self::$model::destroy($id);
    }
    /**
     * 根据条件获取某列
     * @param array $where
     * @param string $field
     * @return array
     */
    public static function getColumnByWhere(array $where,string $field){
        if(empty($where))$where = true;
        return self::$model::where($where)->column($field)?:[];
    }

    /**
     * 根据条件删除数据，没有条件拒绝删除
     * @param array $where
     * @return bool
     */
    public static function delByWhere(array $where){
        if(empty($where))return false;
        return self::$model::where($where)->delete();
    }
    
    /**
     * 根据条件更新数据
     * @param array $where
     * @param string $data
     */
    public static function updateByWhere($where,$data){
        return self::$model::where($where)->update($data);
    }

    /**
     * 保存
     * @param $data 数据
     * @param $id 主键id
     * @return bool|int
     */
    public static function save($data, $id = 0)
    {
        if ($id) {
            $result = self::edit($id, $data);
        } else {
            $result = self::add($data);
            $id     = $result->id;
        }

        if ($result) {
            return $id;
        } else {
            return false;
        }
    }
    
    /**
     * 获取统计数据
     * @param bool $where 查询条件
     * @param array $fields 求和字段
     * @return mixed
     */
    public static function getSumTotal($where,$fields)
    {
        if(empty($fields)){
            return [];
        }
        
        $data=[];
        foreach ($fields as $v){
            $data[$v]  = self::$model::where($where)->sum($v);
        }
        
        return $data;
    }

}