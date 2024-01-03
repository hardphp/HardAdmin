<?php

declare (strict_types=1);

namespace app\traits;

use app\service\base\FilesService;
use think\annotation\Route;
use think\facade\Env;

/**
 * 文件上传公共方法
 * Trait UploadTrait
 * @package app\traits
 */
trait UploadTrait
{
    /**
     * 上传图片
     * @Route("upimg", method="POST")
     */
    public function upimg()
    {
        $file = request()->file('img');
        if (empty($file)) {
            return json_error(10010);
        }
        try {
            validate(['img' => 'fileSize:10485670|fileExt:jpg,gif,jpeg,png|fileMime:image/jpeg,image/gif,image/png'])->check(request()->file());
            //上传文件
            $savename = \think\facade\Filesystem::putFile('images', $file);
            $savename = str_replace("\\", "/", $savename);

            $driver = Env::get('filesystem.driver', 'public');
            if($driver == 'aliyun') {
                $path     = config('filesystem.disks.aliyun.url') . '/' . $savename;
            } else if($driver == 'qcloud') {
                $path     = config('filesystem.disks.qcloud.cdn') . '/' . $savename;
            } else if($driver == 'qiniu') {
                $path     = config('filesystem.disks.qiniu.url') . '/' . $savename;
            } else {
                $path     = config('app.app_host').config('filesystem.disks.public.url') . '/' . $savename;
            }
            //保存数据库
            $res = FilesService::save([
                 'hash'  => $file->hash('sha1'),
                'title' => $file->getOriginalName(),
                'mine' => $file->getOriginalMime(),
                'types' => 1,
                'size' => $file->getSize(),
                'url' => $path,
            ]);

            if (!$res) {
                return json_error(10012);
            }
            return json_ok(['path' => $path]);
        } catch (\think\exception\ValidateException $e) {
            return json_error($e->getMessage());
        }
    }

    /**
     * 上传多图
     * @Route("upimgs", method="POST")
     */
    public function upimgs()
    {
        $files = request()->file('imgs');
        if (empty($files)) {
            return json_error(10010);
        }

        try {
            validate(['imgs' => 'fileSize:10485670|fileExt:jpg,gif,jpeg,png|fileMime:image/jpeg,image/gif,image/png'])->check(request()->file());
            $savename = [];
            $driver = Env::get('filesystem.driver', 'public');
            $imgs = [];
            foreach ($files as $file) {

                $savename = \think\facade\Filesystem::putFile('images', $file);
                $savename= str_replace('\\', '/', $savename);
                if($driver == 'aliyun') {
                    $path     = config('filesystem.disks.aliyun.url') . '/' . $savename;
                } else if($driver == 'qcloud') {
                    $path     = config('filesystem.disks.qcloud.cdn') . '/' . $savename;
                } else if($driver == 'qiniu') {
                    $path     = config('filesystem.disks.qiniu.url') . '/' . $savename;
                }else {
                    $path     = config('app.app_host').config('filesystem.disks.public.url') . '/' . $savename;
                }
                //保存数据库
                $res = FilesService::save([
                    'hash'  => $file->hash('sha1'),
                    'title' => $file->getOriginalName(),
                    'mine' => $file->getOriginalMime(),
                    'types' => 1,
                    'size' => $file->getSize(),
                    'url' => $path,
                ]);
                if (!$res) {
                    return json_error(10012);
                }
                $imgs[] = $path;
            }
            return json_ok(['path' => $imgs]);
        } catch (\think\exception\ValidateException $e) {
            return json_error($e->getMessage());
        }
    }

    /**
     * 上传视频
     * @Route("upvedio", method="POST")
     */
    public function upvedio()
    {
        $file = request()->file('vedio');
        if (empty($file)) {
            return json_error(10011);
        }
        try {
            validate(['vedio' => 'fileSize:104856700|fileExt:mp4,flv,webm,ogv|fileMime:video/mp4,application/octet-stream,video/webm,video/ogg'])->check(request()->file());
            $savename = \think\facade\Filesystem::putFile('vedios', $file);
            $savename = str_replace('\\', '/', $savename);
            $driver = Env::get('filesystem.driver', 'public');
            if($driver == 'aliyun') {
                $path     = config('filesystem.disks.aliyun.url') . '/' . $savename;
            } else if($driver == 'qcloud') {
                $path     = config('filesystem.disks.qcloud.cdn') . '/' . $savename;
            } else if($driver == 'qiniu') {
                $path     = config('filesystem.disks.qiniu.url') . '/' . $savename;
            } else {
                $path     = config('app.app_host').config('filesystem.disks.public.url') . '/' . $savename;
            }
            //保存数据库
            $res = FilesService::save([
               'hash'  => $file->hash('sha1'),
               'title' => $file->getOriginalName(),
               'mine' => $file->getOriginalMime(),
               'types' => 2,
               'size' => $file->getSize(),
               'url' => $path,
            ]);
            if (!$res) {
                return json_error(10012);
            }

            return json_ok(['path' => $path]);
        } catch (\think\exception\ValidateException $e) {
            return json_error($e->getMessage());
        }
    }

    /**
     * 上传文件
     * @Route("upfile", method="POST")
     */
    public function upfile()
    {
        $file = request()->file('file');
        if (empty($file)) {
            return json_error(10011);
        }
        try {
            validate(['file' => 'fileSize:10485670|fileExt:pdf|fileMime:application/pdf'])->check(request()->file());
            $savename = \think\facade\Filesystem::putFile('files', $file['file']);
            $savename = str_replace('\\', '/', $savename);
            $driver = Env::get('filesystem.driver', 'public');
            if($driver == 'aliyun') {
                $path     = config('filesystem.disks.aliyun.url') . '/' . $savename;
            } else if($driver == 'qcloud') {
                $path     = config('filesystem.disks.qcloud.cdn') . '/' . $savename;
            } else if($driver == 'qiniu') {
                $path     = config('filesystem.disks.qiniu.url') . '/' . $savename;
            } else {
                $path     = config('app.app_host').config('filesystem.disks.public.url') . '/' . $savename;
            }

            //保存数据库
            $res = FilesService::save([
                'hash'  => $file->hash('sha1'),
                'title' => $file->getOriginalName(),
                'mine' => $file->getOriginalMime(),
                'types' => 3,
                'size' => $file->getSize(),
                'url' => $path,
             ]);
            if (!$res) {
                return json_error(10012);
            }
            return json_ok(['path' => $path]);
        } catch (\think\exception\ValidateException $e) {
            return json_error($e->getMessage());
        }
    }


}
