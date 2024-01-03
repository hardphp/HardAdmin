<?php

declare (strict_types=1);

namespace app\admin\controller;

use think\annotation\route\Group;
use think\annotation\Route;
use think\annotation\route\Middleware;
use app\admin\controller\Base;
use app\traits\ControllerTrait;
use app\admin\middleware\CheckAdmin;

/**
 * 代码生成
 * Class Cogen
 * @package app\admin\controller
 * @author  hardphp（2066362155@qq.com）
 * @Group("cogen")
 * @Middleware({CheckAdmin::class})
 */
class Cogen extends Base
{
    use ControllerTrait;
    //服务，带命名空间
    public static $service = 'app\service\base\CogenService';
    //验证器名称
    public static $validateName = 'app\validate\base\Cogen';
    //保存验证场景
    public static $validateScene = 'save';
    //状态变更允许字段,格式 字段名：允许值
    public static $enableField = [];

    //查询条件前置处理
    public function beforeIndex()
    {
        //搜索参数
        $table      = input('table', '', 'trim');

        $where = true;
        if ($table) {
            $where .= " and table = " . $table . " ";
        }

        return [$where, [],['id' => 'desc'],[]];
    }

    //详情后置处理
    public function afterGetInfo($data)
    {
        $arr = $data->toArray();
        $arr['search'] = json_decode($arr['search'],true);
        $arr['lists'] = json_decode($arr['lists'],true);
        $arr['form'] = json_decode($arr['form'],true);
        $arr['show_field'] = json_decode($arr['show_field'],true);
        $arr['form_require'] = json_decode($arr['form_require'],true);
        if(empty($arr['field_rule']) && $arr['table']){
            $arr['field_rule'] = self::$service::getFieldRule($arr['table']);
        }else{
            $arr['field_rule'] = json_decode($arr['field_rule'],true);
        }
        
        

        return $arr;
    }


    //保存前置处理
    public function beforeSave($id)
    {
        //接收数据
        $data = [
            'table'     => input('table', '', 'trim'),
            'comment'   => input('comment', '', 'trim'),
            'search'    => json_encode(input('search', '', 'trim')),
            'lists'     => json_encode(input('lists', '', 'trim')),
            'form'      => json_encode(input('form', '', 'trim')),
            'show_field'   => json_encode(input('show_field', '', 'trim')),
            'name'         => input('name', '', 'trim'),
            'userid'       => input('userid', '', 'trim'),
            'islogin'      => input('islogin', '', 'trim'),
            'isauth'      => input('isauth', '', 'trim'),
            'form_require' => json_encode(input('form_require', '', 'trim')),
            'field_rule'  => json_encode(input('field_rule', '', 'trim')),
        ];
         
        return $data;
    }

    /**
     * 查询数据表
     * @Route("gettables", method="POST")
     */
    public function gettables()
    {
        $data = self::$service::getTables();
        return json_ok($data);
    }
    
    /**
     * 查询数据表
     * @Route("gettablechild", method="POST")
     */
    public function gettablechild()
    {
        $lists = [];
        $data = self::$service::getTables();
        foreach($data as $k => $v){
            $temp=[];
            $children = self::$service::getTableFields($v);
            foreach ($children as $v2){
                $temp2 = [];
                $temp2['id'] = $v2['field'];
                $temp2['name'] = $v2['field'];
                 $temp['children'][] = $temp2;
            }
            
            $temp['id'] = $v;
            $temp['name'] = $v;
            
            $lists[] = $temp;
            
        }
        return json_ok($lists);
    }

    /**
     * 查询表字段
     * @Route("gettablefields", method="POST")
     */
    public function gettablefields()
    {
        $table      = input('table', '', 'trim');
        if(!$table){
            return json_error('10002');
        }
        $data = self::$service::getTableFields($table);
        $comment = self::$service::getTableComment($table);
        return json_ok(['data'=>$data,'comment'=>$comment]);
    }

    /**
     * 查询表字段规则
     * @Route("getfieldrule", method="POST")
     */
    public function getfieldrule(){
        $table      = input('table', '', 'trim');
        if(!$table){
            return json_error('10002');
        }
        $data = self::$service::getFieldRule($table);
        return json_ok($data);
    }
    
    
    /**
     * 获取代码
     * @Route("getcode", method="POST")
     */
    public function getcode(){
        $table      = input('table', '', 'trim');
        if(!$table){
            return json_error('10002');
        }
        $data = self::$service::getCode($table);
        return json_ok($data);
    }
    
    /**
     * 下载代码
     * @Route("getcodezip", method="POST")
     */
    public function getcodezip(){
        $table      = input('table', '', 'trim');
        if(!$table){
            return json_error('10002');
        }
        $data = self::$service::getcodezip($table);
        return json_ok($data);
    }
    
    
       /**
     * 生成代码
     * @Route("tocode", method="POST")
     */
    public function tocode(){
        $id      = input('id', '', 'trim');
        if(!$id){
            return json_error('10002');
        }
        $data = self::$service::toCode($id);
        return json_ok($data);
    }


}