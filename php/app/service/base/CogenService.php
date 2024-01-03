<?php
declare (strict_types=1);
namespace app\service\base;

use app\traits\ServiceTrait;
use think\facade\Db;

/**
 * 代码生成
 * Class CogenService
 * @package app\service
 * @author  hardphp（2066362155@qq.com）
 */
class CogenService
{
    //模型，带命名空间
    public static $model = 'app\model\base\Cogen';
    //模型主键
    public static $pk = 'id';
    //name字段名称
    public static $name = 'table';
    
    //系统表 不允许生成
    public static $systable = ['tp_admin','tp_app','tp_auth_group','tp_auth_rule','tp_system_config','tp_user','tp_cogen','tp_done_log'];
    
    //模板文件
    public static $modelpath = 'view/cogen/Model.php';
    public static $servicepath = 'view/cogen/Service.php';
    public static $controllerpath = 'view/cogen/Controller.php';
    public static $controllerapipath = 'view/cogen/Api.php';
    public static $controlleruserpath = 'view/cogen/User.php';
    public static $validatepath = 'view/cogen/Validate.php';
    public static $indexpath = 'view/cogen/index.vue';
    public static $editpath = 'view/cogen/edit.vue';
    public static $apipath = 'view/cogen/index.ts';
    public static $apitxtpath = 'view/cogen/api.txt';
    
    // 生成文件
    public static $modelfilepath = 'app/model/cogen/';
    public static $servicefilepath = 'app/service/cogen/';
    public static $controllerfilepath = 'app/admin/controller/cogen/';
    public static $controllerapifilepath = 'app/api/controller/cogen/';
    public static $validatefilepath = 'app/validate/cogen/';
    public static $templatepath = 'view/template/';
    
    

    use ServiceTrait;

     /**
     * 获取数据表
     */
    public static function getTables()
    {
        $table=[];
        $data = Db::query("SHOW TABLES");
        $dbname = env('database.database', '');
        foreach($data as $v){
            if(!in_array($v['Tables_in_'.$dbname],self::$systable)){
                 $table[] =  preg_replace("/tp_/", "", $v['Tables_in_'.$dbname], 1);
            }
        }
        return $table;
    }

    /**
     * 获取数据表注释
     */
    public static function getTableComment($table)
    {
        $dbname = env('database.database', '');
        $data = Db::query('SELECT table_name, table_comment  FROM information_schema.TABLES  WHERE table_schema = "'.$dbname.'" and table_name = "tp_'.$table.'";');
         
        return isset($data[0]['table_comment']) ? $data[0]['table_comment'] : '';
    }

    /**
     * 获取数据表字段
     */
    public static function getTableFields($table)
    {
        $fields=[];
        $data = Db::query("show full COLUMNS FROM tp_".$table);
        foreach($data as $v){
            
            $temp = [];
            $temp['field'] = $v['Field'];
            $temp['type'] = $v['Type'];
            $temp['comment'] = $v['Comment'];
            $fields[] = $temp;
        }

        return $fields;

    }

