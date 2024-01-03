<?php
// +----------------------------------------------------------------------
// | 系统设置
// +----------------------------------------------------------------------

use think\facade\Env;

return [
    'jwt_secret_key' => 'HardAdmin',
    // jwt算法 ，可配置的值取决于使用的jwt包支持哪些算法
    'jwt_algorithm' => 'HS256',
    //加密盐值
    'pass_salt' => 'HardAdmin',
    // app接口加密安全key
    'app_sign_key' => 'HardAdmin',
    //用户登录有效期
    'user_login_time' => 60 * 60 * 24 * 7,

    //小程序配置
    'wechat_mini' => [

        'app_id' => Env::get('wechat.app_id', ''),
        'secret' => Env::get('wechat.min_secret', ''),

        // 下面为可选项
        // 指定 API 调用返回结果的类型：array(default)/collection/object/raw/自定义类名
        'response_type' => 'array',

        'log' => [
            'level' => 'debug',
            'file' => __DIR__ . '/../runtime/wechat_mini.log',
        ]
    ],
    //企业微信配置，用于easywechat
    'wechat_work' => [

        'corp_id' => Env::get('wechat.corp_id', ''),

        'agent_id' => Env::get('wechat.agent_id', ''), // 如果有 agend_id 则填写
        'secret' => Env::get('wechat.secret', ''),    //应用secret

        // 指定 API 调用返回结果的类型：array(default)/collection/object/raw/自定义类名
        'response_type' => 'array',

        'log' => [
            'level' => 'debug',
            'file' => __DIR__ . '/../runtime/wechat_work.log',
        ]
    ],
    //企业微信配置
    'wechat_corp' => [
        //客户联系secret
        'cus_secret' => Env::get('wechat.cus_secret', ''),
        //用于回调加解密
        'corp_id' => Env::get('wechat.corp_id', ''),
        'token' => Env::get('wechat.token', ''),
        'encodingAESKey' => Env::get('wechat.encodingAESKey', ''),
    ],
    
     //企业支付服务商v3
    'wechat_pay_partner' => [
        //服务商号
        'sp_mchid' => Env::get('wechat_pay_partner.merchantId', ''),
        'sp_appid' => Env::get('wechat_pay_partner.sp_appid', ''),
        'apiv3Key' => Env::get('wechat_pay_partner.apiv3Key', ''),  
        // 从本地文件中加载「微信支付平台证书」，用来验证微信支付应答的签名，本地生成
        'platformCertificateFilePath' => Env::get('wechat_pay_partner.platformCertificateFilePath', ''),
        //「商户API证书」的「证书序列号」
        'merchantCertificateSerial' => Env::get('wechat_pay_partner.merchantCertificateSerial', ''),
        // 从本地文件中加载「商户API私钥」，「商户API私钥」会用来生成请求的签名
        'merchantPrivateKeyFilePath' => Env::get('wechat_pay_partner.merchantPrivateKeyFilePath', ''),
    ],

    //短信配置
    'sms' => [
        'info' => [
            'send_url' => '',
            'send_tp_url' => '',
            'username' => '',
            'password' => '',
        ],
        //模板
        'con' => '【XX】您的验证码为：@，有效时间10分钟'
    ],
    'email' => [
        'Host' => 'smtp.qq.com',
        'Username' => '',
        'Password' => '',
        'Port' => '465',
        'title' => '发件人名称',
        'Subject' => '标题',
        'Body' => '您的验证码是：@， <br/> 验证码的有效期为10分钟，为不影响您的正常操作，请您及时完成验证。<br/>如非本人操作，请忽略此邮件',

    ]
];
