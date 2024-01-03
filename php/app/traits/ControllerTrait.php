<?php

declare (strict_types=1);

namespace app\traits;

/**
 * 控制器公共方法
 * Trait ControllerTrait
 * @package app\traits
 * @author  hardphp（2066362155@qq.com）
 */
trait ControllerTrait
{
    //查询条件前置处理
    public function beforeIndex()
    {
        return [true, [],[],[]];
    }

    //查询权限处理
    public function beforeIndexAuth($where)
    {
        return $where;
    }

    /**
     * 列表,分页
     * @Route("index", method="POST")
     */
    public function index()
    {
        //$order = input('order/a', ['id' => 'desc']);
        $page  = input('page', 1, 'intval');
        $psize = input('psize', 20, 'intval');

        list($where, $field, $order, $sumfield) = $this->beforeIndex();

        $where = $this->beforeIndexAuth($where);

        if(empty($order)) {
            $order = ['id' => 'desc'];
        }

        $lists           = self::$service::getLists($where, $order, $page, $psize, $field);
        $result['total'] = self::$service::getTotal($where);
        $result['tongji']  =self::$service::getSumTotal($where, $sumfield);
        $result['data']  = $this->afterIndex($lists);

        return json_ok($result);
    }

    //查询结果后置处理
    public function afterIndex($data)
    {
        return $data;
    }

    //查询条件前置处理
    public function beforeGetLists()
    {
        return [true, [],[]];
    }

     //查询权限处理
    public function beforeGetListsAuth($where)
    {
        return $where;
    }

    /**
     * 列表,不分页
     * @Route("getlists", method="POST")
     */
    public function getlists()
    {
        list($where, $field, $order) = $this->beforeGetLists();

        $where = $this->beforeGetListsAuth($where);

        if(empty($order)) {
            $order = ['id' => 'asc'];
        }

        $lists           = self::$service::getListsAll($where, $order, $field);
        $result['total'] = self::$service::getTotal($where);
        $result['data']  = $this->afterLists($lists);
        return json_ok($result);
    }

    //查询结果后置处理
    public function afterLists($data)
    {
        return $data;
    }


    //查询条件前置处理
    public function beforeGetListsIdName()
    {
        return [true, [],[],'id'];
    }

  /**
     * 获取全部列表,id下标
     * @param bool $where 查询条件
     * @param array $myorder 排序
     * @param array/string $field 获取字段
     * @Route("getListsIdName", method="POST")
     */
    public function getListsIdName()
    {
        list($where, $myorder, $field, $key) = $this->beforeGetListsIdName();
        if(empty($myorder)) {
            $myorder = ['id' => 'asc'];
        }
        $lists =  self::$service::getListsIdName($where, $myorder, $field, $key);
        $result['data']  = $lists;
        return json_ok($result);
    }

    //详情前置处理
    public function beforeGetInfo($id)
    {
        return [true, []];
    }

    /**
     * 详情
     * @Route("getinfo", method="POST")
     */
    public function getinfo()
    {
        $id = input('id', '0', 'int');
        if ($id == 0) {
            return json_error(10004);
        }

        list($where, $field) = $this->beforeGetInfo($id);

        $info = self::$service::getInfoById($id, $field, $where);
        $info = $this->afterGetInfo($info);
        return json_ok($info);
    }

    //详情后置处理
    public function afterGetInfo($data)
    {
        return $data;
    }

    //保存前置数据处理
    public function beforeSave($id)
    {
        return true;
    }

    /**
     * 保存
     * @Route("save", method="POST")
     */
    public function save()
    {
        $id = input('id', '0', 'int');
        //接收数据
        $data     = $this->beforeSave($id);
        $validate = validate(self::$validateName);
        if (self::$validateScene) {
            $result = $validate->scene(self::$validateScene)->check($data);
        } else {
            $result = $validate->check($data);
        }
        if (!$result) {
            $error = $validate->getError();
            return json_error($error);
        }

        if (isset($data['id'])) {
            unset($data['id']);
        }

        $res = self::$service::save($data, $id);
        if ($res == false) {
            return json_error(10005);
        } else {
            $result = $this->afterSave($res, $data);
            return $result;
        }
    }

    /**
     * 保存后数据处理
     */
    public function afterSave($id, $data)
    {
        return json_ok(['id' => strval($id)], 10006);
    }

    /**
     * 删除前数据处理
     * $id
     */
    public function beforeDel($id)
    {
        return true;
    }

    /**
     * 删除
     * @Route("del", method="POST")
     */
    public function del()
    {
        $id = input('id', '0', 'int');
        if ($id == 0) {
            return json_error(10004);
        } else {
            $res = $this->beforeDel($id);
            if(!$res) {
                return json_error(10007);
            }
            if (self::$service::del($id)) {
                return json_ok([], 10008);
            } else {
                return json_error(10007);
            }
        }
    }

    /**
     * 删除前数据处理
     * $id
     */
    public function beforeDelAll($ids)
    {
        return true;
    }

    /**
     * 批量删除
     * @Route("delall", method="POST")
     */
    public function delall()
    {
        $ids = input('ids', '', 'trim');

        if (empty($ids)) {
            return json_error(10004);
        } else {
            $res = $this->beforeDelAll($ids);
            if(!$res) {
                return json_error(10004);
            }
            $ids = explode(',', $ids);
            self::$service::del($ids);
            return json_ok([], 10008);
        }
    }

    /**
     * 状态变更
     * @Route("change", method="POST")
     */
    public function change()
    {
        $val   = input('val', '', 'int');
        $field = input('field', '', 'trim');
        $value = input('value', '', 'int');
        if (empty($val) || $value === '') {
            return json_error(10004);
        }

        if (empty($field) || !isset(self::$enableField[$field])) {
            return json_error(10004);
        }
        if (!in_array($value, self::$enableField[$field])) {
            return json_error(10004);
        }

        $res = self::$service::save([$field => $value, 'update_time' => time()], $val);
        if ($res) {
            return json_ok([], 10006);
        } else {
            return json_error(10005);
        }

    }

    /**
     * 状态批量变更
     * @Route("changeall", method="POST")
     */
    public function changeall()
    {
        $val   = input('val', '', 'trim');
        $field = input('field', '', 'trim');
        $value = input('value', '', 'int');
        if (empty($val) || $value === '') {
            return json_error(10004);
        }
        if (empty($field) || !isset(self::$enableField[$field])) {
            return json_error(10004);
        }
        if (!in_array($value, self::$enableField[$field])) {
            return json_error(10004);
        }

        $ids = explode(',', $val);
        foreach ($ids as $v) {
            self::$service::save([$field => $value, 'update_time' => time()], $v);
        }
        return json_ok([], 10006);
    }

    /**
     * 排序
     * @Route("sort", method="POST")
     */
    public function sort()
    {
        $listOrder = input('listOrder/a');
        foreach ($listOrder as $id => $sorts) {
            self::$service::save(['sorts' => $sorts, 'update_time' => time()], $id);
        }
        return json_ok([], 10006);
    }

}
