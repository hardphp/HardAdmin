<?php
// 事件定义文件
return [
    'bind'      => [
    ],

    'listen'    => [
        'AppInit'  => [],
        'HttpRun'  => [],
        'HttpEnd'  => [],
        'LogLevel' => [],
        'LogWrite' => [],
        'UserLogin'  => ['app\listener\user\UserLogin'],
        'AdminDone' => ['app\listener\admin\AdminDone'],
    ],

    'subscribe' => [
        'app\subscribe\User'
    ],
];
