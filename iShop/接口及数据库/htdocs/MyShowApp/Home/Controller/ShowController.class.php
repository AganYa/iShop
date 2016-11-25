<?php
namespace Home\Controller;
use Think\Controller;

class ShowController extends Controller {

    public function type(){
       $type=M("Type");
       //添加条件查询
       $data=$type->where("type_id>2")->select();
       //添加规定字段查询
       // $data=$type->field("type_id,tpye_name")->select();
       // var_dump($data);
       if ($data) {
       		$this->ajaxReturn(array("code"=>200,"data"=>$data),"JSON");
       }else{
       	    $this->ajaxReturn(array("code"=>500,"data"=>NULL),"JSON");
       }
    }

    public function show(){
       echo "user login";
    }


    public function cancelcollect(){
	    $userid=$_POST["userid"];
        $showid=$_POST["showid"];
      
        $collect = M("Collect");
       

        $data=$collect->where("user_id =$userid and show_id= $showid")->delete();
     
       if ($data==1) {
       		$this->ajaxReturn(array("code"=>200,"message"=>"取消收藏成功"),"JSON");
       }else{
       	   $this->ajaxReturn(array("code"=>500,"message"=>"取消收藏失败"),"JSON");
       }
	 }

	   public function haha($city,$typeid,$pageindex){
//方法一：join函数
      $show=M("Show");
      $data=$show;
      ->file("t_show.show_name,t_show.show_time,t_place.place_name,t_type.type_name")
      ->join("t_place on t_show.place_id=t_place.place_id")
      ->join("t_type on t_show.type_id=t_type.type_id")
      ->where("t_show.show_place='$cityname' and t_show.type_id='$typeid'")
      ->page("$pageindex,2")
      ->select();
      if ($data) {
                $this->ajaxReturn(array("code"=>200,"data"=>$data),"JSON");
             }else{
                 $this->ajaxReturn(array("code"=>500,"date"=>NULL),"JSON");
             }

// //方式2，使用原生的query执行原生的sql语句
    // $sql = "SELECT t_show.show_id,t_show.show_title,t_show.show_image,
    // t_show.show_price,t_show.show_time,t_show.show_desc FROM t_show,t_place 
    // WHERE t_show.place_id=t_place.place_id and t_show.show_place = '$placename' and type_id = '$typeid'";
    // //添加分页
    // $pageCount = 1;//一页显示多少条
    // $offset = ($pageindex-1)*$pageCount;//偏移量
    //  $sql = $sql."limit $offset,$pageCount";
    //  $model=M();//创建虚拟模型
    //  $data=$model->query($sql);
    // if ($data) {
    //      $this->ajaxReturn(array("code"=>200,"data"=>$data),"JSON");
    //    }
    //    else{
    //      $this->ajaxReturn(array("code"=>500,"data"=>NULL),"JSON");
    //    }
    //方式3：table函数
    // $model=M();
    // $data=$model
    // ->field("a.show_title,a.show_desc")
    // ->table("t_show a,t_type b,t_place c")
    // ->where("a.place_id=c.place_id and a.type_id=b.type_id and a.show_place='$placename' and a.type_id=$typeid")
    // ->page("$pageindex,2")
    // ->select();
    // if ($data) {
    //       $this->ajaxReturn(array("code"=>200,"data"=>$data),"JSON");
    //     }
    //     else{
    //       $this->ajaxReturn(array("code"=>500,"data"=>NULL),"JSON");
    //     }

    }


    }




}