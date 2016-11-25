<?php
namespace Home\Controller;
use Think\Controller;

class GoodsController extends Controller {

    function good(){
     
       $good=M("Goods");
       //添加条件查询
       $data=$good->select();
       
       if ($data) {
       		$this->ajaxReturn(array("code"=>200,"data"=>$data),"JSON");
       }else{
       	    $this->ajaxReturn(array("code"=>500,"data"=>NULL),"JSON");
       }
    }


    function shoes(){
     
       $shoes=M("Goods");
       //添加条件查询
       $data=$shoes->where("type_id=2")->select();
       
       if ($data) {
          $this->ajaxReturn(array("code"=>200,"data"=>$data),"JSON");
       }else{
            $this->ajaxReturn(array("code"=>500,"data"=>NULL),"JSON");
       }
    }


    function Coat(){
     
       $shoes=M("Goods");
       //添加条件查询
       $data=$shoes->where("type_id=3")->select();
       
       if ($data) {
          $this->ajaxReturn(array("code"=>200,"data"=>$data),"JSON");
       }else{
            $this->ajaxReturn(array("code"=>500,"data"=>NULL),"JSON");
       }
    }

    function Pants(){
     
       $shoes=M("Goods");
       //添加条件查询
       $data=$shoes->where("type_id=4")->select();
       
       if ($data) {
          $this->ajaxReturn(array("code"=>200,"data"=>$data),"JSON");
       }else{
            $this->ajaxReturn(array("code"=>500,"data"=>NULL),"JSON");
       }
    }

}
?>