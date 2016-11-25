<?php
namespace Home\Controller;
use Think\Controller;
class AddGoodsCarController extends Controller {

        public function add(){

        $userid=$_POST["userid"];
        $goodsid=$_POST["goodsid"];
      
        $adds = M("Add");
       

       $data=$adds->where("user_id ='$userid' and goods_id='$goodsid'")->select();
    
       if ($data) {
       		$this->ajaxReturn(array("code"=>300,"message"=>"已经加入过购物车","data"=>$data[0]),"JSON");
        }
        else{
       	   $newdata["user_id"]=$userid;
       	   $newdata["goods_id"]=$goodsid;
       	   $result=$adds->add($newdata);

       	   if ($result) {
       		         $this->ajaxReturn(array("code"=>200,"message"=>"加入成功","user_id"=>$result),"JSON");
           }
           else{
       	            $this->ajaxReturn(array("code"=>500,"message"=>"物品已存在"),"JSON");
                
                }
       }


    }






    public function selected(){

       $userid=$_POST["userid"];
      
       $show=M("Add");
       $data=$show
      ->field("t_goods.goods_title,t_goods.goods_price,t_goods.goods_img")
      ->join("t_goods on t_goods.goods_id=t_add.goods_id")
      ->join("t_userinfo on t_userinfo.user_id=t_add.user_id")
      ->where("t_userinfo.user_id='$userid' ")
      ->select();
      if ($data) {
          $this->ajaxReturn(array("code"=>200,"message"=>"查询成功","data"=>$data),"JSON");
        }
        else{

          $this->ajaxReturn(array("code"=>200,"message"=>"查询失败"),"JSON");
  
       }

   }
}
?>