//
//  LoginViewController.m
//  demo-微店
//
//  Created by Agan on 16/9/18.
//  Copyright © 2016年 Agan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AFNetworking.h"

#import "AppDelegate.h"
#import "InfoViewController.h"
#import "CaptchaView.h"
@interface LoginViewController ()<ViewControllerDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    CaptchaView *_captchaView;
    //UITextField *_input;
}
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UITextField *PhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *PassLab;
@property(nonatomic,assign)int ture;
- (IBAction)Login:(UIButton *)sender;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self chuanjian];
    self.ture = 0;
}

-(void)chuanjian
{
    //显示验证码界面
    _captchaView = [[CaptchaView alloc] initWithFrame:CGRectMake(126, 370, 180, 30)];
    _captchaView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:_captchaView];
}

- (void)requestLogin{
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    //必须设置
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *urlPath = [NSString stringWithFormat:login];
    
     NSDictionary *dict = @{@"tel":self.PhoneNumber.text,
                            @"pwd":self.PassLab.text};
    [manager POST:urlPath parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *responseDic = (NSDictionary *)responseObject;
       
        NSString *str = [NSString stringWithFormat:@"%@",[responseDic valueForKey:@"code"]];
       
        if ([str isEqualToString:@"500"]) {
            [self alert:@"手机号未注册，请注册后再登录"];
        }else{
        if ([str isEqualToString:@"200"]) {
           
            
            [self.navigationController popViewControllerAnimated:YES];
            
            APPDELEGATE.user=[UserModel initWithDic:[responseDic valueForKey:@"data"]];
           
            APPDELEGATE.user.userPhone=self.PhoneNumber.text;
            
            APPDELEGATE.user.userId=[[responseDic valueForKey:@"data"] objectForKey:@"user_id"];
            APPDELEGATE.user.userImg=[[responseDic valueForKey:@"data"] objectForKey:@"user_headimg"];
            APPDELEGATE.user.userPwd=[[responseDic valueForKey:@"data"] objectForKey:@"user_pwd"];
          //  NSLog(@"头像：%@",APPDELEGATE.user.userImg);
        }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败，请检查网络!%@",error);
    }];
  
}


- (IBAction)Login:(UIButton *)sender {
    NSLog(@"验证码:%@",_captchaView.changeString);
    if ([self.PhoneNumber.text isEqualToString:@""]) {
        
            [self alert:@"手机号不能为空！"];
    }
        if([self.PassLab.text isEqualToString:@""]){
            [self alert:@"密码不能为空！"];
        }
    
   
        if([self.input.text isEqualToString:@""]){
            [self alert:@"验证码不能为空！"];
        }

     if([_captchaView.changeString isEqualToString:(NSMutableString *)self.input.text]){
         
         [self requestLogin];
         
        }else if(![_captchaView.changeString isEqualToString:(NSMutableString *)self.input.text]){
            [self alert:@"验证码有误！"];
         CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
         anim.repeatCount = 1;
         anim.values = @[@-20, @20, @-20];
         [_captchaView.layer addAnimation:anim forKey:nil];
         [_input.layer addAnimation:anim forKey:nil];
         
     }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Alert方法
-(void)alert:(NSString *)mes{
    UIAlertController *controll = [UIAlertController alertControllerWithTitle:@"提示" message:mes preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];

    [controll addAction:action1];
    [controll addAction:action2];

    [self presentViewController:controll animated:YES completion:nil];
}




@end
