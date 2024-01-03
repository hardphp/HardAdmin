<?php

return [
    // 默认磁盘
    'default' => env('filesystem.driver', 'local'),
    // 磁盘列表
    'disks'   => [
        'local'  => [
            'type' => 'local',
            'root' => app()->getRuntimePath() . 'storage',
        ],
        'public' => [
            // 磁盘类型
            'type'       => 'local',
            // 磁盘路径
            'root'       => app()->getRootPath() . 'public/storage',
            // 磁盘路径对应的外部URL路径
            'url'        => '/storage',
            // 可见性
            'visibility' => 'public',
        ],
        // 更多的磁盘配置信息
        'aliyun' => [
            'type'         => '\\thans\\filesystem\\driver\\Aliyun',
            'accessId'     => '',
            'accessSecret' => '',
            'bucket'       => '',
            'endpoint'     => 'oss-cn-beijing.aliyuncs.com',
            'url'          => '',//不要斜杠结尾，此处为URL地址域名。
        ],
        'qiniu'  => [
            'type'      => '\\thans\\filesystem\\driver\\Qiniu',
            'accessKey' => '******',
            'secretKey' => '******',
            'bucket'    => 'bucket',
            'url'       => '',//不要斜杠结尾，此处为URL地址域名。
        ],
        'qcloud' => [
            'type'       => '\\thans\\filesystem\\driver\\Qcloud',
            'region'      => 'ap-nanjing', //bucket 所属区域 英文
            'appId'      => '', // 域名中数字部分
            'secretId'   => '',
            'secretKey'  => '',
            'bucket'          => '',
            'timeout'         => 60,
            'connect_timeout' => 60,
            'cdn'             => '',
            'scheme'          => 'https',
            'read_from_cdn'   => false,
        ]
    ],
];
