<?php
declare (strict_types=1);

namespace app\util;

use think\facade\Config;
use think\facade\Log;
use WeChatPay\Builder;
use WeChatPay\Crypto\Rsa;
use WeChatPay\Util\PemUtil;
use WeChatPay\Formatter;
use WeChatPay\Crypto\AesGcm;
use think\facade\Request;


/**
 * 微信支付服务
 * Class WechatPayUtil
 * @package app\util
 * @author  hardphp（2066362155@qq.com）
 */
class WechatPayUtil
{
    /** 获取支付参数
     * @param $sub_mchid  子商户号
     * @param $order  订单信息
     * @throws \think\Exception 
     */
    public static function pay($sub_mchid,$order)
    {
        $config = Config::get("system.wechat_pay_partner");
         
         //拉起微信支付参数TODO
         // 商户号
        $merchantId = $config['sp_mchid'];
        
        // 从本地文件中加载「商户API私钥」，「商户API私钥」会用来生成请求的签名
        $merchantPrivateKeyFilePath = $config['merchantPrivateKeyFilePath'];
        $merchantPrivateKeyInstance = Rsa::from($merchantPrivateKeyFilePath, Rsa::KEY_TYPE_PRIVATE);
        
        // 「商户API证书」的「证书序列号」
        $merchantCertificateSerial = $config['merchantCertificateSerial'];
        
        // 从本地文件中加载「微信支付平台证书」，用来验证微信支付应答的签名
        $platformCertificateFilePath = $config['platformCertificateFilePath'];
        $platformPublicKeyInstance = Rsa::from($platformCertificateFilePath, Rsa::KEY_TYPE_PUBLIC);
        
        // 从「微信支付平台证书」中获取「证书序列号」
        $platformCertificateSerial = PemUtil::parseCertificateSerialNo($platformCertificateFilePath);
        
        // 构造一个 APIv3 客户端实例
        $instance = Builder::factory([
            'mchid'      => $merchantId,
            'serial'     => $merchantCertificateSerial,
            'privateKey' => $merchantPrivateKeyInstance,
            'certs'      => [
                $platformCertificateSerial => $platformPublicKeyInstance,
            ],
        ]);
        
        // 发送请求
        $resp = $instance->chain('v3/certificates')->get(
            ['debug' => false] // 调试模式，https://docs.guzzlephp.org/en/stable/request-options.html#debug
        );
        // echo $resp->getBody(), PHP_EOL;
          
        try {
            $resp = $instance
            ->chain('v3/pay/partner/transactions/jsapi')
            ->post(['json' => [
                'sp_mchid'        => $config['sp_mchid'],
                'sub_mchid'    => $sub_mchid,
                'out_trade_no' => $order['out_trade_no'],
                'sp_appid'        => $config['sp_appid'],
                'description'  => $order['description'],
                'notify_url'   => $order['notify_url'],
                'amount'       => [
                    'total'    => $order['amount']*100,
                    'currency' => 'CNY'
                ],
                'payer'=>[
            		'sp_openid'=>$order['openid'],
            	]
            ]]);
             
            if($resp->getStatusCode() == 200){
               $res = \GuzzleHttp\json_decode($resp->getBody()->__toString(), true);
                $params = [
                    'appId'     => $config['sp_appid'],
                    'timeStamp' => (string)Formatter::timestamp(),
                    'nonceStr'  => Formatter::nonce(),
                    'package'   => 'prepay_id='.$res['prepay_id'],
                ];
                $params += ['paySign' => Rsa::sign(
                    Formatter::joinedByLineFeed(...array_values($params)),
                    $merchantPrivateKeyInstance
                ), 'signType' => 'RSA'];
               return $params;
            }
            
        } catch (\Exception $e) {
            // 进行错误处理
            $res = \GuzzleHttp\json_decode($resp->getBody()->__toString(), true);
            if ($e instanceof \GuzzleHttp\Exception\RequestException && $e->hasResponse()) {
                $r = $e->getResponse();
                $res = \GuzzleHttp\json_decode($r->getBody()->__toString(), true);
                throw new \app\MyException(10002,$res['message']);
            }
            throw new \app\MyException(10002,$e->getMessage());
             
        }
        

    }
 
 
    /** 支付回调
     * @param $sub_mchid  子商户号
     * @param $order  订单信息
     * @throws \think\Exception 
     */
    public static function notify()
    {
        $config = Config::get("system.wechat_pay_partner");
        Log::write('======pay  Callback =======');
        
        $inWechatpaySignature =Request::header('Wechatpay-Signature'); // 请根据实际情况获取
        $inWechatpayTimestamp = Request::header('Wechatpay-Timestamp'); // 请根据实际情况获取
        $inWechatpaySerial = Request::header('Wechatpay-Serial'); // 请根据实际情况获取
        $inWechatpayNonce =Request::header('Wechatpay-Nonce'); // 请根据实际情况获取
        $inBody = file_get_contents('php://input'); // 请根据实际情况获取，例如: file_get_contents('php://input');
        
        Log::write($inWechatpaySignature);
        Log::write($inWechatpayTimestamp);
        Log::write($inWechatpaySerial);
        Log::write($inWechatpayNonce);
        Log::write($inBody);
        
        $apiv3Key = $config['apiv3Key'];// 在商户平台上设置的APIv3密钥
        
        // 根据通知的平台证书序列号，查询本地平台证书文件，
        $platformPublicKeyInstance = Rsa::from($config['platformCertificateFilePath'], Rsa::KEY_TYPE_PUBLIC);
        
        // 检查通知时间偏移量，允许5分钟之内的偏移
        $timeOffsetStatus = 300 >= abs(Formatter::timestamp() - (int)$inWechatpayTimestamp);
        $verifiedStatus = Rsa::verify(
            // 构造验签名串
            Formatter::joinedByLineFeed($inWechatpayTimestamp, $inWechatpayNonce, $inBody),
            $inWechatpaySignature,
            $platformPublicKeyInstance
        );
        
        Log::write($timeOffsetStatus);
        Log::write($verifiedStatus);
        
        if ($timeOffsetStatus && $verifiedStatus) {
            // 转换通知的JSON文本消息为PHP Array数组
            $inBodyArray = (array)json_decode($inBody, true);
            // 使用PHP7的数据解构语法，从Array中解构并赋值变量
            ['resource' => [
                'ciphertext'      => $ciphertext,
                'nonce'           => $nonce,
                'associated_data' => $aad
            ]] = $inBodyArray;
            // 加密文本消息解密
            $inBodyResource = AesGcm::decrypt($ciphertext, $apiv3Key, $nonce, $aad);
            // 把解密后的文本转换为PHP Array数组
            $inBodyResourceArray = (array)json_decode($inBodyResource, true);
            // print_r($inBodyResourceArray);// 打印解密后的结果
        
            Log::write($inBodyResourceArray);
            //逻辑判断
            if($inBodyResourceArray['trade_state'] == 'SUCCESS'){
                return  $inBodyResourceArray;
            }
            exit(json_encode(['code'=>'FAIL','message'=>'FAIL']));
        }
    }

}
