<template>
  <div class="upload-container"  style="width: 80%;">
     <el-link type="success" :underline="false"> 大小不超过10M ;</el-link>
    <el-upload
      :show-file-list="true"
      :action="action"
      :multiple="multiple"
      :name="fileName"
      :accept="accept"
      :limit="limit"
      :file-list="fileList"
      :on-preview="handlePreview"
      :on-exceed="handleExceed"
      :before-upload="beforeUpload"
      :on-progress="onProgress"
      :on-success="handleSuccess"
      :on-error="handleError"
      :on-remove="handleRemove"
    >
    <el-button type="primary">上传附件</el-button>
    </el-upload>


  </div>
</template>

<script lang="ts" setup name="SingleImageUpload">
import { reactive,computed,ref } from 'vue'
import { Plus } from '@element-plus/icons-vue'
import {  ElMessage } from 'element-plus';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['uploadfile']);

// 定义父组件传过来的值
const props = defineProps({
	// 列表内容
	value: {
		type: String,
		default: () => '',
	},
  //文件名称
  fileName: {
		type: String,
		default: () => 'file',
	},
  //文件数量限制
  limit: {
		type: Number,
		default: () => 1,
	},

  //是否多选
  multiple: {
		type: Boolean,
		default: () => true,
	},
  //可选类型
  accept: {
		type: String,
		default: () => '',
	},
  //上传地址
  action: {
		type: String,
		default: () => import.meta.env.VITE_API_URL + '/cron/upload/upfile',
	},
  //展示信息
  msg: {
		type: String,
		default: () => '',
	},
});

 
const fileList = computed(() => {
  const videoarr = []
  if (props.value === '') {
    return [];
  }
  if (props.value != '') {
    const arr = props.value.split(',');
    for (let i = 0; i < arr.length; i++) {
      videoarr.push({ url: arr[i],name: arr[i] });
    }
  }    
  return videoarr;
});

const handleRemove = (file, fileList) => {
  if (fileList.length > 1) {
    const urls = fileList.map( item => { return item.url});
    emit('uploadfile', urls.join(','));
  }else if (fileList.length == 1) {
    emit('uploadfile', fileList[0]['url']);
  } else {
    emit('uploadfile', '');
  }
};

const handlePreview = (file) => {
  window.open(file.url);
  
};
const handleExceed = (files, fileList) => {
  ElMessage.error('最多上传' + props.limit + '个附件');
};

const  beforeUpload = (file) => {
  const isLt5M = file.size / 1024 / 1024 < 10;
  if (!isLt5M) {
    ElMessage.error('上传附件大小不能超过 10MB!');
    return false;
  }
  return isLt5M;
};

const onProgress = (event, file, fileList) => {

};

const handleSuccess = (res, file, fileList)=> {
      if (res.status === 1) {
        for (let i = 0; i < fileList.length; i++) {
          if (fileList[i]['uid'] === file['uid']) {
            fileList[i]['url'] = res.data.path;
            fileList[i]['name'] = res.data.path
            break;
          }
        }
        const urls = [];
        if (fileList.every(item => item.status == 'success')) {
          fileList.map(item => {
            urls.push(item.url);
          });
          emit('uploadfile', urls.join(','));
        }

      } else {
        for (let i = 0; i < fileList.length; i++) {
          if (fileList[i]['uid'] === file['uid']) {
            fileList.splice(i, 1);
            break;
          }
        }
        ElMessage.error(res.msg);
      }
    };

const  handleError = (err, file, fileList) =>{
  ElMessage.error(err);
};


</script>
<style rel="stylesheet/scss" lang="scss">
	
</style>
