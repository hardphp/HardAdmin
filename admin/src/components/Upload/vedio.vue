<template>
  <div class="upload-container"  style="width: 80%;">
     <el-link type="success" :underline="false"> 视频支持mp4格式；大小不超过1G ;</el-link>
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
    <el-button type="primary">上传视频</el-button>
    </el-upload>

    <el-dialog v-model="dialogVisible" destroy-on-close >
      <video  :src="dialogUrl" width="400" height="300" controls autoplay="true"  />
    </el-dialog>

  </div>
</template>

<script lang="ts" setup name="SingleImageUpload">
import { reactive,computed,ref } from 'vue'
import { Plus } from '@element-plus/icons-vue'
import {  ElMessage } from 'element-plus';

// 定义子组件向父组件传值/事件
const emit = defineEmits(['uploadvedio']);

const dialogUrl = ref('');
const dialogVisible = ref(false);
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
		default: () => 'vedio',
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
		default: () => 'video/mp4',
	},
  //上传地址
  action: {
		type: String,
		default: () => import.meta.env.VITE_API_URL + '/cron/upload/upvedio',
	},
  //展示信息
  msg: {
		type: String,
		default: () => '',
	},
});

 
const fileList = computed(() => {
  const videoarr = []
  if (props.value === '' || props.value == null) {
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
    emit('uploadvedio', urls.join(','));
  }else if (fileList.length == 1) {
    emit('uploadvedio', fileList[0]['url']);
  } else {
    emit('uploadvedio', '');
  }
};

const handlePreview = (file) => {
  dialogUrl.value = file.url!;
  dialogVisible.value = true;
};
const handleExceed = (files, fileList) => {
  ElMessage.error('最多上传' + props.limit + '个视频');
};

const  beforeUpload = (file) => {
  const isIMG = file.type === 'video/mp4' ;
  const isLt5M = file.size / 1024 / 1024 < 2000;
  if (!isIMG) {
    ElMessage.error('上传视频只能是 mp4 格式!');
    return false;
  }
  if (!isLt5M) {
    ElMessage.error('上传视频大小不能超过 100MB!');
    return false;
  }
  return isIMG && isLt5M;
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
          emit('uploadvedio', urls.join(','));
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
