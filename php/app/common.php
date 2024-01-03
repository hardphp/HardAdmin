<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006-2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: 流年 <liu21st@gmail.com>
// +----------------------------------------------------------------------

// 应用公共文件

/**
 * 系统加密方法
 * @param string $data 要加密的字符串
 * @param string $key 加密密钥
 * @param int $expire 过期时间 单位 秒
 * @return string
 */
function think_encrypt($data, $key = '', $expire = 0)
{
    $key  = md5(empty($key) ? config('system.pass_salt') : $key);
    $data = base64_encode($data);
    $x    = 0;
    $len  = strlen($data);
    $l    = strlen($key);
    $char = '';

    for ($i = 0; $i < $len; $i++) {
        if ($x == $l) $x = 0;
        $char .= substr($key, $x, 1);
        $x++;
    }

    $str = sprintf('%010d', $expire ? $expire + time() : 0);

    for ($i = 0; $i < $len; $i++) {
        $str .= chr(ord(substr($data, $i, 1)) + (ord(substr($char, $i, 1))) % 256);
    }

    $str = str_replace(array('+', '/', '='), array('-', '_', ''), base64_encode($str));
    return strtoupper(md5($str)) . $str;
}

/**
 * 系统解密方法
 * @param  string $data 要解密的字符串 （必须是think_encrypt方法加密的字符串）
 * @param  string $key 加密密钥
 * @return string
 */
function think_decrypt($data, $key = '')
{
    $key  = md5(empty($key) ? config('system.pass_salt') : $key);
    $data = substr($data, 32);
    $data = str_replace(array('-', '_'), array('+', '/'), $data);
    $mod4 = strlen($data) % 4;
    if ($mod4) {
        $data .= substr('====', $mod4);
    }
    $data   = base64_decode($data);
    $expire = substr($data, 0, 10);
    $data   = substr($data, 10);

    if ($expire > 0 && $expire < time()) {
        return '';
    }
    $x    = 0;
    $len  = strlen($data);
    $l    = strlen($key);
    $char = $str = '';

    for ($i = 0; $i < $len; $i++) {
        if ($x == $l) $x = 0;
        $char .= substr($key, $x, 1);
        $x++;
    }

    for ($i = 0; $i < $len; $i++) {
        if (ord(substr($data, $i, 1)) < ord(substr($char, $i, 1))) {
            $str .= chr((ord(substr($data, $i, 1)) + 256) - ord(substr($char, $i, 1)));
        } else {
            $str .= chr(ord(substr($data, $i, 1)) - ord(substr($char, $i, 1)));
        }
    }
    return base64_decode($str);
}

/**
 * 请求正确返回
 * @param string $msg
 * @param array $data
 * @return json
 */
function json_ok($data = [], $code = 10000, $msg = '')
{
    $result['status'] = 1;
    $result['data']   = $data;
    $result['msg']    = isset(config('error')[$code]) ? config('error')[$code] : '';
    $result['code']   = $code;
    return json($result);
}

/**
 * 请求错误返回
 * @param string $code
 * @param string $msg
 * @return json
 */
function json_error($code = 10001, $msg = '')
{
    if ($msg == '') {
        $result['msg'] = isset(config('error')[$code]) ? config('error')[$code] : '';
    } else {
        $result['msg'] = $msg;
    }
    $result['status'] = 0;
    $result['code']   = $code;
    return json($result);
}

/**
 * 用户密码加密方法，可以考虑盐值包含时间（例如注册时间），
 * @param string $pass 原始密码
 * @return string 多重加密后的32位小写MD5码
 */
function encrypt_pass($pass)
{
    if ('' == $pass) {
        return '';
    }
    $salt = config('app.pass_salt');
    return md5(sha1($pass) . $salt);
}

/**
 * 数据 类型转换
 * @access protected
 * @param  mixed $value 值
 * @param  string|array $type 要转换的类型
 * @return mixed
 */
