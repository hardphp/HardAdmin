<?php

// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
use think\facade\Route;
use think\facade\Env;


Route::get('/admin', function() {
     if(Env::get('SWAGGER.START', 0)) {
        $openapi = \OpenApi\Generator::scan(['../app/admin/controller']);
        header('Content-Type: application/json');
        echo $openapi->toJson();
     }
});

Route::get('/api', function() {
     if(Env::get('SWAGGER.START', 0)) {
        $openapi = \OpenApi\Generator::scan(['../app/api/controller']);
        header('Content-Type: application/json');
        echo $openapi->toJson();
     }
});

