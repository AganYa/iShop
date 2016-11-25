<?php
namespace Home\Controller;
use Think\Controller;

class UserController extends Controller {

    public function index(){
      
    }

    public function login(){
       $tel=$_POST["tel"];
       $pwd=$_POST["pwd"];
       // $img=$_POST["img"];
       $user = M("Userinfo");

       $condition["user_phone"]=$tel;
       $condition["user_pwd"]=$pwd;
       // $condition["user_pwd"]=$pwd;
       $data=$user->where($condition)->select();
       if ($data) {
       		$this->ajaxReturn(array("code"=>200,"message"=>"登录成功","data"=>$data[0]),"JSON");
       }else{
       	    $this->ajaxReturn(array("code"=>500,"message"=>"登录失败","data"=>NULL),"JSON");
       }
    }



       public function register(){
        $tel=$_POST["tel"];
        $pwd=$_POST["pwd"];
      
        $user = M("Userinfo");
       

       $data=$user->where("user_phone ='$tel'")->select();
      // var_dump($data);
       if ($data) {
       		$this->ajaxReturn(array("code"=>300,"message"=>"手机号已存在","data"=>$data[0]),"JSON");
       }else{
       	   $newdata["user_phone"]=$tel;
       	   $newdata["user_pwd"]=$pwd;
       	   $result=$user->add($newdata);

       	   if ($result) {
       		         $this->ajaxReturn(array("code"=>200,"message"=>"注册成功","user_id"=>$result),"JSON");
           }
           else{
       	            $this->ajaxReturn(array("code"=>500,"message"=>"手机号已存在"),"JSON");
                
                }
       }

    }

    public function updatapassword(){
       $oldpwd=$_POST["oldpwd"];
       $newpwd=$_POST["newpwd"];
       $userid=$_POST["userid"];
       $user=M("User");

       $condition["user_id"]=$userid;
       $condition["user_password"]=$oldpwd;
       $data=$user->where($condition)->select();
       // var_dump($data);
       if ($data) {
          $newdata["user_id"]=$userid;
          $newdata["user_password"]=$newpwd;

          $result=$user->save($newdata);
          //$result:返回成功修改的记录数
          // var_dump($result);
            if ($result==1) {
              $this->ajaxReturn(array("code"=>200,"message"=>"密码修改成功"),"JSON");
            }
            else{
               $this->ajaxReturn(array("code"=>500,"message"=>"密码修改失败"),"JSON");
            }

       }
       else{

           $this->ajaxReturn(array("code"=>500,"message"=>"原始密码不正确"),"JSON");
       }
    }


      public function uploadimg(){

        $upload = new \Think\Upload();// 实例化上传类
        $upload->maxSize=3145728 ;// 设置附件上传大小
        $upload->exts =array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
        $upload->rootPath=  './images/header/'; // 设置附件上传根目录
        $upload->savePath= ''; // 设置附件上传（子）目录
         // $upload->autoSub=true;
         // $upload->subName="fdg";
        // 上传文件 
        $info   =   $upload->upload();
        if(!$info) {// 上传错误提示错误信息
            $this->error($upload->getError());
        }else{// 上传成功
            // $this->success('上传成功！');
            $userid=$_POST["userid"];

             $user=M("User");
               
             $data["user_id"]=$userid;
           
           
             $data["user_header"]=$info["image"]["savepath"].$info["image"]["savename"];
             //var_dump($data);
             // // $i="sxlsxslxs";
             // //  $img= $data["user_header"];
             // // // $data["user_header"]=$i;
             // //  echo($img);
              // $sql = "update t_user set user_header='22222' where user_id= $userid ";
             // $result = mysql_query($sql);
              // $result=$user->save($data);
            $result = $user->save($data);
             // var_dump($result);

             
             if ($result == 1) {
                $this->ajaxReturn(array("code"=>200,"message"=>"修改头像成功"),"JSON");
             }else{
                 $this->ajaxReturn(array("code"=>500,"message"=>"修改头像失败"),"JSON");
             }
            

        }
    



      }

// public function uploadimg(){
//     $upload = new \Think\Upload();// 实例化上传类
//     $upload->maxSize   =     3145728 ;// 设置附件上传大小
//     $upload->exts      =     array('jpg', 'gif', 'png', 'jpeg');// 设置附件上传类型
//     $upload->rootPath  =     './images/header/'; // 设置附件上传根目录
//     $upload->savePath  =     ''; // 设置附件上传（子）目录
//     // 上传文件 
//     $info   =   $upload->upload();
//     if(!$info) {// 上传错误提示错误信息
//         $this->error($upload->getError());
//     }else{// 上传成功
//        // $this->success('上传成功！');
//          //更新user表中的头像数据
         
//          $userid = $_POST["userid"];

//          $touxiang = M("User");
//          var_dump($info);
//          $ary["user_id"]=$userid;
//          // var_dump('zhangsan'.$info["image"]["savepath"].$info["image"]["savename"]);
//          $ary["user_header"]=$info["image"]["savepath"].$info["image"]["savename"];
         
//          $data = $touxiang->save($ary);
//          if ($data == 1) {
//            $this->ajaxReturn(array("code"=>200,"message"=>"修改成功"),"JSON");
//          }else{
//           $this->ajaxReturn(array("code"=>200,"message"=>"修改失败"),"JSON");
//          }
//     }
//   }

		 



 }