function transform($value, $type)
{
    if (is_null($value)) {
        return;
    }

    if (is_array($type)) {
        [$type, $param] = $type;
    } elseif (strpos($type, ':')) {
        [$type, $param] = explode(':', $type, 2);
    }

    switch ($type) {
        case 'string':
            $value = (string)$value;
            break;
        case 'integer':
            $value = (int)$value;
            break;
        case 'float':
            if (empty($param)) {
                $value = (float)$value;
            } else {
                $value = (float)number_format($value, (int)$param, '.', '');
            }
            break;
        case 'boolean':
            $value = (bool)$value;
            break;
        case 'timestamp':
            if (!is_numeric($value)) {
                $value = strtotime($value);
            }
            break;
        case 'datetime':
            $value = is_numeric($value) ? $value : strtotime($value);
            if (empty($param)) {
                $value = date('Y-m-d H:i:s', $value);
            } else {
                $value = date($param, $value);
            }
            break;
        case 'object':
            if (is_object($value)) {
                $value = json_encode($value, JSON_FORCE_OBJECT);
            }
            break;
        case 'array':
            $value = (array)$value;
        case 'json':
            $option = !empty($param) ? (int)$param : JSON_UNESCAPED_UNICODE;
            $value  = json_encode($value, $option);
            break;
        case 'serialize':
            $value = serialize($value);
            break;
        default:
            break;
    }

    return $value;
}


/*移动端判断*/

function isMobile()
{
    // 如果有HTTP_X_WAP_PROFILE则一定是移动设备
    if (isset ($_SERVER['HTTP_X_WAP_PROFILE']))
    {
        return true;
    }
    // 如果via信息含有wap则一定是移动设备,部分服务商会屏蔽该信息
    if (isset ($_SERVER['HTTP_VIA']))
    {
        // 找不到为flase,否则为true
        return stristr($_SERVER['HTTP_VIA'], "wap") ? true : false;
    }
    // 脑残法，判断手机发送的客户端标志,兼容性有待提高
    if (isset ($_SERVER['HTTP_USER_AGENT']))
    {
        $clientkeywords = array ('nokia',
            'sony',
            'ericsson',
            'mot',
            'samsung',
            'htc',
            'sgh',
            'lg',
            'sharp',
            'sie-',
            'philips',
            'panasonic',
            'alcatel',
            'lenovo',
            'iphone',
            'ipod',
            'blackberry',
            'meizu',
            'android',
            'netfront',
            'symbian',
            'ucweb',
            'windowsce',
            'palm',
            'operamini',
            'operamobi',
            'openwave',
            'nexusone',
            'cldc',
            'midp',
            'wap',
            'mobile'
            );
        // 从HTTP_USER_AGENT中查找手机浏览器的关键字
        if (preg_match("/(" . implode('|', $clientkeywords) . ")/i", strtolower($_SERVER['HTTP_USER_AGENT'])))
        {
            return true;
        }
    }
    // 协议法，因为有可能不准确，放到最后判断
    if (isset ($_SERVER['HTTP_ACCEPT']))
    {
        // 如果只支持wml并且不支持html那一定是移动设备
        // 如果支持wml和html但是wml在html之前则是移动设备
        if ((strpos($_SERVER['HTTP_ACCEPT'], 'vnd.wap.wml') !== false) && (strpos($_SERVER['HTTP_ACCEPT'], 'text/html') === false || (strpos($_SERVER['HTTP_ACCEPT'], 'vnd.wap.wml') < strpos($_SERVER['HTTP_ACCEPT'], 'text/html'))))
        {
            return true;
        }
    }
    return false;
}

/**
 * $url 
 * $data
 */
function curl_post($url,$data){
    $curl = curl_init();
    //数组排序
    curl_setopt_array($curl, array(
        CURLOPT_URL => $url,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POSTFIELDS => http_build_query($data)
    ));
    $response = curl_exec($curl);
    curl_close($curl);
    $rtn = json_decode($response);
    return $rtn;
}


/**
*下划线命名的字符串转换为驼峰命名

*/
function unders_to_camel($underscoreString){

    // 将下划线替换为空格，并将每个单词的首字母大写
    $camelCaseString = str_replace('_', ' ', $underscoreString);
    $camelCaseString = ucwords($camelCaseString);
    
    // 去除空格，并将第一个单词的首字母小写
    $camelCaseString = str_replace(' ', '', $camelCaseString);
    //$camelCaseString = lcfirst($camelCaseString);

    return $camelCaseString; 

}