    /**
     * 获取数据表字段规则
     */
    public static function getFieldRule($table)
    {
        $fields=[];
        $data = Db::query("show full COLUMNS FROM tp_".$table);
        foreach($data as $v){
            if($v['Field'] == 'create_time' || $v['Field'] == 'update_time'){
                continue;
            }
            $temp = [];
            $temp['field'] = $v['Field'];
            $temp['type'] = $v['Type'];
            $temp['comment'] = $v['Comment'];
            $temp['query'] = '';//['=','<>','>','>=','<','<=','like']
            $temp['show'] = '';//['text','textarea','number','radio','select','image','video','file','datetime','date','editor']
            $temp['radio'] = [];
            $temp['select'] = '';
            $temp['option'] = [];

            $fields[] = $temp;
        }

        return $fields;

    }
    
    
    /**
     * 生成代码
     */
    public static function toCode($id)
    {
        $cogen =  Db::name('cogen')->where('id',$id)->find();
        $table = unders_to_camel($cogen['table']);
        $datetime = date('Y-m-d H:i:s',time());
        //1、model
         $modelpath = root_path().self::$modelpath;
         $modelfilepath = root_path().self::$modelfilepath.$table.'.php';
         
         $search = ['{%tableName%}','{%tableComment%}','{%showField%}','{%datetime%}'];
         $replace = [$table,$cogen['comment'],$cogen['show_field'],$datetime];
         $stubContent = file_get_contents($modelpath);
         $content     = str_replace($search, $replace, $stubContent); 
         
         
         file_put_contents($modelfilepath, $content);
         chmod($modelfilepath,0755);
         
         
          //2、Service
         $servicepath = root_path().self::$servicepath;
         $servicefilepath = root_path().self::$servicefilepath.$table.'Service.php';
         
         $search = ['{%tableName%}','{%tableComment%}','{%name%}','{%datetime%}'];
         $replace = [$table,$cogen['comment'],$cogen['name'],$datetime];
         $stubContent = file_get_contents($servicepath);
         $content     = str_replace($search, $replace, $stubContent); 
         
         file_put_contents($servicefilepath, $content);
         chmod($servicefilepath,0755);
         
          //3、Controller
         $controllerpath = root_path().self::$controllerpath;
         $controllerfilepath = root_path().self::$controllerfilepath.$table.'.php';
         
         $searchwhere = "\$where = true;\n";
         
         if($cogen['search']){
             $search = json_decode($cogen['search'],true);
             $field_rule = json_decode($cogen['field_rule'],true);
             foreach ($search as $v){
                 $searchwhere .= str_pad('', 8 ) ."$".$v."    = input('".$v."', '', 'trim');\n";
                 $query = '=';
                 foreach ($field_rule as $v2){
                     if($v2['field'] == $v){
                         $query = $v2['query'];
                     }
                 }
                 
                 $searchwhere .= str_pad('', 8 ) ."if("."$".$v."){\n";
                 if($query == 'like'){
                     $searchwhere .= str_pad('', 12 ) ."\$where .= \" and ".$v." like '%\". ". "$".$v. " .\"%' \" " . ";\n";
                 }else{
                     $searchwhere .=  str_pad('', 12 ) ."\$where .= \" and ".$v." ".$query." \" .". "$".$v. " " . ";\n";
                 }
                 $searchwhere .= str_pad('', 8 ) ."}\n";
             }
         }
         
         $savedata = "";
         if($cogen['form']){
             $form = json_decode($cogen['form'],true);
             if(!in_array('id',$form)){
                 $form[] = 'id';
             }
             
             foreach ($form as $k => $v){
                 
                 $savedata .= str_pad('', 4*($k >0 ? 2 : 0) ) ."\$data['".$v."'] = input('".$v."','','trim');\n";
             }
         }else{
             $savedata = "\$data=[];\n";
         }

         $idkey = "idkey";

         //数据权限
         if($cogen['isauth'] == 1){
            $auth_where = "\$auth_where = AuthGroupService::getDeptAuth(\$this->user->group_id,\$this->user->dept_id,\$this->user->id);\n";
            $auth_where .= str_pad('', 8 ) ."return \$where.\$auth_where;";
         }else{
            $auth_where = str_pad('', 8 ) ."return \$where;";
         }
         
         
         $search = ['{%tableName%}','{%tableComment%}','{%name%}','{%datetime%}','{%groupName%}','{%searchwhere%}','{%idkey%}','{%savedata%}','{%showField%}','{%auth_where%}'];
         $replace = [$table,$cogen['comment'],$cogen['name'],$datetime,strtolower($table),$searchwhere,$idkey,$savedata,$cogen['show_field'],$auth_where];
         $stubContent = file_get_contents($controllerpath);
         $content     = str_replace($search, $replace, $stubContent); 
          
         file_put_contents($controllerfilepath, $content);
         chmod($controllerfilepath,0755);
         
         
         //4、Validate
         $validatepath = root_path().self::$validatepath;
         $validatefilepath = root_path().self::$validatefilepath.$table.'.php';
         
         $rule = "[\n";
         $message = "[\n";
         $savescene = $cogen['form_require'];
         if($cogen['form_require']){
             $form_require = json_decode($cogen['form_require'],true);
             foreach ($form_require as $v){
                 $rule .=  str_pad('', 8 ) ."'".$v."'     => ['require'], \n";
                 $message .=  str_pad('', 8 ) ."'".$v.".require'      => '".$v."必须', \n";
                 
             }
         }
         $rule .= str_pad('', 4 ) ."];\n";
         $message .= str_pad('', 4 ) ."];\n";
        
         $search = ['{%tableName%}','{%tableComment%}','{%rule%}','{%datetime%}','{%message%}','{%savescene%}'];
         $replace = [$table,$cogen['comment'],$rule,$datetime,$message,$savescene];
         $stubContent = file_get_contents($validatepath);
         $content     = str_replace($search, $replace, $stubContent); 
          
         file_put_contents($validatefilepath, $content);
         chmod($validatefilepath,0755);
         
         
         //5、index.vue
         $indexpath = root_path().self::$indexpath;
         $templatepath = root_path().self::$templatepath.strtolower($table).'/index.vue';
         
         $dictDataApi = "";
         $dictDataPost = "";
         $showpage = 1;
         if($cogen['field_rule']){
             $field_rule = json_decode($cogen['field_rule'],true);
             foreach ($field_rule as $v){
                 
                 if($v['field'] == 'pid'){
                     $showpage = 0;
                 }
                 
                 if(isset($v['option'][0]) && $v['option'][0] && isset($v['option'][1]) && $v['option'][1]){
                    $dictDataApi .= "import { getListsIdName as get".strtolower(unders_to_camel($v['option'][0])).$v['option'][1]."ListsIdName } from '/@/api/".strtolower(unders_to_camel($v['option'][0]))."/index';\n";
                    if(isset($v['idkey'][0]) && $v['idkey'][0] && isset($v['idkey'][1]) && $v['idkey'][1]){
                        $dictDataPost .= str_pad('', 4 ) ."get".strtolower(unders_to_camel($v['option'][0])).$v['option'][1]."ListsIdName({field:'".$v['option'][1]."',idkey:'".$v['idkey'][1]."'}).then((response: any) => {
                            state.tableData.dictData.".$v['option'][0].$v['option'][1]." = response.data.data;
                        });\n";
                    }else{
                        $dictDataPost .= str_pad('', 4 ) ."get".strtolower(unders_to_camel($v['option'][0])).$v['option'][1]."ListsIdName({field:'".$v['option'][1]."'}).then((response: any) => {
                            state.tableData.dictData.".$v['option'][0].$v['option'][1]." = response.data.data;
                        });\n";
                    }
                 }
                 
             }
         }
         
         
         $getList = 'getList';
         $responsedata = 'response.data.data';
         
         if($showpage == 0){
            $getList = 'getListAll';
            $responsedata = "handleTree(response.data.data, 'id', 'pid', 'children')";
         }
         
         $dictData = "{\n";
         
         $header = "[\n";
         
         if($cogen['lists']){
             $lists = json_decode($cogen['lists'],true);
             $field_rule = json_decode($cogen['field_rule'],true);
             foreach ($lists as $v){
                 foreach ($field_rule as $v2){
                     if($v == $v2['field']){
                         if($v2['show'] == 'select'){
                             $header .= str_pad('', 8 ) ."{ key: '".$v2['field']."', colWidth: '100', title: '".$v2['comment']."', type: '".$v2['show']."',dict:'".$v2['option'][0].$v2['option'][1]."', isCheck: true },\n";
                             
                             $dictData .= str_pad('', 8 ) ."".$v2['option'][0].$v2['option'][1].":[],\n";
                             
                         }elseif($v2['show'] == 'radio'){
                             $header .= str_pad('', 8 ) ."{ key: '".$v2['field']."', colWidth: '100', title: '".$v2['comment']."', type: '".$v2['show']."',dict:".$v2['radio'].", isCheck: true },\n";
                         }else{
                             $colWidth = 100;
                             if(strpos($v,'name') !== false || strpos($v,'title') !== false){
                                 $colWidth = '';
                             }
                             $header .= str_pad('', 8 ) ."{ key: '".$v2['field']."', colWidth: '".$colWidth."', title: '".$v2['comment']."', type: '".$v2['show']."', isCheck: true },\n";
                         }
                         
                     }
                 }
                
             }
         }
         $header .= str_pad('', 4 ) ."]";
         $dictData .= str_pad('', 4 ) ."}";
         
        $config = "{
        total: 0, // 列表总数
        loading: true, // loading 加载
        isBorder: false, // 是否显示表格边框
        isSerialNo: false, // 是否显示表格序号
        isSelection: true, // 是否显示表格多选
        isOperate: true, // 是否显示表格操作栏
        isAdd: 'admin:cogen".strtolower($table).":save', //新增标识
        isUpdate: 'admin:cogen".strtolower($table).":save', //修改标识
        isDelete: 'admin:cogen".strtolower($table).":del', //删除标识 
    }";
         
         $searchlist = "[\n";
         if($cogen['search']){
             $search = json_decode($cogen['search'],true);
             $field_rule = json_decode($cogen['field_rule'],true);
             foreach ($search as $v){
                 foreach ($field_rule as $v2){
                     if($v2['field'] == $v){
                          if($v2['show'] == 'radio'){
                              $options = "";
                              $radio = json_decode($v2['radio'],true); 
                              foreach($radio as $k =>$v3){
                                  $options .="{ label: '".$v3."', value: ".$k." },";
                              }
                              
                              $searchlist .=str_pad('', 8 ) ."{ label: '".$v2['comment']."', prop: '".$v2['field']."', placeholder: '请选择', required: false, type: 'select',options:[".$options."] },\n";
                          }else{
                              $searchlist .=str_pad('', 8 ) ."{ label: '".$v2['comment']."', prop: '".$v2['field']."', placeholder: '请输入".$v2['comment']."', required: false, type: 'input' },\n";
                          }
                     }
                 }
             }
         }
           
         $searchlist .= str_pad('', 4 ) ."]";
         
         $param = " {
            	page: 1,
            	psize: 10,
            }";
     
          
         $search = ['{%tableName%}','{%dictDataApi%}','{%header%}','{%config%}','{%search%}','{%param%}','{%dictData%}','{%dictDataPost%}','{%showpage%}','{%getList%}','{%responsedata%}'];
         $replace = [strtolower($table),$dictDataApi,$header,$config,$searchlist,$param,$dictData,$dictDataPost,$showpage,$getList,$responsedata];
         $stubContent = file_get_contents($indexpath);
         $content     = str_replace($search, $replace, $stubContent); 
         
        if (!is_dir(dirname($templatepath))) {
            mkdir(dirname($templatepath), 0755, true);
        }
        file_put_contents($templatepath, $content);
        chmod($templatepath,0755);
        
        //6、edit.vue
         $editpath = root_path().self::$editpath;
         $templatepath = root_path().self::$templatepath.strtolower($table).'/form/edit.vue';
         
        $formInput = '';
        $textInput = '';
        $numberInput = '';
        $textareaInput = '';
        $radioInput = '';
        $selectInput = '';
        $imageInput = '';
        $videoInput = '';
        $fileInput = '';
        $datetimeInput = '';
        $editorInput = '';
             
             
         $selectData = "";
         $selectDataApi ='';
         $selectDataPost = '';
        
         if($cogen['field_rule']){
             $field_rule = json_decode($cogen['field_rule'],true);
             foreach ($field_rule as $k=> $v){
                 if($v['field'] == 'id'){
                     continue;
                 }
                 if($v['show'] == 'text'){
                      $textInput .= str_pad('', 4*($k >1 ? 5 : 0) ) .'<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="'.$v['comment'].'" prop="'.$v['field'].'">
							<el-input v-model="state.ruleForm.'.$v['field'].'" placeholder="请输入'.$v['comment'].'" clearable></el-input>
						</el-form-item>
					</el-col>'."\n";
                 }elseif($v['show'] == 'number'){
                     
                     $numberInput .= str_pad('', 4*($k >1 ? 5 : 0) ) .'<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="'.$v['comment'].'" prop="'.$v['field'].'">
							<el-input v-model="state.ruleForm.'.$v['field'].'" placeholder="请输入'.$v['comment'].'" type="number" clearable></el-input>
						</el-form-item>
					</el-col>'."\n";
                     
                     
                 }elseif($v['show'] == 'textarea'){
                     $textareaInput .= str_pad('', 4*($k >1 ? 5 : 0) ) .'<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="'.$v['comment'].'" prop="'.$v['field'].'">
							<el-input v-model="state.ruleForm.'.$v['field'].'" placeholder="请输入'.$v['comment'].'" type="textarea" :rows="2" clearable></el-input>
						</el-form-item>
					</el-col>'."\n";
                     
                 }elseif($v['show'] == 'radio'){
                     
                      $radioInput .= str_pad('', 4*($k >1 ? 5 : 0) ) .'<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="'.$v['comment'].'" prop="'.$v['field'].'">
							<el-radio-group v-model="state.ruleForm.'.$v['field'].'">'."\n";
							
			          $radio = json_decode($v['radio'],true); 
                      foreach($radio as $k2 =>$v2){
                          	$radioInput .= str_pad('', 4*($k >1 ? 6 : 0) ).'		<el-radio :label="'.$k2.'">'.$v2.'</el-radio>'."\n";
                      }
					 $radioInput .= str_pad('', 4*($k >1 ? 6 : 0) ).'	</el-radio-group>
						</el-form-item>
					</el-col>'."\n";
                      
                 }elseif($v['show'] == 'select'){
                        $idkey = $v['idkey'][1] ? $v['idkey'][1]:"id";

                     	$selectInput .= str_pad('', 4*($k >1 ? 5 : 0) ) .'<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20">
						<el-form-item label="'.$v['comment'].'" prop="'.$v['field'].'">
							<el-select v-model="state.ruleForm.'.$v['field'].'" placeholder="请选择" clearable class="mb20">
								<el-option  v-for="item in state.'.$v['option'][0].$v['option'][1].'" :key="item.'.$idkey.'" :label="item.'.$v['option'][1].'" :value="item.'.$idkey.'" ></el-option>
							</el-select>
						</el-form-item>
					</el-col>'."\n";
					
					$selectData .= $v['option'][0].$v['option'][1].":[],\n";
					
					$selectDataApi .="import { getListAll as get".strtolower(unders_to_camel($v['option'][0])).$v['option'][1]." } from '/@/api/".strtolower(unders_to_camel($v['option'][0]))."/index';\n";
					$fileds = "['".$idkey."','".$v['option'][1]."']";
					$selectDataPost .= "get".strtolower(unders_to_camel($v['option'][0])).$v['option'][1]."({fileds:".$fileds."}).then((response: any) => {
		state.".$v['option'][0].$v['option'][1]." = response.data.data;
	});\n";
					
                     
                 }elseif($v['show'] == 'image'){
                     
                     $imageInput .= str_pad('', 4*($k >1 ? 5 : 0) ) .'<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="'.$v['comment'].'" prop="'.$v['field'].'">
							<Uploadimg  v-model="state.ruleForm.'.$v['field'].'" :value="state.ruleForm.'.$v['field'].'"  @upload="onUpload" :msg="state.msg"/>
						</el-form-item>
					</el-col>'."\n";
                     
                 }elseif($v['show'] == 'video'){
                     
                     $videoInput .= str_pad('', 4*($k >1 ? 5 : 0) ) .'<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="'.$v['comment'].'" prop="'.$v['field'].'">
						    <el-input v-model="state.ruleForm.'.$v['field'].'" clearable placeholder="直接输入视频网址或者上传本地视频"/>
							<Uploadvedio  v-model="state.ruleForm.'.$v['field'].'" :value="state.ruleForm.'.$v['field'].'"  @uploadvedio="onUploadvedio"/>
						</el-form-item>
					</el-col>'."\n";
             
                 }elseif($v['show'] == 'file'){
                     
                     
                     
                 }elseif($v['show'] == 'datetime'){
                     
                      $datetimeInput .= str_pad('', 4*($k >1 ? 5 : 0) ) .'<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20" >
								<el-form-item label="'.$v['comment'].'" prop="'.$v['field'].'">
									<el-date-picker v-model="state.ruleForm.'.$v['field'].'"	type="datetime" value-format="YYYY-MM-DD HH:mm:ss" placeholder="请输入'.$v['comment'].'" size="default" />
								</el-form-item>
							</el-col>'."\n";
                     
                 }elseif($v['show'] == 'date'){
                     
                     $datetimeInput .= str_pad('', 4*($k >1 ? 5 : 0) ) .'<el-col :xs="24" :sm="12" :md="12" :lg="12" :xl="12" class="mb20" >
								<el-form-item label="'.$v['comment'].'" prop="'.$v['field'].'">
									<el-date-picker v-model="state.ruleForm.'.$v['field'].'"	type="date" value-format="YYYY-MM-DD" placeholder="请输入'.$v['comment'].'" size="default" />
								</el-form-item>
							</el-col>'."\n";
                     
                 }elseif($v['show'] == 'editor'){
                     
                     $editorInput .= str_pad('', 4*($k >1 ? 5 : 0) ) .'<el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24" class="mb20">
						<el-form-item label="'.$v['comment'].'" prop="hour">
							<Editor v-model:get-html="state.ruleForm.'.$v['field'].'"  />
						</el-form-item>
					</el-col>'."\n";
                 
                 }
                 
             }
         }
         
         if(!$editorInput){
              $formInput = '<el-row :gutter="35">'."\n".$selectInput.$textInput.$datetimeInput.$numberInput.$radioInput.$imageInput.$videoInput.$fileInput.$textareaInput.$editorInput.str_pad('', 4*4 ) ."</el-row>\n";
             
         }else{
             $formInput = '<el-tabs v-model="activeName" class="admin-tabs">'."\n".str_pad('', 4*4 ).'<el-tab-pane label="基础信息" name="first">'."\n".str_pad('', 4*4 ).'<el-row :gutter="35">'."\n".$selectInput.$textInput.$datetimeInput.$numberInput.$radioInput.$imageInput.$videoInput.$fileInput.$textareaInput.str_pad('', 4*4 )."</el-row>\n".str_pad('', 4*4 )."</el-tab-pane>\n".str_pad('', 4*4 ).'<el-tab-pane label="详细信息" name="second">'."\n".str_pad('', 4*4 ).'<el-row :gutter="35">'."\n".$editorInput.str_pad('', 4*4 )."</el-row>\n".str_pad('', 4*4 )."</el-tab-pane>\n".str_pad('', 4*4 )."</el-tabs>\n";
         }
         
         
        
         
      
        $ruleForm = "{\n";
        $setRuleForm = "";
        $initRuleForm = "";
        if($cogen['form']){
            $form = json_decode($cogen['form'],true);
            if(!in_array('id',$form)){
                $form[] = 'id';
            }
            foreach ($form as $k=>$v){
                $ruleForm .= str_pad('', 4)."".$v.":'',\n";
                $setRuleForm .= str_pad('', 3*($k >0 ? 2 : 0) ) ."state.ruleForm.".$v." = response.data.".$v.";\n";
                $initRuleForm .=str_pad('', 2*($k >0 ? 1 : 0) ) . "state.ruleForm.".$v." = '';\n";
            }
        }
        $ruleForm .= str_pad('', 2)."}";
        
        $ruleRules =" { \n";
        if($cogen['form_require']){
            $form_require = json_decode($cogen['form_require'],true);
            foreach ($form_require as $v){
                $ruleRules .= str_pad('', 4)."".$v.": [{ required: true, message: '".$v."不能为空', trigger: 'blur' }],\n";
            }
        }
        $ruleRules .= str_pad('', 2)."}";
        
         
          
         $search = ['{%tableName%}','{%formInput%}','{%selectDataApi%}','{%ruleForm%}','{%selectData%}','{%ruleRules%}','{%setRuleForm%}','{%selectDataPost%}','{%initRuleForm%}'];
         $replace = [strtolower($table),$formInput,$selectDataApi,$ruleForm,$selectData,$ruleRules,$setRuleForm,$selectDataPost,$initRuleForm];
         $stubContent = file_get_contents($editpath);
         $content     = str_replace($search, $replace, $stubContent); 
         
        if (!is_dir(dirname($templatepath))) {
            mkdir(dirname($templatepath), 0755, true);
        }
        file_put_contents($templatepath, $content);
        chmod($templatepath,0755);
        
        
        //7、index.ts
        $apipath = root_path().self::$apipath;
        $templatepath = root_path().self::$templatepath.strtolower($table).'/'.strtolower($table).'/index.ts';
         
         $search = ['{%tableName%}'];
         $replace = ['cogen'.strtolower($table)];
         $stubContent = file_get_contents($apipath);
         $content     = str_replace($search, $replace, $stubContent); 
         
        if (!is_dir(dirname($templatepath))) {
            mkdir(dirname($templatepath), 0755, true);
        }
        file_put_contents($templatepath, $content);
        chmod($templatepath,0755);
        
        
        //8、Controller
        if($cogen['islogin']){
            $controllerapipath = root_path().self::$controlleruserpath;
        }else{
            $controllerapipath = root_path().self::$controllerapipath;
        }
         
         $controllerapifilepath = root_path().self::$controllerapifilepath.$table.'.php';
         
         $searchwhere = "\$where = true;\n";
         
         if($cogen['search']){
             $search = json_decode($cogen['search'],true);
             $field_rule = json_decode($cogen['field_rule'],true);
             foreach ($search as $v){
                 $searchwhere .= str_pad('', 8 ) ."$".$v."    = input('".$v."', '', 'trim');\n";
                 $query = '=';
                 foreach ($field_rule as $v2){
                     if($v2['field'] == $v){
                         $query = $v2['query'];
                     }
                 }
                 
                 $searchwhere .= str_pad('', 8 ) ."if("."$".$v."){\n";
                 if($query == 'like'){
                     $searchwhere .= str_pad('', 12 ) ."\$where .= \" and ".$v." like '%\". ". "$".$v. " .\"%' \" " . ";\n";
                 }else{
                     $searchwhere .=  str_pad('', 12 ) ."\$where .= \" and ".$v." ".$query." \" .". "$".$v. " " . ";\n";
                 }
                 $searchwhere .= str_pad('', 8 ) ."}\n";
             }
         }
         
         $savedata = "";
         if($cogen['form']){
             $form = json_decode($cogen['form'],true);
             if(!in_array('id',$form)){
                 $form[] = 'id';
             }
             
             foreach ($form as $k => $v){
                 
                 $savedata .= str_pad('', 4*($k >0 ? 2 : 0) ) ."\$data['".$v."'] = input('".$v."','','trim');\n";
             }
         }else{
             $savedata = "\$data=[];\n";
         }
         
         
         $search = ['{%tableName%}','{%tableComment%}','{%name%}','{%datetime%}','{%groupName%}','{%searchwhere%}','{%savedata%}','{%showField%}','{%userid%}'];
         $replace = [$table,$cogen['comment'],$cogen['name'],$datetime,strtolower($table),$searchwhere,$savedata,$cogen['show_field'],$cogen['userid']];
         $stubContent = file_get_contents($controllerapipath);
         $content     = str_replace($search, $replace, $stubContent); 
          
         file_put_contents($controllerapifilepath, $content);
         chmod($controllerapifilepath,0755);
         
         
         //9、api.txt
        $apitxtpath = root_path().self::$apitxtpath;
        $templatepath = root_path().self::$templatepath.strtolower($table).'/api.txt';
         
         $listseach = "";
         
         
          if($cogen['search']){
             $search = json_decode($cogen['search'],true);
             $field_rule = json_decode($cogen['field_rule'],true);
             foreach ($search as $v){
                 $listseach .= "";
                 
                 foreach ($field_rule as $v2){
                     if($v2['field'] == $v){
                          $listseach .= $v." : " .$v2['comment'] .";\n";
                     }
                 }
             }
         }
         
         
         $search = ['{%tableName%}','{%datetime%}','{%domain%}','{%listseach%}'];
         $replace = ['cogen'.strtolower($table),$datetime,config('app.app_host'),$listseach,];
         $stubContent = file_get_contents($apitxtpath);
         $content     = str_replace($search, $replace, $stubContent); 
         
        if (!is_dir(dirname($templatepath))) {
            mkdir(dirname($templatepath), 0755, true);
        }
        file_put_contents($templatepath, $content);
        chmod($templatepath,0755);
        
        //10、增加超级管理员权限菜单
        $menu=[
            'name'  => $cogen['comment'].'管理',
            'title'  => $table,
            'parent_id'  => 117,
            'sorts'  => 100,
            'icon'  => 'iconfont icon-zhongduancanshu',
            'path'  => '/cogen/'.strtolower($table),
            'component'  =>'/cogen/'.strtolower($table).'/index',
            'is_iframe'  => 0,
            'is_link'  => 0,
            'menu_type'  => 'menu',
            'is_hide'  => 0,
            'is_keep_alive'=>1,
            'is_affix' => 0,
            'permission'=>'admin:cogen'.strtolower($table).':index',
            'status' => 1,
            'create_time' =>time()
        ];
        
       $has =  Db::name('auth_rule')->where('component','=','/cogen/'.strtolower($table).'/index')->find();
       $group =  Db::name('auth_group')->where('id','=',1)->value('rules');
       $group = explode(',',$group);
       if(isset($has['id']) && $has['id']){
           
           $ids = Db::name('auth_rule')->where(" parent_id = " .$has['id'])->column('id');
           
           $data = [];
           foreach ($group as $v){
               if($v != $has['id'] && !in_array($v,$ids)){
                   $data[] = $v;
               }
           }
            
           Db::name('auth_rule')->where(" id = ".$has['id']." or parent_id = " .$has['id'])->delete();
           Db::name('auth_group')->where('id','=',1)->update([
                   'rules' => implode(',',$data),
                   'update_time' => time()
               ]);
       }
       
       
      $pid =  Db::name('auth_rule')->insertGetId($menu);
      
      $menu1=[
        'name'  => '查看'.$cogen['comment'].'详情',
        'title'  => $table,
        'parent_id'  => $pid,
        'sorts'  => 100,
        'icon'  => 'iconfont icon-zhongduancanshu',
        'path'  => '',
        'component'  =>'',
        'is_iframe'  => 0,
        'is_link'  => 0,
        'menu_type'  => 'btn',
        'is_hide'  => 0,
        'is_keep_alive'=>1,
        'is_affix' => 0,
        'permission'=>'admin:cogen'.strtolower($table).':getinfo',
        'status' => 1,
        'create_time' =>time()
        ];
        $menu2=[
            'name'  => '新增/修改'.$cogen['comment'],
            'title'  => $table,
            'parent_id'  => $pid,
            'sorts'  => 100,
            'icon'  => 'iconfont icon-zhongduancanshu',
            'path'  => '',
            'component'  =>'',
            'is_iframe'  => 0,
            'is_link'  => 0,
            'menu_type'  => 'btn',
            'is_hide'  => 0,
            'is_keep_alive'=>1,
            'is_affix' => 0,
            'permission'=>'admin:cogen'.strtolower($table).':save',
            'status' => 1,
            'create_time' =>time()
        ];
        $menu3=[
            'name'  => '删除'.$cogen['comment'],
            'title'  => $table,
            'parent_id'  => $pid,
            'sorts'  => 100,
            'icon'  => 'iconfont icon-zhongduancanshu',
            'path'  => '',
            'component'  =>'',
            'is_iframe'  => 0,
            'is_link'  => 0,
            'menu_type'  => 'btn',
            'is_hide'  => 0,
            'is_keep_alive'=>1,
            'is_affix' => 0,
            'permission'=>'admin:cogen'.strtolower($table).':del',
            'status' => 1,
            'create_time' =>time()
        ];
     
        $id1 =  Db::name('auth_rule')->insertGetId($menu1);
        $id2 = Db::name('auth_rule')->insertGetId($menu2);
        $id3 =  Db::name('auth_rule')->insertGetId($menu3);
           
         if($pid && $id1 && $id2 && $id3){
             $group[] = $pid;
             $group[] = $id1;
             $group[] = $id2;
             $group[] = $id3;
             
             Db::name('auth_group')->where('id','=',1)->update([
                   'rules' => implode(',',$group),
                   'update_time' => time()
               ]);
             
         }   
        
        return true;
        

    }

    
    
    
    
    
    
    
    /**
     * 生成代码
     */
    public static function getCode($table)
    {
        $table = unders_to_camel($table);
        $modelfilepath = root_path().self::$modelfilepath.$table.'.php';
        $servicefilepath = root_path().self::$servicefilepath.$table.'Service.php';
        $controllerfilepath = root_path().self::$controllerfilepath.$table.'.php';
        $controllerapifilepath = root_path().self::$controllerapifilepath.$table.'.php';
        $validatefilepath = root_path().self::$validatefilepath.$table.'.php';
        $templateindexpath = root_path().self::$templatepath.strtolower($table).'/index.vue';
        $templateeditpath = root_path().self::$templatepath.strtolower($table).'/form/edit.vue';
        $templateapipath = root_path().self::$templatepath.strtolower($table).'/'.strtolower($table).'/index.ts';
        $templateapitxtpath = root_path().self::$templatepath.strtolower($table).'/api.txt';
        
        
        $data['modelfilepath']  = file_get_contents($modelfilepath);
        $data['servicefilepath']  = file_get_contents($servicefilepath);
        $data['controllerfilepath']  = file_get_contents($controllerfilepath);
        $data['controllerapifilepath']  = file_get_contents($controllerapifilepath);
        $data['validatefilepath']  = file_get_contents($validatefilepath);
        $data['templateindexpath']  = file_get_contents($templateindexpath);
        $data['templateeditpath']  = file_get_contents($templateeditpath);
        $data['templateapipath']  = file_get_contents($templateapipath);
        $data['templateapitxtpath']  = file_get_contents($templateapitxtpath);
         
        return $data;
        

    }
    
    
    /**
     * 下载代码
     */
    public static function getCodeZip($table)
    {
        $table = unders_to_camel($table);
        $modelfilepath = root_path().self::$modelfilepath.$table.'.php';
        $servicefilepath = root_path().self::$servicefilepath.$table.'Service.php';
        $controllerfilepath = root_path().self::$controllerfilepath.$table.'.php';
        $controllerapifilepath = root_path().self::$controllerapifilepath.$table.'.php';
        $validatefilepath = root_path().self::$validatefilepath.$table.'.php';
        
        $modelfile = 'php/model/'.$table.'.php';
        $servicefile = 'php/service/'.$table.'Service.php';
        $controllerfile = 'php/controller/'.$table.'.php';
        $controllerapifile = 'php/api/'.$table.'.php';
        $validatefile = 'php/validate/'.$table.'.php';

  
        $zip = new \ZipArchive();
        $zipFileName = root_path().'public/template/'.strtolower($table).date('YmdHis').'.zip';
        if ($zip->open($zipFileName, \ZipArchive::CREATE | \ZipArchive::OVERWRITE) === TRUE) {
            
            
            $filesToCompress = [[$modelfilepath,$modelfile], [$servicefilepath,$servicefile], [$controllerfilepath,$controllerfile],[$validatefilepath,$validatefile],[$controllerapifilepath,$controllerapifile]];
            foreach ($filesToCompress as $file) {
                $zip->addFile($file[0], $file[1]);
            }

            // 添加要压缩的文件夹
            $folderToCompress = root_path().self::$templatepath.strtolower($table);
            $zip->addEmptyDir($folderToCompress);
            
            $files = new \RecursiveIteratorIterator(
                new \RecursiveDirectoryIterator($folderToCompress),
                \RecursiveIteratorIterator::LEAVES_ONLY
            );
            
            foreach ($files as $name => $file) {
                if (!$file->isDir()) {
                    $filePath = $file->getRealPath();
                    $relativePath = 'vue/'.strtolower($table).'/'.substr($filePath, strlen($folderToCompress) + 1);
                    $zip->addFile($filePath, $relativePath);
                }
            }
            // 关闭压缩文件
            $zip->close();
             
        } else {
            echo '无法创建压缩文件！';
        }

        return config('app.app_host').'/template/'.strtolower($table).date('YmdHis').'.zip';
        

    }


}
